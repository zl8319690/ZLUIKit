//
//  QTTButton.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTButton.h"

@implementation QTTButton
  
- (CGSize)intrinsicContentSize {
  CGSize size = [super intrinsicContentSize];
  size.width  += self.edgeInsets.left + self.edgeInsets.right;
  size.height += self.edgeInsets.top + self.edgeInsets.bottom;
  return size;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (!self.userInteractionEnabled || self.hidden || self.alpha < 0.01) {
    return nil;
  }
  CGRect rect = CGRectMake(self.bounds.origin.x - self.enlargeEdgeInsets.left,
                           self.bounds.origin.y - self.enlargeEdgeInsets.top,
                           self.bounds.size.width + self.enlargeEdgeInsets.left + self.enlargeEdgeInsets.right,
                           self.bounds.size.height + self.enlargeEdgeInsets.top + self.enlargeEdgeInsets.bottom);
  if (CGRectEqualToRect(rect, self.bounds)) {
    return [super hitTest:point withEvent:event];
  }
  return CGRectContainsPoint(rect, point) ? self : nil;
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    self.alpha = 0.5f;
  } else {
    self.alpha = 1.f;
  }
}

@end
