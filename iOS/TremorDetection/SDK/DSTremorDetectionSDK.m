//
//  DSTremorDetectionSDK.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

#import "DSTremorDetectionSDK.h"

@interface DSTremorDetectionSDK()

@property (nonatomic, assign) NSInteger measurementTime;
@property (nonatomic, assign) NSInteger currentTime;

@property (nonatomic, assign) CGFloat firstChunkTime;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation DSTremorDetectionSDK

#pragma mark - Getters / Setters

- (DSTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime {
    if (measurementTime < 20 || measurementTime > 120) {
        return DSTremorDetectionSDKErrorInvalidTime;
    }
    
    _measurementTime = measurementTime;
    return DSTremorDetectionSDKErrorNoError;
}

- (NSInteger)getMeasurementTime {
    if (_measurementTime == 0) return 30;
    return _measurementTime;
}

#pragma mark - Lyfe Cycle

- (void)configureWithDelegate:(id)delegate {
    self.delegate = delegate;
}

- (void)startMeasurement {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimerFinished:) userInfo:nil repeats:YES];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .01;
    self.motionManager.gyroUpdateInterval = .01;
    self.firstChunkTime = 0;
    self.currentTime = 0;
    
    [self.delegate onStatusReceived:DSTremorStatusStarted];
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (self.firstChunkTime == 0) {
            self.firstChunkTime = accelerometerData.timestamp;
        }
        
        CGFloat chunkTimestamp = accelerometerData.timestamp - self.firstChunkTime;
        
        NSLog(@"t: %.2f, x: %.2f, y: %.2f, z: %.2f", chunkTimestamp, accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
        //self.currentAcceleration = accelerometerData.acceleration;
    }];
}

- (void)stopMeasurement {
    [self.timer invalidate];
    [self.motionManager stopAccelerometerUpdates];
    [self.delegate onMeasurementCompleted:DSTremorResultUndetermined Confidence:0];
    [self.delegate onStatusReceived:DSTremorStatusStopped];
}

- (void)onTimerFinished:(id)sender {
    self.currentTime += 1;
    NSInteger progress = ((CGFloat)self.currentTime / (CGFloat)[self getMeasurementTime]) * 100;
    
    [self.delegate onProgressUpdated:progress];
    
    if (self.currentTime > [self getMeasurementTime]) {
        [self stopMeasurement];
    }
}

@end
