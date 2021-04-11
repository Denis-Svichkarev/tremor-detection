//
//  HTDCamera.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.02.2021.
//

#import "HTDCamera.h"
#import "HTDVideoRecording.h"
#import "HTDSquareDetection.h"

@interface HTDCamera()

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *currentDevice;
@property (strong, nonatomic) NSMutableArray *bufferImagesArray;

@property (strong, nonatomic) HTDSquareDetection *squareDetection;

@end

@implementation HTDCamera

#pragma mark - Life Cycle

+ (HTDCamera *)shared {
    static HTDCamera *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance = [[HTDCamera alloc] init];
        sharedInstance.squareDetection = [[HTDSquareDetection alloc] init];
    });
    return sharedInstance;
}

- (void)askCameraAccess {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusAuthorized) {
        [self createSession];
            
    } else if (authStatus == AVAuthorizationStatusDenied) {
 
    } else if (authStatus == AVAuthorizationStatusRestricted) {

    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self createSession];
                
            } else {}
        }];
    } else {}
}

- (void)createSession {
    self.session = [[AVCaptureSession alloc] init];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.currentDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureInput *cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.currentDevice error:&error];
    
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t captureQueue=dispatch_queue_create("captureQueue", DISPATCH_QUEUE_SERIAL);

    [videoOutput setSampleBufferDelegate:self queue:captureQueue];
    [videoOutput setAlwaysDiscardsLateVideoFrames:NO];
    
    videoOutput.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], (id)kCVPixelBufferPixelFormatTypeKey, nil];
    
    [self.session setSessionPreset:AVCaptureSessionPresetLow];
    
    [self.session addInput:cameraInput];
    [self.session addOutput:videoOutput];
}

#pragma mark - Properties

- (AVCaptureVideoPreviewLayer *)preview:(CGRect)frame {
    self.previewLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    return self.previewLayer;
}

- (BOOL)isRunning {
    return self.session.isRunning;
}

#pragma mark - Measurement

- (void)startMeasuring {
    [self.squareDetection reset];
    self.bufferImagesArray = [NSMutableArray array];
    
    [self.currentDevice lockForConfiguration:nil];
    [self.session beginConfiguration];
    
    [self.currentDevice setActiveVideoMinFrameDuration:CMTimeMake(1, 30)];
    [self.currentDevice setActiveVideoMaxFrameDuration:CMTimeMake(1, 30)];
    
    [self.session commitConfiguration];
    [self.currentDevice unlockForConfiguration];
    
    [self.session startRunning];
    
    [self.currentDevice lockForConfiguration:nil];
    [self.session beginConfiguration];
    [self.currentDevice setTorchMode:AVCaptureTorchModeOn];
    [self.session commitConfiguration];
    [self.currentDevice unlockForConfiguration];
    
    dispatch_async(dispatch_get_main_queue(), ^{;
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    });
}

- (void)stopMeasuring {
    if (self.session.isRunning) {
        [self.session stopRunning];
               
        if (self.delegate && [self.delegate respondsToSelector:@selector(onCameraDataReceived:)]) {
            [self.delegate onCameraDataReceived:self.squareDetection.cameraData];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [HTDVideoRecording writeImageAsMovie:self.bufferImagesArray size:CGSizeMake([self getFrameResolution].width, [self getFrameResolution].height) CompletionHandler:^(BOOL success, NSData *data, NSURL *path) {
                if (success) {
                    self.videoData = data;
                }
            }];
        });
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    UIImage *image = [HTDVideoRecording addBufferImages:sampleBuffer toArray:self.bufferImagesArray];
    UIImage *imageWithRect = [self.squareDetection detectRect:image];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onImageWithRectReceived:)]) {
        [self.delegate onImageWithRectReceived:imageWithRect];
    }
}

#pragma mark - Configurations

- (CGSize)getFrameResolution {
    CGSize resolution = CGSizeMake(0, 0);
    CMFormatDescriptionRef formatDescription = self.currentDevice.activeFormat.formatDescription;
    CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription);
    resolution.width = dimensions.width;
    resolution.height = dimensions.height;
    return resolution;
}

@end
