//
//  UIImage+QTTUIKit.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QTTUIKit)

+ (UIImage *)qtt_imageNamedInQTTUIKit:(NSString *)imageName;

+ (nullable UIImage *)qtt_backButtonLightImage;
+ (nullable UIImage *)qtt_backButtonDarkImage;
+ (nullable UIImage *)qtt_closeButtonDarkImage;

+ (NSArray<UIImage *> *)qtt_refreshAnimationImages;
+ (NSArray<UIImage *> *)qtt_voicePlayAnimationImages;

/// 获取 LaunchImage 图片
+ (nullable UIImage *)qtt_splashImage;

@end

NS_ASSUME_NONNULL_END
