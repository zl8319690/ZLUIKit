//
//  UITabBar+QTTBadge.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/28.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (QTTBadge)

- (void)showBadgeOnItemIndex:(int)index withNum:(NSInteger)badgeNum;

- (void)showRedPointOnItemIndex:(int)index;

- (void)hideBadgeOrRedPointOnItemIndex:(int)index;

/// 获取badge原始数字（99+的返回真实数字），如果该位置为小红点或无badge，则返回0
/// @param index tab位置
- (NSInteger)badgeNumberOnItemIndex:(int)index;

@property (nonatomic, strong, readonly) NSMutableArray *customBadgeNumberList;

@end

NS_ASSUME_NONNULL_END
