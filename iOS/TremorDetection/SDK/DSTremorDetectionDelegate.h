//
//  DSTremorDetectionDelegate.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.11.2020.
//

#import <UIKit/UIKit.h>

#import "DSTremorDetectionSDK.h"
#import "DSTremorResult.h"

@protocol DSTremorDetectionDelegate <NSObject>

- (void)onProgressUpdated:(NSInteger)percentCompleted;

- (void)onMeasurementCompleted:(DSTremorResult)tremorResult Accuracy:(CGFloat)accuracy;

@end

