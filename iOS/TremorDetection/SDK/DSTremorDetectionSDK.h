//
//  DSTremorDetectionSDK.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <Foundation/Foundation.h>
#import "DSTremorResult.h"
#import "DSTremorDetectionSDKError.h"
#import "DSTremorDetectionDelegate.h"
#import "DSTremorDetectionSDKMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSTremorDetectionSDK : NSObject

@property (weak, nonatomic) id<DSTremorDetectionDelegate> delegate;

- (DSTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime;
- (void)configureMode:(DSTremorDetectionSDKMode)mode;
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
