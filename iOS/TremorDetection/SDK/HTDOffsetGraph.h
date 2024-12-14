//
//  HTDOffsetGraph.h
//  TremorDetection
//
//  Created by Denis Svichkarev on 05.12.2020.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDOffsetGraph : UIView

@property (nonatomic, readwrite) UIColor *backgroundColor;
@property (nonatomic, readwrite) UIColor *graphColor;
@property (nonatomic, readwrite) CGFloat graphLineWidth;

- (void)pointsUpdated:(NSArray *)array;
- (UIImage *)getImage;

@end

NS_ASSUME_NONNULL_END
