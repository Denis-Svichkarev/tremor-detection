//
//  DSTremorDetectionDelegate.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.11.2020.
//

#import <UIKit/UIKit.h>

#import "DSTremorDetectionSDK.h"
#import "DSTremorResult.h"
#import "DSTremorStatus.h"
#import "DSTremorWarning.h"

@protocol DSTremorDetectionDelegate <NSObject>

- (void)onProgressUpdated:(NSInteger)percentCompleted;

- (void)onMeasurementCompleted:(DSTremorResult)tremorResult Confidence:(CGFloat)confidence;

- (void)onStatusReceived:(DSTremorStatus)status;

- (void)onWarningReceived:(DSTremorWarning)warning;

@end

