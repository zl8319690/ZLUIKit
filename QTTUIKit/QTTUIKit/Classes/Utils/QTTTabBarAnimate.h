//
//  QTTTabBarAnimate.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTTabBarAnimate : NSObject

/// UITabBar 底部刷新转圈动画
+ (void)startTabBarRotateAnimation;
+ (void)stopTabBarRotateAnimation;

+ (void)startTabBarRotateAnimationWithVC:(UIViewController *)vc;
+ (void)stopTabBarRotateAnimationWithVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
