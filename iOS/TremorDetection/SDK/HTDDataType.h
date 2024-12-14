//
//  HTDDataType.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 27.02.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTDDataType) {
    HTDDataTypeAccelerometer,
    HTDDataTypeAudio,
    HTDDataTypeCamera,
    HTDDataTypeRawCamera,
};

NS_ASSUME_NONNULL_END
