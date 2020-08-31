//
//  QTTViewController.h
//  Tiny
//
//  Created by XIN on 2019/7/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QTTProgressHUD;

@interface QTTViewController : UIViewController

@property (nonatomic, strong) QTTProgressHUD *hud;

- (void)viewWillFirstAppear:(BOOL)animated;
- (void)viewDidFirstAppear:(BOOL)animated;

// Only use when viewWillAppear to transition navigationBar background,
// if you change the navigationBar visibility, you should also change this property to reflect the change
@property (nonatomic, assign) BOOL preferNavigationBarHiddenWhenAppear;
@property (nonatomic, assign) BOOL showAlternativeNavBar;
  // subclass and overwrite this to provide a new background image
- (UIImage *)navBarAlternativeImage;
- (UIImage *)navBarBackgroundImage;

/// 如果当前VC在Navigation中并且不是rootViewController，则pop到它的上一个VC
/// 否则dismiss掉当前VC
- (void)popOrDissmissViewController:(BOOL)animated;

@property (nonatomic, assign, getter = isShowingCancelButton) BOOL showCancelButton;
/// dimiss 或者 pop 回去之前做一个 block 回调判断
@property (nonatomic, copy) BOOL (^dismissOrPopBlock)(void);

/// 自动dimiss时回调（使用QTTUIKit showViewController方法present新controller时，某些情况下会自动dismiss当前controller）
@property (nonatomic, copy) void(^autoDismissBlock)(void);

/**
 * scheme中的query字段
 */
@property (nonatomic, copy) NSDictionary *kdd_queryParams;

@end

