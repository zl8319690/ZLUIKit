//
//  QTTViewController.m
//  Tiny
//
//  Created by XIN on 2019/7/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTViewController.h"
#import "QTTColor.h"
#import "QTTUIKit.h"
#import "UINavigationBar+QTTUIKit.h"
#import <QTTFoundation/QTTFoundation.h>
#import "QTTProgressHUD.h"

@interface QTTViewController (){
  BOOL _didFirstAppear;
  BOOL _willFirstAppear;
  BOOL _preferNagvigationBarBackButtonLight;
}

@end

@implementation QTTViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [QTTColor backgroundColor];
  [self configBackButton];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (!_willFirstAppear) {
    _willFirstAppear = YES;
    [self viewWillFirstAppear:animated];
  }
  [self adjustNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (!_didFirstAppear) {
    _didFirstAppear = YES;
    [self viewDidFirstAppear:animated];
  }
}

- (void)viewWillFirstAppear:(BOOL)animated {
  
}

- (void)viewDidFirstAppear:(BOOL)animated {
  
}

- (void)adjustNavigationBar {
  if (self.navigationController.navigationBarHidden != self.preferNavigationBarHiddenWhenAppear) {
    [self.navigationController setNavigationBarHidden:self.preferNavigationBarHiddenWhenAppear animated:YES];
  }
}

- (void)configBackButton NS_EXTENSION_UNAVAILABLE_IOS("") {
  if (self == self.navigationController.viewControllers[0]) {
    return;
  }
  UIImage *image = _preferNagvigationBarBackButtonLight ? [UIImage qtt_backButtonLightImage] : [UIImage qtt_backButtonDarkImage];
  QTTBarButtonItem *item = [[QTTBarButtonItem alloc] initWithImage:image];
  item.accessibilityLabel = @"返回";
  item.accessibilityHint = @"轻点两下可返回前一页";
  weakify(self);
  [item setBlockAction:^{
    strongify(self)
    if (self.dismissOrPopBlock == nil || self.dismissOrPopBlock() == YES) {
      [self.navigationController popViewControllerAnimated:YES];
    }
  }];
  self.navigationItem.leftBarButtonItem = item;
}

- (void)setShowCancelButton:(BOOL)showCancelButton {
  if (_showCancelButton == showCancelButton) {
    if (!showCancelButton) {
      [self setupEmptyRightBarButtonItem];
    }
    return;
  } else {
    _showCancelButton = showCancelButton;
    weakify(self);
    if (_showCancelButton) {
      QTTBarButtonItem *item = [[QTTBarButtonItem alloc] initWithImage:[UIImage qtt_closeButtonDarkImage]];
      item.accessibilityLabel = @"关闭";
      [item setBlockAction:^{
        strongify(self);
        if (self.dismissOrPopBlock == nil || self.dismissOrPopBlock() == YES) {
          [self dismissViewControllerAnimated:YES completion:nil];
        }
      }];
      self.navigationItem.rightBarButtonItem = item;
    } else {
      [self setupEmptyRightBarButtonItem];
    }
  }
}

- (void)setupEmptyRightBarButtonItem {
  self.navigationItem.rightBarButtonItem = nil;
}

- (void)setupEmptyLeftBarButtonItem {
  self.navigationItem.leftBarButtonItem = nil;
}

- (UIImage *)navBarBackgroundImage {
  return self.showAlternativeNavBar ? self.navBarAlternativeImage : [UIImage new];
}

- (UIImage *)navBarAlternativeImage {
  static UIImage *alterBackground = nil;
  if (!alterBackground) {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(POINT_OF_ONE_PIXEL, POINT_OF_ONE_PIXEL), NO, 0.0);
    CGContextSetAlpha(UIGraphicsGetCurrentContext(), 0.0);
    alterBackground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return alterBackground;
}

- (void)setShowAlternativeNavBar:(BOOL)showAlternativeNavBar {
  if (_showAlternativeNavBar != showAlternativeNavBar) {
    _showAlternativeNavBar = showAlternativeNavBar;
    _preferNagvigationBarBackButtonLight = YES;
    [self configBackButton];
    [self.navigationController.navigationBar qtt_setBackgroundImage:[self navBarBackgroundImage]
                                                           animated:YES];
  }
}

#pragma mark - VC container

- (void)popOrDissmissViewController:(BOOL)animated {
  NSInteger indexInNavigation = [self indexInNavigationController];
  if (indexInNavigation != NSNotFound && indexInNavigation > 0) {
    [self.navigationController popToViewController:self.navigationController.viewControllers[indexInNavigation - 1]
                                          animated:animated];
  } else {
    [self dismissViewControllerAnimated:animated completion:nil];
  }
}

- (NSInteger)indexInNavigationController {
  __block NSInteger matchIndex = NSNotFound;
  [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
    if ([self isDescendantOfViewController:obj]) {
      matchIndex = idx;
      *stop = YES;
    }
  }];
  
  return matchIndex;
}

- (BOOL)isDescendantOfViewController:(UIViewController *)viewController {
  return [self.view isDescendantOfView:viewController.view];
}

#pragma mark - Accessors

- (QTTProgressHUD *)hud {
  if (!_hud) {
    _hud = [[QTTProgressHUD alloc] initWithTargetView:self.view];
  }
  return _hud;
}

@end
