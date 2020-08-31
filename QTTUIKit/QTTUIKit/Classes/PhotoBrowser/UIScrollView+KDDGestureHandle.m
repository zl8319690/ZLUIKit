//
//  UIScrollView+KDDGestureHandle.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIScrollView+KDDGestureHandle.h"
#import <objc/runtime.h>

static const void* KDDGestureHandleEnabled = @"KDDGestureHandleEnabled";

@implementation UIScrollView (KDDGestureHandle)

- (void)setKdd_gestureHandleEnabled:(BOOL)kdd_gestureHandleEnabled {
  objc_setAssociatedObject(self, KDDGestureHandleEnabled, @(kdd_gestureHandleEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)kdd_gestureHandleEnabled {
  return [objc_getAssociatedObject(self, KDDGestureHandleEnabled) boolValue];
}

#pragma mark - 解决全屏滑动

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (!self.kdd_gestureHandleEnabled) return YES;
    if ([self panBack:gestureRecognizer]) return NO;
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  if (!self.kdd_gestureHandleEnabled) return NO;
  if ([self panBack:gestureRecognizer]) return YES;
  return NO;
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer == self.panGestureRecognizer) {
    CGPoint point = [self.panGestureRecognizer translationInView:self];
    UIGestureRecognizerState state = gestureRecognizer.state;
  
    // 设置手势滑动的位置距屏幕左边的区域
    CGFloat locationDistance = [UIScreen mainScreen].bounds.size.width;
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStatePossible) {
      CGPoint location = [gestureRecognizer locationInView:self];
      if (point.x > 0 && location.x < locationDistance && self.contentOffset.x <= 0) {
          return YES;
      }
    }
  }
  return NO;
}

@end
