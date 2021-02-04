//
//  DSTremorDetectionSDK.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#import "HTDTremorDetectionSDK.h"
#import "HTDOffsetGraph.h"

NSString *HRT_LETTERS = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@interface HTDTremorDetectionSDK()

@property (nonatomic, assign) NSInteger measurementTime;
@property (nonatomic, assign) NSInteger currentTime;

@property (nonatomic, assign) CGFloat firstChunkTime;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) HTDOffsetGraph *axisXOffsetGraph;
@property (nonatomic, strong) HTDOffsetGraph *axisYOffsetGraph;
@property (nonatomic, strong) HTDOffsetGraph *axisZOffsetGraph;

@property (nonatomic, strong) NSMutableString *exportDataString;
@property (nonatomic, strong) NSString *measurementID;

@property (nonatomic, assign) HTDTremorDetectionSDKMode mode;
@property (nonatomic, strong) NSString *userID;

@end

@implementation HTDTremorDetectionSDK

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userID = @"0";
        self.mode = HTDTremorDetectionSDKModeNormal;
    }
    return self;
}

#pragma mark - Getters

- (NSInteger)getMeasurementTime {
    if (_measurementTime == 0) return 30;
    return _measurementTime;
}

#pragma mark - Configurations

- (HTDTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime {
    if (measurementTime < 20 || measurementTime > 120) {
        return HTDTremorDetectionSDKErrorInvalidTime;
    }
    
    _measurementTime = measurementTime;
    return HTDTremorDetectionSDKErrorNoError;
}

- (void)configureMode:(HTDTremorDetectionSDKMode)mode {
    self.mode = mode;
}

- (void)configureUserID:(NSString *)userID {
    self.userID = userID;
}

- (void)configureWithDelegate:(id)delegate {
    self.delegate = delegate;
}

- (void)configureAxisXGraph:(CGRect)frame {
    self.axisXOffsetGraph = [HTDOffsetGraph new];
    self.axisXOffsetGraph.graphColor = UIColor.blackColor;
    self.axisXOffsetGraph.backgroundColor = UIColor.clearColor;
    self.axisXOffsetGraph.graphLineWidth = 1;
    self.axisXOffsetGraph.frame = frame;
}

- (void)configureAxisYGraph:(CGRect)frame {
    self.axisYOffsetGraph = [HTDOffsetGraph new];
    self.axisYOffsetGraph.graphColor = UIColor.blackColor;
    self.axisYOffsetGraph.backgroundColor = UIColor.clearColor;
    self.axisYOffsetGraph.graphLineWidth = 1;
    self.axisYOffsetGraph.frame = frame;
}

- (void)configureAxisZGraph:(CGRect)frame {
    self.axisZOffsetGraph = [HTDOffsetGraph new];
    self.axisZOffsetGraph.graphColor = UIColor.blackColor;
    self.axisZOffsetGraph.backgroundColor = UIColor.clearColor;
    self.axisZOffsetGraph.graphLineWidth = 1;
    self.axisZOffsetGraph.frame = frame;
}

#pragma mark - Lyfe Cycle

- (void)startMeasurement {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimerFinished:) userInfo:nil repeats:YES];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .01;
    self.motionManager.gyroUpdateInterval = .01;
    self.firstChunkTime = 0;
    self.currentTime = 0;
    self.exportDataString = [NSMutableString new];
    [self.exportDataString appendString:@"timestamp; x; y; z;\n"];
    
    [self.delegate onStatusReceived:HTDTremorStatusStarted];
    [self.delegate onWarningReceived:HTDTremorWarningNoWarning];
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (self.firstChunkTime == 0) {
            self.firstChunkTime = accelerometerData.timestamp;
        }
        
        CGFloat chunkTimestamp = accelerometerData.timestamp - self.firstChunkTime;
        [self.exportDataString appendString:[NSString stringWithFormat:@"%f; %f; %f; %f;\n", chunkTimestamp, accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z]];
        //NSLog(@"t: %.2f, x: %.2f, y: %.2f, z: %.2f", chunkTimestamp, accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
        //self.currentAcceleration = accelerometerData.acceleration;
        
        if (self.axisXOffsetGraph) {
            [self.axisXOffsetGraph pointsUpdated:@[@(accelerometerData.acceleration.x)]];
        }
        
        if (self.axisYOffsetGraph) {
            [self.axisYOffsetGraph pointsUpdated:@[@(accelerometerData.acceleration.y)]];
        }
        
        if (self.axisZOffsetGraph) {
            [self.axisZOffsetGraph pointsUpdated:@[@(accelerometerData.acceleration.z)]];
        }
    }];
}

- (void)stopMeasurement {
    [self.timer invalidate];
    [self.motionManager stopAccelerometerUpdates];
    [self.delegate onMeasurementCompleted:HTDTremorResultUndetermined Confidence:0];
    [self.delegate onStatusReceived:HTDTremorStatusStopped];
}

- (void)onTimerFinished:(id)sender {
    self.currentTime += 1;
    NSInteger progress = ((CGFloat)self.currentTime / (CGFloat)[self getMeasurementTime]) * 100;
    
    [self.delegate onProgressUpdated:progress];
    
    if (self.axisXOffsetGraph) {
        UIImage *image = [self.axisXOffsetGraph getImage];
        if (image) {
            [self.delegate onAxisXOffsetGraphImageUpdated:image];
        }
    }
    
    if (self.axisYOffsetGraph) {
        UIImage *image = [self.axisYOffsetGraph getImage];
        if (image) {
            [self.delegate onAxisYOffsetGraphImageUpdated:image];
        }
    }
    
    if (self.axisZOffsetGraph) {
        UIImage *image = [self.axisZOffsetGraph getImage];
        if (image) {
            [self.delegate onAxisZOffsetGraphImageUpdated:image];
        }
    }
    
    if (self.currentTime > [self getMeasurementTime]) {
        [self stopMeasurement];
    }
}

#pragma mark - Export

- (NSString *)exportFileName {
    return [self getRawDataFileNameWithVersion:@"1.0"];
}

- (NSData *)exportData {
    if (!self.exportDataString) return nil;
    return [self.exportDataString dataUsingEncoding:NSUTF8StringEncoding];;
}

- (NSString *)getRawDataFileNameWithVersion:(NSString *)version {
    NSDate *currentDate = [NSDate date];
    [self generateMeasurementID];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"YYYY_MM_dd_HH_mm_ss"];
    
    NSString *prefix = self.mode == HTDTremorDetectionSDKModeSimulation ? @"S" : @"";
    NSString *fileFormat = @"csv";
    NSString *fileString = [NSString stringWithFormat:@"%@%@-%@-%@-%@-Apple-%@-%@-%@.%@",
                            prefix,
                            @"T",
                            [self userID],
                            [self getUDID],
                            [self getDeviceModel],
                            [self measurementID],
                            [formatter stringFromDate:currentDate],
                            version,
                            fileFormat];
    return fileString;
}

- (NSString *)getUDID {
    NSString *result = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSRange range = NSMakeRange(0, 3);
    NSString *privacyResult = [result stringByReplacingCharactersInRange:range withString:@"000"];
    return [privacyResult stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
}

- (NSString *)getDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *result = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return result;
}

- (void)generateMeasurementID {
    _measurementID = [self randomStringWithLength:6];
}

- (NSString *)randomStringWithLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [HRT_LETTERS characterAtIndex: arc4random_uniform((uint32_t)[HRT_LETTERS length])]];
    }

    return randomString;
}

@end
