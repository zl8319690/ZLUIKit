//
//  KDDTableHeaderView.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/5.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDTableHeaderView.h"
#import "UIView+QTTPosition.h"
#import <QTTFoundation/QTTFoundation.h>
#import "QTTColor.h"

@implementation KDDTableHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.textLabel.textColor = _textColor ?: [QTTColor tableViewHeaderFooterColor];
  self.textLabel.font = _font ?: [UIFont systemFontOfSize:13];
  [self.textLabel sizeToFit];
  self.textLabel.left = DEFAULT_INDENTATION;
  self.textLabel.bottom = self.height - 10.0;
}

#pragma mark - setter

- (void)setText:(NSString *)text {
  _text = [text copy];
  self.textLabel.text = _text;
  [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
  _font = font;
  self.textLabel.font = _font;
}

- (void)setTextColor:(UIColor *)textColor {
  _textColor = textColor;
  self.textLabel.textColor = _textColor;
}

#pragma mark - factory method

+ (KDDTableHeaderView *)tableHeaderLabelWithTitle:(NSString *)string {
  KDDTableHeaderView *headerView = [[KDDTableHeaderView alloc] initWithReuseIdentifier:nil];
  headerView.text = string;
  return headerView;
}

@end
