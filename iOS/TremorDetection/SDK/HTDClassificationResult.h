//
//  HTDClassificationResult.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 18.02.2021.
//

#import <Foundation/Foundation.h>
#import "HTDClassificationType.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTDClassificationResult : NSObject

@property (assign, nonatomic) HTDClassificationType classificationType;

@property (assign, nonatomic) double tremorProbability;
@property (assign, nonatomic) double movementProbability;
@property (assign, nonatomic) double motionlessProbability;

- (instancetype)initWithClassificationType:(HTDClassificationType)classificationType
                         TremorProbability:(double)tremorProbability
                       MovementProbability:(double)movementProbability
                     MotionlessProbability:(double)motionlessProbability;

@end

NS_ASSUME_NONNULL_END
