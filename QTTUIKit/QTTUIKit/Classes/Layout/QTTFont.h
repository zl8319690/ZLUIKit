//
//  QTTFont.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern UIFont *FONT(CGFloat size);
extern UIFont *BOLD_FONT(CGFloat size);

@interface QTTFont : NSObject

+ (UIFont *)bigBoldTitleFont;

+ (UIFont *)grandTitleFont;

+ (UIFont *)titleFont;

+ (UIFont *)boldTitleFont;

+ (UIFont *)mediumTitleFont;

+ (UIFont *)smallTitleFont;

+ (UIFont *)alertBoldTitleFont;

+ (UIFont *)alertButtonTitleFont;

+ (UIFont *)detailFont;

+ (UIFont *)smallFont;

+ (UIFont *)navigationBarTitleFont;

+ (UIFont *)navigationBarItemFont;

+ (UIFont *)segmentControlTitleFont;

+ (UIFont *)segmentUnselectedTitleFont;

+ (UIFont *)segmentSelectedTitleFont;

+ (UIFont *)emptyViewTitleFont;

+ (UIFont *)emptyViewSubTitleFont;

@end

NS_ASSUME_NONNULL_END
