//
//  HTDCameraData.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 11.04.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDCameraData : NSObject

@property (nonatomic, strong) NSMutableArray *areaArray;

@property (nonatomic, strong) NSMutableArray *px1;
@property (nonatomic, strong) NSMutableArray *py1;

@property (nonatomic, strong) NSMutableArray *px2;
@property (nonatomic, strong) NSMutableArray *py2;

@property (nonatomic, strong) NSMutableArray *px3;
@property (nonatomic, strong) NSMutableArray *py3;

@property (nonatomic, strong) NSMutableArray *px4;
@property (nonatomic, strong) NSMutableArray *py4;

@end

NS_ASSUME_NONNULL_END
