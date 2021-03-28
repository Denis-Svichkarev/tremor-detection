//
//  HTDTremorDetectionDelegate.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.11.2020.
//

#import <UIKit/UIKit.h>

#import "HTDTremorDetectionSDK.h"
#import "HTDTremorResult.h"
#import "HTDTremorStatus.h"
#import "HTDTremorWarning.h"
#import "HTDClassificationResult.h"

@protocol HTDTremorDetectionDelegate <NSObject>

- (void)onProgressUpdated:(NSInteger)percentCompleted;
- (void)onMeasurementCompleted:(HTDTremorResult)tremorResult Confidence:(CGFloat)confidence;
- (void)onStatusReceived:(HTDTremorStatus)status;
- (void)onWarningReceived:(HTDTremorWarning)warning;

- (void)onAxisXOffsetGraphImageUpdated:(UIImage *)image;
- (void)onAxisYOffsetGraphImageUpdated:(UIImage *)image;
- (void)onAxisZOffsetGraphImageUpdated:(UIImage *)image;

- (void)onClassificationResultUpdated:(HTDClassificationResult *)result;

@optional

- (void)onImageWithRectReceived:(UIImage *)image;

@end

