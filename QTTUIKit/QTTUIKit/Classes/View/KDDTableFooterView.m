//
//  KDDTableFooterView.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/5.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDTableFooterView.h"
#import <QTTFoundation/QTTFoundation.h>
#import "QTTColor.h"
#import "UIView+QTTPosition.h"

@implementation KDDTableFooterView

- (void)layoutSubviews {
  [super layoutSubviews];
  self.textLabel.font = [UIFont systemFontOfSize:11];
  self.textLabel.textColor = self.textColor ?: [QTTColor tableViewHeaderFooterColor];
  self.textLabel.top = 10;
  if (self.textLabelTextAlignment == NSTextAlignmentLeft) {
    self.textLabel.left = DEFAULT_INDENTATION;
  } else if (self.textLabelTextAlignment == NSTextAlignmentRight) {
    self.textLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.right = self.right - DEFAULT_INDENTATION;
  }
}

- (void)setText:(NSString *)text {
  self.textLabel.text = text;
  [self setNeedsLayout];
}

- (void)setTextLabelTextAlignment:(NSTextAlignment)textAlignment {
  _textLabelTextAlignment = textAlignment;
  self.textLabel.textAlignment = textAlignment;
  [self setNeedsLayout];
}

@end

@implementation UITableViewHeaderFooterView (KDDExt)

+ (NSString *)reuseIdentifier {
  return NSStringFromClass(self);
}

@end
