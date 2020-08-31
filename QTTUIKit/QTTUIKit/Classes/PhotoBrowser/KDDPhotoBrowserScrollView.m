//
//  KDDScrollView.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPhotoBrowserScrollView.h"

@implementation KDDPhotoBrowserScrollView

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer == self.panGestureRecognizer) {
    if (gestureRecognizer.state == UIGestureRecognizerStatePossible) {
      if ([self isScrollViewOnTopOrBottom]) {
        return NO;
      }
    }
  }
  return YES;
}

// 判断是否滑动到顶部或底部
- (BOOL)isScrollViewOnTopOrBottom {
  CGPoint translation = [self.panGestureRecognizer translationInView:self];
  if (translation.y > 0 && self.contentOffset.y <= 0) {
    return YES;
  }
  CGFloat maxOffsetY = floor(self.contentSize.height - self.bounds.size.height);
  if (translation.y < 0 && self.contentOffset.y >= maxOffsetY) {
    return YES;
  }
  return NO;
}

@end
