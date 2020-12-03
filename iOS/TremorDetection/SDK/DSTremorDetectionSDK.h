//
//  DSTremorDetectionSDK.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <Foundation/Foundation.h>
#import "DSTremorResult.h"
#import "DSTremorDetectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSTremorDetectionSDK : NSObject

@property (weak, nonatomic) id<DSTremorDetectionDelegate> delegate;

- (void)setMeasurementTime:(NSInteger)measurementTime;
- (NSInteger)getMeasurementTime;

- (void)configureWithDelegate:(id)delegate MeasurementTime:(NSInteger)measurementTime;
- (void)startMeasurement;
- (void)stopMeasurement;

@end

NS_ASSUME_NONNULL_END
