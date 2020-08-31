//
//  QTTButtonUtils.h
//  QTTUIKit
//
//  Created by XIN on 2019/8/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const QTTButtonSelectedAlpha;

NS_ASSUME_NONNULL_BEGIN

@interface QTTButtonUtils : NSObject

+ (UIButton *)roundedButtonWithColor:(UIColor *)color;

+ (UIButton *)roundedButtonWithColor:(UIColor *)color
                        cornerRadius:(CGFloat)radius;

+ (UIButton *)roundedButtonWithColor:(UIColor *)color
                       disabledColor:(nullable UIColor *)disabledColor
                        cornerRadius:(CGFloat)radius;

+ (void)setButton:(UIButton *)button
        withColor:(UIColor *)color
    disabledColor:(UIColor *)disabledColor
     cornerRadius:(CGFloat)radius;

///hollowRounded  为中空，描边样式
+ (UIButton *)hollowRoundedButtonWithTintColor:(UIColor *)tintColor;

+ (UIButton *)hollowRoundedButtonWithTintColor:(UIColor *)tintColor cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)hollowRoundedButtonWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor;

+ (UIButton *)hollowRoundedButtonWithFrame:(CGRect)frame
                                 tintColor:(UIColor *)tintColor
                              cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)roundedButtonWithBackgroundImage:(UIImage *)image
                        disableBackgroundImage:(nullable UIImage *)disableImage
                     touchAreaExtendEdgeInsets:(UIEdgeInsets)edgeInsets;

@end

@interface UIButton (UIImage)

/**
 * 设置 UIControlStateNormal 图片
 * 同时设置 UIControlStateHighlighted 0.6透明度效果
 */
- (void)qtt_setImage:(UIImage *)image;


- (void)qtt_setBackgroundImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
