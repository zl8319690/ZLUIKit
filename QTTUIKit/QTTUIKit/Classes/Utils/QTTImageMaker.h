//
//  QTTImageMaker.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTImageMaker : NSObject

/// image fill color
- (QTTImageMaker* _Nonnull (^_Nonnull)(UIColor* _Nonnull imageFillColor))fillColor;
/// image border color
- (QTTImageMaker* _Nonnull (^_Nonnull)(UIColor* _Nonnull imageBorderColor))borderColor;
/// border 的 width, 默认 1 px, 仅当设置了 border color 才有效果
- (QTTImageMaker* _Nonnull (^_Nonnull)(CGFloat imageBorderWidth))borderWidth;
/// corner radius
- (QTTImageMaker* _Nonnull (^_Nonnull)(CGFloat imageCornerRadius))cornerRadius;
/// 透明度, 范围 0 - 1, 会应用在整个 image 上
- (QTTImageMaker* _Nonnull (^_Nonnull)(CGFloat opacity))opacity;

/// 生成 image 返回
- (nonnull UIImage *)make;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

/// API 的入口, 从这里开始进行 chaining 式的 image making
extern QTTImageMaker* _Nonnull qtt_beginImage(CGSize imageSize);

NS_ASSUME_NONNULL_END
