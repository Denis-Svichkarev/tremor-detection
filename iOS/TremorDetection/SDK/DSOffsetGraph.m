//
//  DSOffsetGraph.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 05.12.2020.
//

#import "DSOffsetGraph.h"

@implementation DSOffsetGraph {
    NSMutableArray *points;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (points) {
        float newWidth = points.count;
        //NSLog(@"%.2f", newWidth);
        self.frame = CGRectMake(0, 0, newWidth, self.frame.size.height);
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetAllowsAntialiasing(ctx, YES);
        
        CGContextClearRect(ctx, self.bounds);
        CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
        CGContextFillRect(ctx, self.bounds);
        CGContextSetLineWidth(ctx, self.graphLineWidth);
        
        float start = 0;
        float x = 1.0;
        
        float yMax = [self highestValue];
        float yMin = [self lowestValue];
        
        BOOL initialPointDrawn = NO;
        
        CGContextBeginPath(ctx);
        CGContextSetStrokeColorWithColor(ctx, self.graphColor.CGColor);
        
        for (float i = 0; i < points.count; i++) {
            float point = [[points objectAtIndex:i] floatValue];
            
            float val = (point - yMax) / (yMin - yMax);
            val = val - 0.5;
            float newYOffset = self.bounds.size.height / 2 + val * self.bounds.size.height / 2;
            
            if (!initialPointDrawn) {
                if (newYOffset != 0 && newYOffset != INFINITY && newYOffset != -INFINITY) {
                    CGContextMoveToPoint(ctx, start + (i * x), newYOffset);
                    initialPointDrawn = YES;
                }
            } else {
                CGContextAddLineToPoint(ctx, start + (i * x), newYOffset);
            }
        }
        
        CGContextStrokePath(ctx);
    }
}

- (UIImage *)getImage {
    float newWidth = 100;
    
    if (points && points.count > 0 ) {
        newWidth = points.count;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, self.bounds.size.height), NO, 3.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (float)lowestValue {
    float prevValue = INT_MAX;
    
    if (points != nil) {
        for (NSNumber *point in points) {
            if ([point floatValue] < prevValue) {
                prevValue = [point floatValue];
            }
        }
        
        return prevValue;
    }
    
    return 0;
}

- (float)highestValue {
    float prevValue = -1;
    
    if (points != nil) {
        for (NSNumber *point in points) {
            if ([point floatValue] > prevValue) {
                prevValue = [point floatValue];
            }
        }
        
        return prevValue;
    }
    
    return 0;
}

- (void)pointsUpdated:(NSArray *)array {
    if (!points) {
        points = [NSMutableArray new];
    }
    
    if (array.count > 0) {
        [points addObjectsFromArray:array];
    }
    
    float newWidth = 100;
    
    if (points && points.count > 0) {
        newWidth = points.count;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay];
            //[self setNeedsDisplayInRect:CGRectMake(0, 0, newWidth, self.bounds.size.height)];
        });
    });
}

@end
