//
//  QTTImageUtils.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTImageUtils : NSObject

+ (UIImage *)setImage:(UIImage *)image opacity:(float)opacity;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage *)uniformlyScaleImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage*)imageWithShadowForImage:(UIImage *)initialImage;

+ (UIImage *)roundImageWithOriginImage:(UIImage *)image withDiameter:(CGFloat)diameter;

+ (UIImage *)templateImageWithImage:(UIImage *)oriImage;

+ (UIImage *)maskImage:(UIImage *)image withColor:(UIColor *)maskColor;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)roundedRectImageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius size:(CGSize)size;

+ (UIImage *)resizableHollowRoundedRectImageWithColor:(UIColor *)color
                                         cornerRadius:(CGFloat)radius;

+ (UIImage *)resizableHollowRoundedRectImageWithColor:(UIColor *)color
                                            fillColor:(UIColor *)fillColor
                                         cornerRadius:(CGFloat)radius;

+ (void)calculateBrightnessOfImage:(UIImage *)image completionHandler:(void (^)(double brightness))completionHandler;

@end

NS_ASSUME_NONNULL_END
