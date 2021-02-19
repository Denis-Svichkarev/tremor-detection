//
//  DSTremorDetectionSDK.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#import "HTDTremorDetectionSDK.h"
#import "HTDOffsetGraph.h"

#include "rt_nonfinite.h"
#include "data_types.h"

#include "classify_action.h"
#include "classify_tremor.h"
#include "classify_action_terminate.h"
#include "classify_tremor_terminate.h"
#include "extract_features_from_raw_data.h"

static HTDClassificationResult * classify(coder::array<double, 2U> features) {
    double input_features[48];
    std::copy(std::begin(features), std::end(features), std::begin(input_features));

    // Action / Motionless

    double action_prob[2];
    cell_wrap_0 action_label;
    
    classify_action(input_features, &action_label, action_prob);

    // Tremor / Movement
    
    double tremor_prob[2];
    cell_wrap_0 tremor_label;
    
    classify_tremor(input_features, &tremor_label, tremor_prob);
    
    // Prediction
    
    std::string predictedClassLabel;
    
    if (action_prob[0] >= action_prob[1]) {
        for (int i = 0; i < tremor_label.f1.size[1]; i++) {
            predictedClassLabel += tremor_label.f1.data[i];
        }
        
    } else {
        for (int i = 0; i < action_label.f1.size[1]; i++) {
            predictedClassLabel += action_label.f1.data[i];
        }
    }
    
    NSString *predictedClassString = [NSString stringWithFormat:@"%s", predictedClassLabel.c_str()];
    
    HTDClassificationType type = HTDClassificationTypeMotionless;
    
    if ([predictedClassString isEqualToString:@"Tremor"]) {
        type = HTDClassificationTypeTremor;
    } else if ([predictedClassString isEqualToString:@"Movement"]) {
        type = HTDClassificationTypeMovement;
    }
    
    HTDClassificationResult *cr = [[HTDClassificationResult alloc] initWithClassificationType:type
                                                                            TremorProbability:tremor_prob[0] * action_prob[0]
                                                                          MovementProbability:tremor_prob[1] * action_prob[0]
                                                                        MotionlessProbability:action_prob[1]];
    
    return cr;
}

// -------------------------------------------- //

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

@property (nonatomic, strong) NSMutableArray *accumulatedXDataArray;
@property (nonatomic, strong) NSMutableArray *accumulatedYDataArray;
@property (nonatomic, strong) NSMutableArray *accumulatedZDataArray;

@end

@implementation HTDTremorDetectionSDK

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userID = @"0";
        self.mode = HTDTremorDetectionSDKModeNormal;
        self.accumulatedXDataArray = [NSMutableArray array];
        self.accumulatedYDataArray = [NSMutableArray array];
        self.accumulatedZDataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Getters

- (NSInteger)getMeasurementTime {
    if (_measurementTime == 0) return 30;
    return _measurementTime;
}

- (HTDTremorDetectionSDKMode)getMode {
    return _mode;
}

#pragma mark - Configurations

- (HTDTremorDetectionSDKError)configureMeasurementTime:(NSInteger)measurementTime {
    if (measurementTime < 20 || measurementTime > 300) {
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

- (void)configureAxisXGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor {
    self.axisXOffsetGraph = [HTDOffsetGraph new];
    self.axisXOffsetGraph.graphColor = lineColor;
    self.axisXOffsetGraph.backgroundColor = backgroundColor;
    self.axisXOffsetGraph.graphLineWidth = 1;
    self.axisXOffsetGraph.frame = frame;
}

- (void)configureAxisYGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor {
    self.axisYOffsetGraph = [HTDOffsetGraph new];
    self.axisYOffsetGraph.graphColor = lineColor;
    self.axisYOffsetGraph.backgroundColor = backgroundColor;
    self.axisYOffsetGraph.graphLineWidth = 1;
    self.axisYOffsetGraph.frame = frame;
}

- (void)configureAxisZGraph:(CGRect)frame LineColor:(UIColor *)lineColor BackgroundColor:(UIColor *)backgroundColor {
    self.axisZOffsetGraph = [HTDOffsetGraph new];
    self.axisZOffsetGraph.graphColor = lineColor;
    self.axisZOffsetGraph.backgroundColor = backgroundColor;
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
        
        /* DATA PROCESSING */
        
        [self.accumulatedXDataArray addObject:@(accelerometerData.acceleration.x)];
        [self.accumulatedYDataArray addObject:@(accelerometerData.acceleration.y)];
        [self.accumulatedZDataArray addObject:@(accelerometerData.acceleration.z)];
        
        int timewindow = 200;
        
        if (self.accumulatedXDataArray.count == timewindow) {
            double *data = new double[timewindow * 3];
              
            for (int i = 0; i < self.accumulatedXDataArray.count; i++) {
                data[i] = [self.accumulatedXDataArray[i] doubleValue];
            }
            
            for (int i = timewindow; i < timewindow + self.accumulatedYDataArray.count; i++) {
                data[i] = [self.accumulatedYDataArray[i - timewindow] doubleValue];
            }
            
            for (int i = 2 * timewindow; i < 2 * timewindow + self.accumulatedZDataArray.count; i++) {
                data[i] = [self.accumulatedZDataArray[i - (2 * timewindow)] doubleValue];
            }
        
            /* CLASSIFICATION */
            
            coder::array<double, 2U> data_features;
            extract_features_from_raw_data(data, timewindow, data_features);

            HTDClassificationResult *classResult = classify(data_features);
            
            if (classResult.classificationType == HTDClassificationTypeTremor) {
                [self.delegate onWarningReceived:HTDTremorWarningTremorDetected];
                
            } else if (classResult.classificationType == HTDClassificationTypeMovement) {
                [self.delegate onWarningReceived:HTDTremorWarningMovementDetected];
                
            } else {
                [self.delegate onWarningReceived:HTDTremorWarningNoWarning];
            }
            
            [self.delegate onClassificationResultUpdated:classResult];
            
            [self.accumulatedXDataArray removeAllObjects];
            [self.accumulatedYDataArray removeAllObjects];
            [self.accumulatedZDataArray removeAllObjects];
        }
        
        /* --------------- */
        
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
