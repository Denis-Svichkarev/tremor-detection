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

NS_ASSUME_NONNULL_BEGIN

@interface DSTremorDetectionSDK : NSObject

@property (weak, nonatomic) id<DSTremorDetectionDelegate> delegate;

- (DSTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime;
- (void)configureWithDelegate:(id)delegate;

- (void)configureAxisXGraph:(CGRect)frame;
- (void)configureAxisYGraph:(CGRect)frame;
- (void)configureAxisZGraph:(CGRect)frame;

- (NSInteger)getMeasurementTime;

- (void)startMeasurement;
- (void)stopMeasurement;

- (NSData *)exportData;

@end

NS_ASSUME_NONNULL_END
