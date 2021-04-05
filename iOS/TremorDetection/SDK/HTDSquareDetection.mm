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
    void find_squares(cv::Mat& image, vector<vector<cv::Point>>& squares)
    {
        cv::Mat bwImage;
        cv::cvtColor(image, bwImage, CV_RGB2GRAY);
        vector< vector<cv::Point> > contours;
        cv::findContours(bwImage, contours, CV_RETR_LIST, CV_CHAIN_APPROX_SIMPLE);
        
        
        cv::Mat gray;
        Canny(bwImage, gray, 10, 20, 3);

        // Dilate helps to remove potential holes between edge segments
        
        cv::Point a(-1, -1);
        cv::dilate(bwImage, gray, cv::Mat(), a);
        
        findContours(gray, contours, RETR_LIST, CHAIN_APPROX_SIMPLE);

                // Test contours
                vector<cv::Point> approx;
                for (size_t i = 0; i < contours.size(); i++)
                {
                        // approximate contour with accuracy proportional
                        // to the contour perimeter
                        approxPolyDP(cv::Mat(contours[i]), approx, arcLength(cv::Mat(contours[i]), true)*0.02, true);

                        // Note: absolute value of an area is used because
                        // area may be positive or negative - in accordance with the
                        // contour orientation
                        if (approx.size() == 4 && fabs(contourArea(cv::Mat(approx))) > 1000 && isContourConvex(cv::Mat(approx)))
                        {
                                double maxCosine = 0;

                                for (int j = 2; j < 5; j++)
                                {
                                    double cosine = fabs(angle(approx[j%4], approx[j-2], approx[j-1]));
                                    maxCosine = MAX(maxCosine, cosine);
                                }

                                if (maxCosine < 0.3)
                                    squares.push_back(approx);
                        }
                }
    }
     
   /*  void find_squares(cv::Mat& image, vector<vector<cv::Point>>& squares)
     {
         cv::Mat bwImage;
         cv::cvtColor(image, bwImage, CV_RGB2GRAY);
         vector< vector<cv::Point> > contours;
         cv::findContours(bwImage, contours, CV_RETR_LIST, CV_CHAIN_APPROX_SIMPLE);
         
//         cv::Mat kernel = getStructuringElement(MORPH_ELLIPSE, cv::Size(11, 11));
//         cv::Mat morph;
//         morphologyEx(image, morph, CV_MOP_CLOSE, kernel);
//
         int rectIdx = 0;
//         vector<vector<cv::Point>> contours;
//         vector<cv::Vec4i> hierarchy;
//         findContours(morph, contours, hierarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0));
         
         vector<cv::RotatedRect> rect( contours.size() );

         for (int i = 0; i < contours.size(); i++)
         {
             rect[i] = cv::minAreaRect( contours[i] );
             
             double areaRatio = abs(cv::contourArea(contours[i])) / (rect[i].size.width * rect[i].size.height);
             if (areaRatio > .95)
             {
                 rectIdx = i;
                 break;
             }
         }
         // get the convexhull of the contour
         vector<cv::Point> hull;
         cv::convexHull(contours[rectIdx], hull, false, true);

         // visualization
         cv::Mat rgb;
         cvtColor(image, rgb, CV_GRAY2BGR);
         drawContours(rgb, contours, rectIdx, cv::Scalar(0, 0, 255), 2);
         
         for(size_t i = 0; i < hull.size(); i++)
         {
             cv::line(rgb, hull[i], hull[(i + 1)%hull.size()], cv::Scalar(0, 255, 0), 2);
         }
     }
    
    void find_squares(cv::Mat& image, vector<vector<cv::Point>>& squares)
    {
        // blur will enhance edge detection
        cv::Mat blurred(image);
        medianBlur(image, blurred, 9);

        cv::Mat gray0(blurred.size(), CV_8U), gray;
        vector<vector<cv::Point> > contours;
        
        // find squares in every color plane of the image
        for (int c = 0; c < 3; c++)
        {
            int ch[] = {c, 0};
            mixChannels(&blurred, 1, &gray0, 1, ch, 1);

            // try several threshold levels
            const int threshold_level = 2;
            for (int l = 0; l < threshold_level; l++)
            {
                // Use Canny instead of zero threshold level!
                // Canny helps to catch squares with gradient shading
                if (l == 0)
                {
                    Canny(gray0, gray, 10, 20, 3); //

                    // Dilate helps to remove potential holes between edge segments
                    
                    cv::Point a(-1, -1);
                    cv::dilate(gray, gray, cv::Mat(), a);
                }
                else
                {
                        gray = gray0 >= (l+1) * 255 / threshold_level;
                }

                // Find contours and store them in a list
                findContours(gray, contours, RETR_LIST, CHAIN_APPROX_SIMPLE);

                // Test contours
                vector<cv::Point> approx;
                for (size_t i = 0; i < contours.size(); i++)
                {
                        // approximate contour with accuracy proportional
                        // to the contour perimeter
                        approxPolyDP(cv::Mat(contours[i]), approx, arcLength(cv::Mat(contours[i]), true)*0.02, true);

                        // Note: absolute value of an area is used because
                        // area may be positive or negative - in accordance with the
                        // contour orientation
                        if (approx.size() == 4 && fabs(contourArea(cv::Mat(approx))) > 1000 && isContourConvex(cv::Mat(approx)))
                        {
                                double maxCosine = 0;

                                for (int j = 2; j < 5; j++)
                                {
                                    double cosine = fabs(angle(approx[j%4], approx[j-2], approx[j-1]));
                                    maxCosine = MAX(maxCosine, cosine);
                                }

                                if (maxCosine < 0.3)
                                    squares.push_back(approx);
                        }
                }
            }
        }
    }*/
    
    // the function draws all the squares in the image
    void drawSquares(cv::Mat& image, const vector<vector<cv::Point> >& squares)
    {
        // blur will enhance edge detection
        cv::Mat blurred(image);
        medianBlur(image, blurred, 9);

        cv::Mat gray0(blurred.size(), CV_8U), gray;
        vector<vector<cv::Point> > contours;
        
        // find squares in every color plane of the image
        for (int c = 0; c < 3; c++)
        {
            int ch[] = {c, 0};
            mixChannels(&blurred, 1, &gray0, 1, ch, 1);
        }
        
        if (squares.size() > 0) {
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

- (UIImage *)detectRect:(UIImage *)image {
    cv::Mat matImage;
    UIImageToMat(image, matImage, true); //[HTDSquareDetection cvMatWithImage:image];
    
    vector<vector<cv::Point>> squares;
    
    vector<cv::Point> square1;
    square1.push_back(cv::Point(50,0));
    square1.push_back(cv::Point(50,100));
    square1.push_back(cv::Point(100,100));
    square1.push_back(cv::Point(100,0));
    squares.push_back(square1);
    
    //squareDetector->find_squares(matImage, squares);
    
    squareDetector->drawSquares(matImage, squares);
    
//    for (size_t i = 0; i < squares.size(); i++) {
//        cout << squares[i] << endl;
//        cout << "__________";
//    }
    
    return MatToUIImage(matImage);
}

#pragma mark - Helpers

+ (cv::Mat)cvMatWithImage:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    size_t numberOfComponents = CGColorSpaceGetNumberOfComponents(colorSpace);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;

    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    CGBitmapInfo bitmapInfo = kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault;

    // check whether the UIImage is greyscale already
    if (numberOfComponents == 1){
        cvMat = cv::Mat(rows, cols, CV_8UC1); // 8 bits per component, 1 channels
        bitmapInfo = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    }

    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,             // Pointer to backing data
                                                cols,                       // Width of bitmap
                                                rows,                       // Height of bitmap
                                                8,                          // Bits per component
                                                cvMat.step[0],              // Bytes per row
                                                colorSpace,                 // Colorspace
                                                bitmapInfo);              // Bitmap info flags

    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);

    return cvMat;
}

@end
