//
//  DSTremorDetectionSDK.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import "DSTremorDetectionSDK.h"
#import <CoreMotion/CoreMotion.h>

@interface DSTremorDetectionSDK()

@property (nonatomic, assign) NSInteger measurementTime;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation DSTremorDetectionSDK

#pragma mark - Getters / Setters

- (void)setMeasurementTime:(NSInteger)measurementTime {
    _measurementTime = measurementTime;
}

- (NSInteger)getMeasurementTime {
    if (_measurementTime == 0) return 30;
    return _measurementTime;
}

#pragma mark - Lyfe Cycle

- (void)configureWithDelegate:(id)delegate MeasurementTime:(NSInteger)measurementTime {
    self.delegate = delegate;
    self.measurementTime = measurementTime;
}

- (void)startMeasurement {
    NSLog(@"startMeasurement()");
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:[self getMeasurementTime] target:self selector:@selector(onTimerFinished:) userInfo:nil repeats:NO];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .01;
    self.motionManager.gyroUpdateInterval = .01;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        NSLog(@"t: %.2f, x: %.2f, y: %.2f, z: %.2f", accelerometerData.timestamp, accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
        //self.currentAcceleration = accelerometerData.acceleration;
    }];
}

- (void)stopMeasurement {
    NSLog(@"stopMeasurement()");
    
    [self.motionManager stopAccelerometerUpdates];
    [self.delegate onMeasurementCompleted:DSTremorResultUndetermined Accuracy:0];
}

- (void)onTimerFinished:(id)sender {
    NSLog(@"onTimerFinished()");
    
    [self.motionManager stopAccelerometerUpdates];
    [self.delegate onMeasurementCompleted:DSTremorResultUndetermined Accuracy:0];
}

@end
