//
//  HTDSquareDetection.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 28.03.2021.
//

#import <Foundation/Foundation.h>
#import "HTDCameraData.h"

#ifdef __cplusplus
#import <opencv2/opencv2.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface HTDSquareDetection : NSObject

@property (nonatomic, strong) HTDCameraData *cameraData;

- (void)reset;
- (UIImage *)detectRect:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
