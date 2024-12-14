//
//  HTDSquareDetection.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 28.03.2021.
//

#import "HTDSquareDetection.h"

#include <opencv2/imgproc/imgproc_c.h>
#include <opencv2/core/types_c.h>
#include <opencv2/imgcodecs/ios.h>

#include <iostream>
#include <math.h>
#include <string.h>

using namespace std;

class SquareDetector {
public:
    void find_squares(cv::Mat& image, vector<vector<cv::Point>>& squares) {
        cv::Mat canny_output;
        Canny(image, canny_output, 100, 100*2 );
        vector<vector<cv::Point> > contours;
        vector<cv::Vec4i> hierarchy;
        
        findContours( canny_output, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE );
        cv::Mat drawing = cv::Mat::zeros( canny_output.size(), CV_8UC3 );
        
        vector<cv::Point> approx;
        
        for (size_t i = 0; i <contours.size(); i++ ) {
            //cv::Scalar color(0, 255, 0);
            //drawContours(drawing, contours, (int)i, color, 2, LINE_8, hierarchy, 0 );
            
            // approximate contour with accuracy proportional
            // to the contour perimeter
            approxPolyDP(cv::Mat(contours[i]), approx, arcLength(cv::Mat(contours[i]), true) * 0.02, true);
            
            // Note: absolute value of an area is used because
            // area may be positive or negative - in accordance with the
            // contour orientation
            if (approx.size() == 4 && fabs(contourArea(cv::Mat(approx))) > 1000 && isContourConvex(cv::Mat(approx))) {
                double maxCosine = 0;

                for (int j = 2; j < 5; j++) {
                    double cosine = fabs(angle(approx[j%4], approx[j-2], approx[j-1]));
                    maxCosine = MAX(maxCosine, cosine);
                }

                if (maxCosine < 0.3)
                    squares.push_back(approx);
            }
        }
        
        image = drawing;
    }
    
    void drawSquares(cv::Mat& image, const vector<vector<cv::Point> >& squares, vector<cv::Point> &maxRect, double &maxArea) {
        cv::Mat gray0(image.size(), CV_8U), gray;
        vector<vector<cv::Point>> contours;
        
        // find squares in every color plane of the image
        for (int c = 0; c < 3; c++)
        {
            int ch[] = {c, 0};
            mixChannels(&image, 1, &gray0, 1, ch, 1);
        }
        
        if (squares.size() > 0) {
            maxRect = squares[0];
        }
        
        for (int i = 0; i < squares.size(); i++) {
            vector<double> x;
            vector<double> y;
            
            for (int j = 0; j < squares[i].size(); j++) {
                x.push_back(squares[i].at(j).x);
                y.push_back(squares[i].at(j).y);
            }
            
            double area = polygonArea(x, y, (int)x.size());
            if (area >= maxArea) {
                maxArea = area;
                maxRect = squares[i];
            }
        }
        
        //cout << maxArea << endl;
        
        if (squares.size() > 1) {
            cv::Mat rgb;
            cvtColor(gray0, rgb, CV_GRAY2BGR);
            
            cv::Scalar color(255, 0, 0);
            
            cv::Point p1(squares[0][0].x, squares[0][0].y);
            cv::Point p2(squares[0][1].x, squares[0][1].y);
            cv::Point p3(squares[0][2].x, squares[0][2].y);
            cv::Point p4(squares[0][3].x, squares[0][3].y);
            
            line(rgb, p1, p2, color, 2, LINE_8);
            line(rgb, p2, p3, color, 2, LINE_8);
            line(rgb, p3, p4, color, 2, LINE_8);
            line(rgb, p4, p1, color, 2, LINE_8);
            
            image = rgb;
        }
    }
    
    // (X[i], Y[i]) are coordinates of i'th point.
    double polygonArea(vector<double> X, vector<double> Y, int n)
    {
        // Initialze area
        double area = 0.0;
     
        // Calculate value of shoelace formula
        int j = n - 1;
        for (int i = 0; i < n; i++)
        {
            area += (X[j] + X[i]) * (Y[j] - Y[i]);
            j = i;  // j is previous vertex to i
        }
     
        // Return absolute value
        return abs(area / 2.0);
    }
    
    // helper function:
    // finds a cosine of angle between vectors
    // from pt0->pt1 and from pt0->pt2
    double angle(cv::Point pt1, cv::Point pt2, cv::Point pt0 )
    {
        double dx1 = pt1.x - pt0.x;
        double dy1 = pt1.y - pt0.y;
        double dx2 = pt2.x - pt0.x;
        double dy2 = pt2.y - pt0.y;
        return (dx1*dx2 + dy1*dy2)/sqrt((dx1*dx1 + dy1*dy1)*(dx2*dx2 + dy2*dy2) + 1e-10);
    }
    
    virtual ~SquareDetector() {}
    
private:
    SquareDetector();
};

@interface HTDSquareDetection() {
    SquareDetector *squareDetector;
}

@end

@implementation HTDSquareDetection

- (void)reset {
    self.cameraData = [[HTDCameraData alloc] init];
    
    self.cameraData.areaArray = [NSMutableArray array];
    self.cameraData.px1 = [NSMutableArray array];
    self.cameraData.py1 = [NSMutableArray array];
    self.cameraData.px2 = [NSMutableArray array];
    self.cameraData.py2 = [NSMutableArray array];
    self.cameraData.px3 = [NSMutableArray array];
    self.cameraData.py3 = [NSMutableArray array];
    self.cameraData.px4 = [NSMutableArray array];
    self.cameraData.py4 = [NSMutableArray array];
}

- (UIImage *)detectRect:(UIImage *)image {
    cv::Mat matImage;
    UIImageToMat(image, matImage, true);
    
    vector<vector<cv::Point>> squares;
    vector<cv::Point> maxRect;
    double maxArea = 0;
    
    squareDetector->find_squares(matImage, squares);
    squareDetector->drawSquares(matImage, squares, maxRect, maxArea);
    
    [self.cameraData.areaArray addObject:@(maxArea)];
    
    if (maxRect.size() == 0) {
        maxRect.push_back(cv::Point(0, 0));
        maxRect.push_back(cv::Point(0, 0));
        maxRect.push_back(cv::Point(0, 0));
        maxRect.push_back(cv::Point(0, 0));
    }
    
    [self.cameraData.px1 addObject:@(maxRect[0].x)];
    [self.cameraData.py1 addObject:@(maxRect[0].y)];
    
    [self.cameraData.px2 addObject:@(maxRect[1].x)];
    [self.cameraData.py2 addObject:@(maxRect[1].y)];
    
    [self.cameraData.px3 addObject:@(maxRect[2].x)];
    [self.cameraData.py3 addObject:@(maxRect[2].y)];
    
    [self.cameraData.px4 addObject:@(maxRect[3].x)];
    [self.cameraData.py4 addObject:@(maxRect[3].y)];
    
//    cout << "Area: " << maxArea << endl;
//
//    if (maxRect.size() > 0) {
//        cout << "AB: " << sqrt(pow(maxRect[1].x - maxRect[0].x, 2) + pow(maxRect[1].y - maxRect[0].y, 2)) << endl;
//        cout << "BC: " << sqrt(pow(maxRect[2].x - maxRect[1].x, 2) + pow(maxRect[2].y - maxRect[1].y, 2)) << endl;
//        cout << "CD: " << sqrt(pow(maxRect[3].x - maxRect[2].x, 2) + pow(maxRect[3].y - maxRect[2].y, 2)) << endl;
//        cout << "DA: " << sqrt(pow(maxRect[0].x - maxRect[3].x, 2) + pow(maxRect[0].y - maxRect[3].y, 2)) << endl;
//    }
//
//    cout << "=============" << endl << endl;

    return [self rotateUIImage:MatToUIImage(matImage) clockwise:YES];
}

#pragma mark - Helpers

- (UIImage *)rotateUIImage:(UIImage*)sourceImage clockwise:(BOOL)clockwise {
    CGSize size = sourceImage.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[sourceImage CGImage] scale:1.0 orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft] drawInRect:CGRectMake(0, 0, size.height, size.width)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
