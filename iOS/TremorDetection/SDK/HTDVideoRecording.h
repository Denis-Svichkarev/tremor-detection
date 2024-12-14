//
//  HTDVideoRecording.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 26.02.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDVideoRecording : NSObject

+ (UIImage *)addBufferImages:(CMSampleBufferRef)sampleBuffer toArray:(NSMutableArray *)bufferImagesArray;

+ (void)writeImageAsMovie:(NSArray *)array size:(CGSize)size CompletionHandler:(void(^)(BOOL success, NSData *data, NSURL *path))completion;


@end

NS_ASSUME_NONNULL_END
