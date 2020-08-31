//
//  QTTButtonUtils.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTButtonUtils.h"
#import "QTTImageUtils.h"
#import <QTTFoundation/QTTFoundation.h>
#import "QTTColor.h"
#import "QTTFont.h"

CGFloat const QTTButtonSelectedAlpha = 0.5f;

@implementation QTTButtonUtils

+ (UIButton *)roundedButtonWithColor:(UIColor *)color
                       disabledColor:(UIColor *)disabledColor
                        cornerRadius:(CGFloat)radius {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [self setButton:button
        withColor:color
    disabledColor:disabledColor
     cornerRadius:radius];
  
  return button;
}

+ (UIButton *)roundedButtonWithColor:(UIColor *)color {
  return [self roundedButtonWithColor:color cornerRadius:2.0f];
}

+ (UIButton *)roundedButtonWithColor:(UIColor *)color cornerRadius:(CGFloat)radius {
  return [self roundedButtonWithColor:color disabledColor:nil cornerRadius:radius];
}

+ (void)setButton:(UIButton *)button
        withColor:(UIColor *)color
    disabledColor:(UIColor *)disabledColor
     cornerRadius:(CGFloat)radius {
  button.adjustsImageWhenHighlighted = NO;
  button.adjustsImageWhenDisabled = NO;
  CGSize size = CGSizeMake(2 * radius + 1, 2 * radius + 1);
  UIImage *image = [QTTImageUtils roundedRectImageWithColor:color
                                               cornerRadius:radius
                                                       size:size];
  UIEdgeInsets edgesInsets = UIEdgeInsetsMake(radius, radius, radius, radius);
  image = [image resizableImageWithCapInsets:edgesInsets];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  image = [[QTTImageUtils setImage:image
                           opacity:QTTButtonSelectedAlpha]
           resizableImageWithCapInsets:edgesInsets];
  [button setBackgroundImage:image
                    forState:UIControlStateHighlighted];
  [button setBackgroundImage:image
                    forState:UIControlStateSelected];
  disabledColor = disabledColor ?: [QTTColor color9B];
  image = [QTTImageUtils roundedRectImageWithColor:disabledColor
                                      cornerRadius:radius
                                              size:size];
  image = [image resizableImageWithCapInsets:edgesInsets];
  [button setBackgroundImage:image forState:UIControlStateDisabled];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  button.titleLabel.font = FONT(16);
}

+ (UIButton *)hollowRoundedButtonWithTintColor:(UIColor *)tintColor {
  return [self hollowRoundedButtonWithFrame:CGRectZero tintColor:tintColor];
}

+ (UIButton *)hollowRoundedButtonWithTintColor:(UIColor *)tintColor cornerRadius:(CGFloat)cornerRadius {
  return [self hollowRoundedButtonWithFrame:CGRectZero tintColor:tintColor cornerRadius:cornerRadius];
}

+ (UIButton *)hollowRoundedButtonWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor {
  return [self hollowRoundedButtonWithFrame:frame tintColor:tintColor cornerRadius:2.0f];
}

+ (UIButton *)hollowRoundedButtonWithFrame:(CGRect)frame
                                 tintColor:(UIColor *)tintColor
                              cornerRadius:(CGFloat)cornerRadius {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  UIImage *image = [QTTImageUtils resizableHollowRoundedRectImageWithColor:tintColor
                                                              cornerRadius:cornerRadius];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  image = [[QTTImageUtils setImage:image opacity:QTTButtonSelectedAlpha]
           resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius,
                                                        cornerRadius, cornerRadius)];
  [button setBackgroundImage:image forState:UIControlStateHighlighted];
  [button setTitleColor:tintColor forState:UIControlStateNormal];
  [button setTitleColor:[tintColor colorWithAlphaComponent:QTTButtonSelectedAlpha]
               forState:UIControlStateHighlighted];
  button.frame = frame;
  return button;
}

+ (UIButton *)roundedButtonWithBackgroundImage:(UIImage *)image
                        disableBackgroundImage:(UIImage *)disableImage
                     touchAreaExtendEdgeInsets:(UIEdgeInsets)edgeInsets {
  CGSize buttonSize = CGSizeMake(image.size.width + edgeInsets.left + edgeInsets.right,
                                 image.size.height + edgeInsets.top + edgeInsets.bottom);
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.adjustsImageWhenHighlighted = NO;
  button.adjustsImageWhenDisabled = NO;
  [button setImageEdgeInsets:edgeInsets];
  button.bounds = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
  [button setImage:image forState:UIControlStateNormal];
  UIImage *highLightedImage = [QTTImageUtils setImage:image opacity:QTTButtonSelectedAlpha];
  [button setImage:highLightedImage forState:UIControlStateHighlighted];
  [button setImage:disableImage forState:UIControlStateDisabled];
  [button setTitleEdgeInsets:UIEdgeInsetsMake(edgeInsets.top, -image.size.width, edgeInsets.bottom, 0)];
  return button;
}

@end

@implementation UIButton (UIImage)

- (void)qtt_setImage:(UIImage *)image {
  [self setImage:image forState:UIControlStateNormal];
  UIImage *hightLightImage = [[QTTImageUtils setImage:image opacity:QTTButtonSelectedAlpha] resizableImageWithCapInsets:UIEdgeInsetsZero];
  [self setImage:hightLightImage forState:UIControlStateHighlighted];
}


- (void)qtt_setBackgroundImage:(UIImage *)image {
  [self setBackgroundImage:image forState:UIControlStateNormal];
  UIImage *hightLightImage = [[QTTImageUtils setImage:image opacity:QTTButtonSelectedAlpha] resizableImageWithCapInsets:UIEdgeInsetsZero];
  [self setBackgroundImage:hightLightImage forState:UIControlStateHighlighted];
}

@end
