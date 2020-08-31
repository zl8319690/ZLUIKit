//
//  QTTTableViewCell.m
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTTableViewCell.h"
#import "UIImage+QTTUIKit.h"
#import "QTTColor.h"
#import <QTTFoundation/QTTFoundation.h>
#import "UIView+QTTPosition.h"

@interface QTTTableViewCell ()

@end

@implementation QTTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];  
  if (self.shouldHideSeparatorView) {
    [self hideSeparatorView];
  }
}

- (void)hideSeparatorView {
  [self.contentView.superview.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")] &&
        [obj respondsToSelector:@selector(removeFromSuperview)]) {
      [obj removeFromSuperview];
    }
  }];
}

@end

@implementation UITableViewCell (QTTExtension)

+ (NSString *)reuseIdentifier {
  return NSStringFromClass(self);
}

@end
