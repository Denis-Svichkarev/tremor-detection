//
//  HTDClassificationResult.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 18.02.2021.
//

#import "HTDClassificationResult.h"

@implementation HTDClassificationResult

- (instancetype)initWithClassificationType:(HTDClassificationType)classificationType
                         TremorProbability:(double)tremorProbability
                       MovementProbability:(double)movementProbability
                     MotionlessProbability:(double)motionlessProbability {
    
    self = [super init];
    
    if (self) {
        self.classificationType = classificationType;
        self.tremorProbability = tremorProbability;
        self.movementProbability = movementProbability;
        self.motionlessProbability = motionlessProbability;
    }
    
    return self;
}

@end
