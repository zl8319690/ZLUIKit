//
//  UIView+KDDUtils.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/14.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIView+KDDUtils.h"

@implementation UIView (KDDUtils)
@dynamic navigationController;

- (nullable UINavigationController *)navigationController {
  UINavigationController *navigationController = nil;
  UIResponder *next = self.nextResponder;
  while (next) {
    if ([next isKindOfClass:[UINavigationController class]]) {
      navigationController = (UINavigationController *)next;
      break;
    }
    next = next.nextResponder;
  }
  return navigationController;
}


- (UIViewController *)viewController {
  UIViewController *viewController = nil;
  UIResponder *next = self.nextResponder;
  while (next) {
    if ([next isKindOfClass:[UIViewController class]]) {
      viewController = (UINavigationController *)next;
      break;
    }
    next = next.nextResponder;
  }
  return viewController;
}

@end
