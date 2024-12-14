//
//  HTDAudioPlayer.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 21.02.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDAudioPlayer : NSObject

+ (HTDAudioPlayer *)shared;

- (void)play;
- (void)stop;

- (NSData *)getLastRecord;

@end

NS_ASSUME_NONNULL_END
