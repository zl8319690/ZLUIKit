//
//  QTTLabel.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/8.
//  Copyright © 2019 Qutoutiao, Ltd. All rights reserved.
//

#import "QTTLabel.h"

@implementation QTTLabel

- (void)drawTextInRect:(CGRect)rect {
  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGSize)intrinsicContentSize {
  CGSize size = [super intrinsicContentSize];
  size.width  += self.edgeInsets.left + self.edgeInsets.right;
  size.height += self.edgeInsets.top + self.edgeInsets.bottom;
  return size;
}

@end
