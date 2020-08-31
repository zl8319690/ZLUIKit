//
//  QTTNavigationController.m
//  Tiny
//
//  Created by XIN on 2019/7/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTNavigationController.h"

@interface QTTNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation QTTNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  __weak QTTNavigationController *weakSelf = self;
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.delegate = weakSelf;
  }
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
  if (self.viewControllers.count != 0) {
    viewController.hidesBottomBarWhenPushed = YES;
  }
  [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  // 使自定义了 nav bar 返回按钮的 view controller 也可以通过 interactivePopGestureRecognizer 来 pop
  if (gestureRecognizer == self.interactivePopGestureRecognizer) {
    if (self.viewControllers.count < 2 ||
        self.visibleViewController == (self.viewControllers)[0]) {
      return NO;
    }
  }
  return YES;
}

@end
