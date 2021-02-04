//
//  HTDTremorDetectionSDK.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <Foundation/Foundation.h>
#import "HTDTremorResult.h"
#import "HTDTremorDetectionSDKError.h"
#import "HTDTremorDetectionDelegate.h"
#import "HTDTremorDetectionSDKMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTDTremorDetectionSDK : NSObject

@property (weak, nonatomic) id<HTDTremorDetectionDelegate> delegate;

- (HTDTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime;
- (void)configureMode:(HTDTremorDetectionSDKMode)mode;
- (void)configureUserID:(NSString *)userID;
- (void)configureWithDelegate:(id)delegate;
- (void)configureAxisXGraph:(CGRect)frame;
- (void)configureAxisYGraph:(CGRect)frame;
- (void)configureAxisZGraph:(CGRect)frame;

- (NSInteger)getMeasurementTime;

- (void)startMeasurement;
- (void)stopMeasurement;

- (NSData *)exportData;
- (NSString *)exportFileName;

@end

NS_ASSUME_NONNULL_END
