//
//  QTTFont.m
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTFont.h"

@implementation QTTFont

+ (UIFont *)bigBoldTitleFont {
  return [UIFont boldSystemFontOfSize:26.0];
}

+ (UIFont *)grandTitleFont {
  return [UIFont systemFontOfSize:19];
}

+ (UIFont *)titleFont {
  return [UIFont systemFontOfSize:16];
}

+ (UIFont *)boldTitleFont {
  return [UIFont boldSystemFontOfSize:16];
}

+ (UIFont *)mediumTitleFont {
  return [UIFont systemFontOfSize:13];
}

+ (UIFont *)smallTitleFont {
  return [UIFont systemFontOfSize:12];
}

+ (UIFont *)alertBoldTitleFont {
  return [UIFont boldSystemFontOfSize:17.0];
}

+ (UIFont *)alertButtonTitleFont {
  return [UIFont systemFontOfSize:15];
}

+ (UIFont *)detailFont {
  return [UIFont systemFontOfSize:14];
}

+ (UIFont *)smallFont {
  return [UIFont systemFontOfSize:11];
}

+ (UIFont *)navigationBarTitleFont {
  return [UIFont boldSystemFontOfSize:18.0];
}

+ (UIFont *)navigationBarItemFont {
  return [UIFont systemFontOfSize:16];
}

+ (UIFont *)segmentControlTitleFont {
  return [UIFont boldSystemFontOfSize:14];
}

+ (UIFont *)segmentUnselectedTitleFont {
  return [UIFont systemFontOfSize:17];
}

+ (UIFont *)segmentSelectedTitleFont {
  return [UIFont boldSystemFontOfSize:20];
}

+ (UIFont *)emptyViewTitleFont {
  return [UIFont systemFontOfSize:20];
}

+ (UIFont *)emptyViewSubTitleFont {
  return [self detailFont];
}

@end

UIFont *FONT(CGFloat size) {
  return [UIFont systemFontOfSize:size];
}

UIFont *BOLD_FONT(CGFloat size) {
  return  [UIFont boldSystemFontOfSize:size];
}
