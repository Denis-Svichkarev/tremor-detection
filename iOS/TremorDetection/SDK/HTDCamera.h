//
//  HTDCamera.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.02.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDCamera : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic) NSData *videoData;

+ (HTDCamera *)shared;

- (void)askCameraAccess;

- (void)startMeasuring;
- (void)stopMeasuring;

- (AVCaptureVideoPreviewLayer *)preview:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
