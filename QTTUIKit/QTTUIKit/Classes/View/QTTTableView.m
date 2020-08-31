//
//  QTTTableView.m
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTTableView.h"
#import <objc/message.h>
#import "QTTColor.h"

@implementation QTTTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
  self = [super initWithFrame:frame style:style];
  if (self) {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    if (style == UITableViewStylePlain) {
      self.tableFooterView = [[UIView alloc] init];
    }
    self.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
  }
  return self;
}

@end

@implementation UITableView (QTTReuse)

- (void)qtt_registerCellClass:(Class)cellClass {
  if (class_respondsToSelector(cellClass, @selector(reuseIdentifier))) {
    NSString *reuseIdentifier = [cellClass performSelector:@selector(reuseIdentifier)];
    [self registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
  } else {
    NSAssert(NO, @"UITableView regist cell class error, class have not a method called reuseIdentifier");
  }
}

- (void)qtt_registerHeaderFooterClass:(Class)headerFooterClass {
  if (class_respondsToSelector(headerFooterClass, @selector(reuseIdentifier))) {
    NSString *reuseIdentifier = [headerFooterClass performSelector:@selector(reuseIdentifier)];
    [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
  } else {
    NSAssert(NO, @"UITableView regist header footer class error, class have not a method called reuseIdentifier");
  }
}

- (nullable UITableViewCell *)qtt_dequeueReusableCellWithClass:(nonnull Class)cellClass {
  if (class_respondsToSelector(cellClass, @selector(reuseIdentifier))) {
    NSString *reuseIdentifier = [cellClass performSelector:@selector(reuseIdentifier)];
    return [self dequeueReusableCellWithIdentifier:reuseIdentifier];
  } else {
    NSAssert(NO, @"UITableView dequeue reusable cell class error, class have not a method called reuseIdentifier");
    return nil;
  }
}

- (nullable UITableViewHeaderFooterView *)qtt_dequeueReusableHeaderFooterViewWithClass:(nonnull Class)headerFooterClass {
  if (class_respondsToSelector(headerFooterClass, @selector(reuseIdentifier))) {
    NSString *reuseIdentifier = [headerFooterClass performSelector:@selector(reuseIdentifier)];
    return [self dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
  } else {
    NSAssert(NO, @"UITableView dequeue reusable header footer class error, class have not a method called reuseIdentifier");
    return nil;
  }
}

@end
