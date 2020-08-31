//
//  KDDLayoutDefine.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UI 出设计图的基准机型, 用于将标注尺寸等比缩放
typedef NS_ENUM(NSUInteger, KDDScaleReferenceDevice) {
  /// UI 以 iPhone 6 为基准的标注
  KDDScaleReferenceDevice6,
  /// UI 以 iPhone 4 为基准的标注
  KDDScaleReferenceDevice4,
};

/**
 满足 UI 在一些尺寸上根据某机型等比缩放的需求, 这个是根据屏幕宽度.
 
 @param originalValue   UI 给的标注值
 @param referenceDevice UI 用来设计的参考机型
 
 @return 以参考机型为基准, 将标注值根据屏幕宽度等比缩放后的数值
 */
extern CGFloat KDDHorizontallyScaledValue(CGFloat originalValue, KDDScaleReferenceDevice referenceDevice);

/**
 Horiz -> 以屏幕宽度为基准
 
 6 -> 以 iPhone 6 的尺寸为基准
 
 KDDHorizScale6 -> 以 iPhone 6 的尺寸为基准, 按本设备和 iPhone 6 屏幕宽度的比例缩放所给的 value. 也就是 originalValue * DEVICE_FULL_SIZE_WIDTH / 375
 */
extern CGFloat KDDHorizScale6(CGFloat originalValue);

/**
 满足 UI 在一些尺寸上根据某机型等比缩放的需求, 这个是根据屏幕高度.
 
 @param originalValue   UI 给的标注值
 @param referenceDevice UI 用来设计的参考机型
 
 @return 以参考机型为基准, 将标注值根据屏幕高度等比缩放后的数值
 */
extern CGFloat KDDVerticallyScaledValue(CGFloat originalValue, KDDScaleReferenceDevice referenceDevice);

/**
 Vert -> 以屏幕高度为基准
 
 6 -> 以 iPhone 6 的尺寸为基准
 
 KDDVertScale6 -> 以 iPhone 6 的尺寸为基准, 按本设备和 iPhone 6 屏幕高度的比例缩放所给的 value. 也就是 originalValue * DEVICE_FULL_SIZE_HEIGHT / 667
 */
extern CGFloat KDDVertScale6(CGFloat originalValue);

/**
 获取全局的渐变色图片
 
 @return 屏幕宽 x 1 的渐变色图片
 */
extern UIImage* _Nonnull KDDGradientImage(UIColor *startColor, UIColor*endColor, CGSize size);

/**
 获取期望大小的全局渐变色图片
 
 @param size 期望的大小
 @return 指定 size 的渐变色图片
 */
extern UIImage* _Nonnull KDDGradientImageWithSize(CGSize size);

NS_ASSUME_NONNULL_END
