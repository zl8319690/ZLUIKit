//
//  UIViewController+QTTExt.m
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIViewController+QTTExt.h"
#import "QTTViewController.h"

@implementation UIViewController (QTTExt)

+ (UIViewController *)qtt_visiableViewController {
  UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate].window rootViewController];
  return [UIViewController qtt_topViewControllerForViewController:rootViewController];
}

+ (UIViewController *)qtt_topViewControllerForViewController:(UIViewController *)viewController {
  if ([viewController isKindOfClass:[UITabBarController class]]) {
    return [self qtt_topViewControllerForViewController:[(UITabBarController *)viewController selectedViewController]];
  } else if ([viewController isKindOfClass:[UINavigationController class]]) {
    return [(UINavigationController *)viewController visibleViewController];
  } else {
    if (viewController.presentedViewController) {
      return [self qtt_topViewControllerForViewController:viewController.presentedViewController];
    } else {
      return viewController;
    }
  }
}

+ (QTTViewController *)qtt_topQTTViewController {
  QTTViewController *controller = nil;
  UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  [UIViewController qtt_traverseHierarchyToTopFromViewController:rootViewController lastQTTViewController:&controller];
  return controller;
}

+ (void)qtt_traverseHierarchyToTopFromViewController:(UIViewController *)viewController
                               lastQTTViewController:(QTTViewController **)lastQTTViewController {
  if ([viewController isKindOfClass:[UITabBarController class]]) {
    [self qtt_traverseHierarchyToTopFromViewController:[(UITabBarController *)viewController selectedViewController]
                                 lastQTTViewController:lastQTTViewController];
  } else if ([viewController isKindOfClass:[UINavigationController class]]) {
    [self qtt_traverseHierarchyToTopFromViewController:[(UINavigationController *)viewController topViewController]
                                 lastQTTViewController:lastQTTViewController];
  } else {
    if ([viewController isKindOfClass:[QTTViewController class]] && lastQTTViewController) {
      *lastQTTViewController = (QTTViewController *)viewController;
    }
    if (viewController.presentedViewController) {
      [self qtt_traverseHierarchyToTopFromViewController:viewController.presentedViewController
                                   lastQTTViewController:lastQTTViewController];
    }
  }
}
@end
