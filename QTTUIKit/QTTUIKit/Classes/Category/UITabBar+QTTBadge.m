//
//  UITabBar+QTTBadge.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/28.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UITabBar+QTTBadge.h"
#import "QTTColor.h"
#import "QTTFont.h"
#import <QTTFoundation/QTTFoundation.h>
#import <objc/runtime.h>

@implementation UITabBar (QTTBadge)

static CGFloat badgeHeight = 16.0;
static CGFloat badgeMinWidth = 16.0;
static int baseBadgeOrRedPointTagNumber = 888;

static CGFloat redPointWidth = 10.f;
static CGFloat redPointHeight = 10.f;

static char QTTBadgeNumberListKey;

- (void)showBadgeOnItemIndex:(int)index withNum:(NSInteger)badgeNum {
  if (index > self.items.count - 1 || index < 0) {
    return;
  }
  
  if (self.customBadgeNumberList.count != self.items.count) {
    self.customBadgeNumberList = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [self.customBadgeNumberList qtt_safeAddObject:@(0)];
    }];
  }
  
  [self removeBadgeOrRedPointOnItemIndex:index];
  
  [self.customBadgeNumberList qtt_safeReplaceObjectAtIndex:index withObject:@(badgeNum)];

  UILabel *labNum = [[UILabel alloc] init];
  [labNum setFont:[QTTFont smallFont]];
  labNum.tag = baseBadgeOrRedPointTagNumber + index;
  labNum.layer.masksToBounds = YES;
  labNum.layer.cornerRadius = badgeHeight/2.0;
  labNum.backgroundColor = [QTTColor qttRedColor];

  if (badgeNum > 99) {
    labNum.text = @"99+";
  } else {
    labNum.text = [NSString stringWithFormat:@"%ld", badgeNum];
  }
  
  CGRect tabFrame = self.frame;
  float percentX = (index + 0.6) / self.items.count;
  CGFloat x = ceilf(percentX * tabFrame.size.width);
  CGFloat y = ceilf(0.1 * tabFrame.size.height) - 10.0;
  
  CGSize size = [labNum.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[QTTFont smallFont],NSFontAttributeName,nil]];
  CGFloat width = size.width + 4 > badgeMinWidth ? size.width + 4 : badgeMinWidth;
  labNum.frame = CGRectMake(x, y,  width, badgeHeight);
  labNum.textColor = [UIColor whiteColor];
  labNum.textAlignment = NSTextAlignmentCenter;
  [self addSubview:labNum];
}

- (void)showRedPointOnItemIndex:(int)index {
  if (index > self.items.count - 1 || index < 0) {
    return;
  }
  
  if (self.customBadgeNumberList.count != self.items.count) {
    self.customBadgeNumberList = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [self.customBadgeNumberList qtt_safeAddObject:@(0)];
    }];
  }
  
  [self removeBadgeOrRedPointOnItemIndex:index];
  
  UIView *redPoint = [[UIView alloc] init];
  redPoint.tag = baseBadgeOrRedPointTagNumber + index;
  redPoint.layer.masksToBounds = YES;
  redPoint.layer.cornerRadius = redPointWidth/2.0;
  redPoint.backgroundColor = [QTTColor qttRedColor];

  CGRect tabFrame = self.frame;
  float percentX = (index + 0.6) / self.items.count;
  CGFloat x = ceilf(percentX * tabFrame.size.width);
  CGFloat y = ceilf(0.1 * tabFrame.size.height) - 10.0;
  
  redPoint.frame = CGRectMake(x, y, redPointWidth , redPointHeight);
  [self addSubview:redPoint];
}

- (void)hideBadgeOrRedPointOnItemIndex:(int)index {
  [self removeBadgeOrRedPointOnItemIndex:index];
}

- (void)removeBadgeOrRedPointOnItemIndex:(NSInteger)index {
  for (UIView *subView in self.subviews) {
    if (subView.tag == baseBadgeOrRedPointTagNumber + index) {
      [subView removeFromSuperview];
    }
  }
  
  if (self.customBadgeNumberList.count >= index + 1) {
    [self.customBadgeNumberList qtt_safeReplaceObjectAtIndex:index withObject:@(0)];
  }
}

- (NSInteger)badgeNumberOnItemIndex:(int)index {
  if (self.customBadgeNumberList.count >= index + 1) {
    return [[self.customBadgeNumberList qtt_safeObjectAtIndex:index] integerValue];
  }
  return 0;
}

- (void)setCustomBadgeNumberList:(NSMutableArray *)customBadgeNumberList {
  objc_setAssociatedObject(self, &QTTBadgeNumberListKey, customBadgeNumberList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)customBadgeNumberList {
  return objc_getAssociatedObject(self, &QTTBadgeNumberListKey);
}

@end
