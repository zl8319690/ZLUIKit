//
//  QTTTabBarTappingAware.h
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QTTTabBarTappingAware <NSObject>

@optional

/// 单击选中
-(void)tabBar:(UITabBar *)tabBar qtt_didSelectItem:(UITabBarItem *)item;

/// 已经选中, 再次单击了该 VC 的 TAB
- (void)onSingleTapAgainWhenAlreadyDisplayed;

/// 已经选中, 再次双击了该 VC 的 TAB
- (void)onDoubleTapAgainWhenAlreadyDisplayed;

@end

NS_ASSUME_NONNULL_END
