//
//  UIViewController+QTTExt.h
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QTTViewController;

@interface UIViewController (QTTExt)

/// 返回最上层可见的 view controller
/// @warning 返回的 view controller 是任意 UIViewController, 并不一定是 QTTViewController, 不要使用 QTTViewController 才有的 api
/// @return 最上层可见的 view controller
+ (UIViewController *)qtt_visiableViewController NS_EXTENSION_UNAVAILABLE_IOS("");

/// 返回最上层的 QTTViewController
/// @warning 返回的肯定是 QTTViewController, 但不一定是在视图栈的最上层, 如果这个 QTTViewController 已经
/// present 了其他的 UIViewController, 那么再对这个 QTTViewController 调用 presentViewController 方法
/// 是没有效果的
/// @return 最上层的 QTTViewController
+ (nullable QTTViewController *)qtt_topQTTViewController NS_EXTENSION_UNAVAILABLE_IOS("");

@end

NS_ASSUME_NONNULL_END
