//
//  QTTTabBarAnimate.m
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTTabBarAnimate.h"

static NSString * const QTTTabBarRefreshTitle = @"刷新";

@implementation QTTTabBarAnimate

+ (UIImageView *)getImageViewWithTitle:(NSString *)title {
  UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
  UITabBarController *tabBarController = nil;
  if ([rootController isKindOfClass:UITabBarController.class]) {
    tabBarController = (UITabBarController *)rootController;
  }
  UITabBar *tabBar = tabBarController.tabBar;
  for (id item in tabBar.subviews ) {
    if ([item isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
      if ([title isEqualToString:((UILabel*)[item valueForKey:@"label"]).text]) {
        return [item valueForKey:@"info"];
      }
    }
  }
  return nil;
}

+ (void)startTabBarRotateAnimation {
  UIImageView *imageView = [self getImageViewWithTitle:QTTTabBarRefreshTitle];
  CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  animation.fromValue = [NSNumber numberWithFloat:0.f];
  animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
  animation.duration  = 1;
  animation.fillMode =kCAFillModeForwards;
  animation.repeatCount = 60;
  [imageView.layer addAnimation:animation forKey:@"bar_transform"];
}

+ (void)stopTabBarRotateAnimation {
  UIImageView *imageView = [self getImageViewWithTitle:QTTTabBarRefreshTitle];
  [imageView.layer removeAnimationForKey:@"bar_transform"];
}

+ (void)startTabBarRotateAnimationWithVC:(UIViewController *)vc {
  UIImageView *imgV = [self getTabBarButtonImageViewWithCurrentVC:vc];
  if (imgV) {
    [imgV.layer addAnimation:self.rotationAnimation forKey:@"bar_transform"];
  }
}

+ (void)stopTabBarRotateAnimationWithVC:(UIViewController *)vc {
  UIImageView *imgV = [self getTabBarButtonImageViewWithCurrentVC:vc];
  if (imgV) {
    if ([imgV.layer animationForKey:@"bar_transform"]) {
      [imgV.layer removeAnimationForKey:@"bar_transform"];
    }
  }
}

+ (UIImageView *)getTabBarButtonImageViewWithCurrentVC:(UIViewController *)vc {
  UIControl *tabBarButton = [vc.tabBarItem valueForKey:@"view"];
  if (tabBarButton) {
    if ([tabBarButton respondsToSelector:@selector(imageView)]) {
      UIImageView *imageV = [tabBarButton valueForKey:@"imageView"];
      if (imageV) {
        return imageV;
      }
    }
  }
  return nil;
}

+ (CABasicAnimation *)rotationAnimation {
  CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
  rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
  rotationAnimation.duration = 0.7;
  rotationAnimation.repeatCount = HUGE_VALF;
  rotationAnimation.removedOnCompletion = NO;
  return rotationAnimation;
}

@end
