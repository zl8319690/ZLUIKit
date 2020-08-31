//
//  QTTProgressHUD.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/20.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat const KDDProgressHUDDefaultHideDelay;

@class MBProgressHUD;

@interface QTTProgressHUD : NSObject

@property (nonatomic, strong, readonly) MBProgressHUD *hud;
@property (nonatomic, strong, readonly) UIView *targetView;
@property (nonatomic) CGFloat Yoffset;
/// default is NO;(此值为YES，键盘可以保持显示状态)
@property (nonatomic, assign) BOOL enableTargetViewUserInteractionWhenShow;

- (instancetype)initWithTargetView:(id)view;

- (void)showLoading;

/// black indicator loading with title
- (void)showLoadingWithString:(NSString *)string;

- (void)showToastWithString:(NSString *)string performBlockWhenHide:(dispatch_block_t)block;

- (void)hide;

/**
 *  通用Toast，支持多行显示
 *  `KDDProgressHUDDefaultHideDelay`后自动隐藏
 *  @param string toast文案
 */
- (void)showToastWithString:(NSString *)string;

/**
 *  成功Toast，支持多行显示
 *  `KDDProgressHUDDefaultHideDelay`后自动隐藏
 *  @param string toast文案
 */
- (void)showSuccessWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
