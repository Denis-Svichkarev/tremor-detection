//
//  HTDTremorDetectionSDK.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>
#import "HTDTremorResult.h"
#import "HTDTremorDetectionSDKError.h"
#import "HTDTremorDetectionDelegate.h"
#import "HTDTremorDetectionSDKMode.h"
#import "HTDDataType.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTDTremorDetectionSDK : NSObject

@property (weak, nonatomic) id<HTDTremorDetectionDelegate> delegate;

- (void)askCameraAccess;

- (HTDTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime;
- (void)configureMode:(HTDTremorDetectionSDKMode)mode;
- (void)configureUserID:(NSString *)userID;
- (void)configureWithDelegate:(id)delegate;
- (void)configureAxisXGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor;
- (void)configureAxisYGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor;
- (void)configureAxisZGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor;

- (NSInteger)getMeasurementTime;
- (HTDTremorDetectionSDKMode)getMode;

- (void)startMeasurement;
- (void)stopMeasurement;
- (void)abortMeasurement;

- (NSString *)exportFileName:(HTDDataType)dataType;
- (NSData *)accelerometerData;
- (NSData *)audioData;
- (nullable NSData *)cameraData;

@end

NS_ASSUME_NONNULL_END
