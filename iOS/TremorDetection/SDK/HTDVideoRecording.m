//
//  HTDVideoRecording.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.02.2021.
//

#import <Photos/Photos.h>

#import "HTDVideoRecording.h"

@implementation HTDVideoRecording

+ (UIImage *)addBufferImages:(CMSampleBufferRef)sampleBuffer toArray:(NSMutableArray *)bufferImagesArray {
    if (@available(iOS 10.0, *)) {
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer,0);
        uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGImageRef newImage = CGBitmapContextCreateImage(newContext);
        CGContextRelease(newContext);
        CGColorSpaceRelease(colorSpace);
        
        UIImage *image = [UIImage imageWithCGImage:newImage scale:0.1 orientation:UIImageOrientationUp];
        
        [bufferImagesArray addObject:image];
        CGImageRelease(newImage);
        
        return image;
    }
    
    return nil;
}

+ (void)writeImageAsMovie:(NSArray *)array size:(CGSize)size CompletionHandler:(void(^)(BOOL success, NSData *data, NSURL *path))completion {
    if (@available(iOS 10.0, *)) {
    //    if (!userLibraryPermissionAuthorized) {
    //        [bufferImagesArray removeAllObjects];
    //        return;
    //    }

        if (array.count == 0)
            return;

        NSError *error = nil;

    //    NSDate *now = [NSDate date];
    //    NSDateFormatter *h4hFormatter = [[NSDateFormatter alloc] init];
    //    [h4hFormatter setDateFormat:@"MMddHHmmss"];
    //    NSString *currentDate = [h4hFormatter stringFromDate:now];
    //
    //    NSString *videoNameString = [NSString stringWithFormat:@"%@.mp4", currentDate];

        NSString *videoNameString = [NSString stringWithFormat:@"hrt-measurement-video.mp4"];
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:videoNameString];

        if (path) {
            if ([fileMgr removeItemAtPath:path error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        }

        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        [attributes setObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32ARGB] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
        [attributes setObject:[NSNumber numberWithUnsignedInt:size.width] forKey:(NSString *)kCVPixelBufferWidthKey];
        [attributes setObject:[NSNumber numberWithUnsignedInt:size.height] forKey:(NSString *)kCVPixelBufferHeightKey];

        AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:path] fileType:AVFileTypeQuickTimeMovie error:&error];
        NSParameterAssert(videoWriter);

        NSDictionary *videoSettings;
        
        if (@available(iOS 11.0, *)) {
            videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                             AVVideoCodecTypeH264, AVVideoCodecKey, [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                             [NSNumber numberWithInt:size.height], AVVideoHeightKey, nil];
        } else {
            videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                             AVVideoCodecH264, AVVideoCodecKey, [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                             [NSNumber numberWithInt:size.height], AVVideoHeightKey, nil];
        }

        AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
        AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:attributes];

        NSParameterAssert(writerInput);
        NSParameterAssert([videoWriter canAddInput:writerInput]);
        [videoWriter addInput:writerInput];

        [videoWriter startWriting];
        [videoWriter startSessionAtSourceTime:kCMTimeZero];

        CVPixelBufferRef buffer = NULL;
        if (@available(iOS 10.0, *)) {
            buffer = [HTDVideoRecording pixelBufferFromCGImage:[[array objectAtIndex:0] CGImage] size:size];
        } else {
            // Fallback on earlier versions
        }
        [adaptor appendPixelBuffer:buffer withPresentationTime:kCMTimeZero];

        for (int i = 0; i < array.count; i++) {
            if ([writerInput isReadyForMoreMediaData]) {
                CMTime frameTime = CMTimeMake(1, 30);
                CMTime lastTime = CMTimeMake(i, 30);
                CMTime presentTime = CMTimeAdd(lastTime, frameTime);

                buffer = [HTDVideoRecording pixelBufferFromCGImage:[[array objectAtIndex:i] CGImage] size:size];
                [adaptor appendPixelBuffer:buffer withPresentationTime:presentTime];

                if (buffer)
                    CVBufferRelease(buffer);
            }
            else {
                i--;
            }
        }

        [writerInput markAsFinished];
        [videoWriter finishWritingWithCompletionHandler:^{
            NSURL *pathURL = [NSURL fileURLWithPath:path];;
            NSLog(@"%@", pathURL.absoluteString);
            
            NSString *path = [pathURL.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];

            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfFile:path options: 0 error: &error];

            if (data == nil) {
               NSLog(@"Failed to read file, error %@", error);
            }
            
            completion(YES, data, pathURL);
            
            // Save to Camera roll
            
    //        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    //            PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:pathURL];
    //            [request placeholderForCreatedAsset];
    //
    //        } completionHandler:^(BOOL success, NSError * _Nullable error) {
    //            if (success) {
    //                NSLog(@"Success");
    //                completion(YES, data, pathURL);
    //
    //            } else {
    //                NSLog(@"Fail");
    //                completion(NO, data, nil);
    //            }
    //        }];
        }];

        CVPixelBufferPoolRelease(adaptor.pixelBufferPool);
        
    } else {
        completion(NO, nil, nil);
    }
}

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size {
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, size.width, size.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options, &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width, size.height, 8, 4 * size.width, rgbColorSpace, kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    //CGContextTranslateCTM(context, size.width / 2, size.height / 2);
    //CGContextRotateCTM(context, 3 * M_PI_2);
    //CGContextTranslateCTM(context, -size.height / 2, -size.width / 2);
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

@end
