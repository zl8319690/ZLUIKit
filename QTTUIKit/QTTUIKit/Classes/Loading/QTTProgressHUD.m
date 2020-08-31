//
//  QTTProgressHUD.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/20.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTProgressHUD.h"
#import "QTTColor.h"
#import "UIImage+QTTUIKit.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <QTTFoundation/QTTFoundation.h>
#import "QTTUIKitDefine.h"
#import <QTTUIKit/QTTUIKit.h>
#import <BlocksKit/BlocksKit.h>
#import "QTTMETLodingView.h"

CGFloat const KDDProgressHUDDefaultHideDelay = 1.5f;

@interface QTTProgressHUD()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) NSTimer *hideDelayTimer;
@property (nonatomic, strong) QTTMETLodingView *loadingView;

@end

@implementation QTTProgressHUD

- (instancetype)initWithTargetView:(id)view {
  self = [super init];
  if (self) {
    _enableTargetViewUserInteractionWhenShow = NO;
    _targetView = view;
    _hud = [self hudForView:_targetView];
    [self addHudToTargetViewIfNeededAndBringToFront];
  }
  return self;
}

- (MBProgressHUD *)hudForView:(UIView *)view {
  MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
  hud.removeFromSuperViewOnHide = YES;
  hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
  hud.backgroundView.color = [UIColor clearColor];
  hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
  hud.contentColor = nil;
  hud.label.textColor = [UIColor whiteColor];
  hud.detailsLabel.textColor = [UIColor whiteColor];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
  });
  return hud;
}

- (void)dealloc {
  [self cancelHideDelayTimer];
}

- (void)cancelHideDelayTimer {
  if (self.hideDelayTimer) {
    if (self.hideDelayTimer.valid) {
      [self.hideDelayTimer invalidate];
    }
    self.hideDelayTimer = nil;
  }
}

- (void)addHudToTargetViewIfNeededAndBringToFront {
  if (![_targetView.subviews containsObject:_hud]) {
    [_targetView addSubview:_hud];
  }
  else {
    [_targetView bringSubviewToFront:_hud];
  }
}

- (void)show {
  [self addHudToTargetViewIfNeededAndBringToFront];
  [self cancelHideDelayTimer];
  [self.hud showAnimated:YES];
  self.targetView.userInteractionEnabled = self.enableTargetViewUserInteractionWhenShow;
}


- (void)hide {
  [self.hud hideAnimated:YES];
  self.targetView.userInteractionEnabled = YES;
}

#pragma mark - Loding

- (void)showLoading {
  [self showCustomLoading];
}

- (void)showLoadingWithString:(NSString *)string {
  _hud.mode = MBProgressHUDModeIndeterminate;
  _hud.bezelView.color = [QTTColor translucentBlackColor];
  _hud.label.text = string;
  _hud.detailsLabel.text = nil;
  [self show];
}

- (void)showCustomLoading {
  _hud.bezelView.color = [UIColor clearColor];
  _hud.mode = MBProgressHUDModeCustomView;
  _hud.label.text = nil;
  _hud.detailsLabel.text = nil;
  _hud.customView = self.loadingView;
  [self.loadingView startAnimating];
  [self show];
}

#pragma mark - Toast显示

- (void)showSuccessWithString:(NSString *)string {
  UIImage *image = [UIImage qtt_imageNamedInQTTUIKit:@"success"];
  [self showString:nil subString:string customImage:image];
  [self hideWithDelayTime:KDDProgressHUDDefaultHideDelay performBlockWhenHide:nil];
}

- (void)showString:(NSString *)string subString:(NSString *)subString customImage:(UIImage *)image {
  NSParameterAssert(image);
  _hud.mode = MBProgressHUDModeCustomView;
  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
  imageView.contentMode = UIViewContentModeTop;
  CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
  CGRect targetRect = CGRectInset(imageRect, 0, -5);
  [imageView setFrame:targetRect];
  _hud.customView = imageView;
  _hud.bezelView.color = [QTTColor translucentBlackColor];
  _hud.label.text = string;
  _hud.label.font = FONT(12);
  _hud.detailsLabel.font = FONT(16);
  _hud.detailsLabel.text = subString;
  [self show];
}

- (void)showToastWithString:(NSString *)string {
  [self showToastWithString:string hideAfterDelay:KDDProgressHUDDefaultHideDelay];
}

- (void)showToastWithString:(NSString *)string hideAfterDelay:(NSTimeInterval)delayTime {
  [self showToastWithString:string hideAfterDelay:delayTime performBlockWhenHide:nil];
}

- (void)showToastWithString:(NSString *)string performBlockWhenHide:(dispatch_block_t)block {
  [self showToastWithString:string hideAfterDelay:KDDProgressHUDDefaultHideDelay performBlockWhenHide:block];
}

- (void)showToastWithString:(NSString *)string hideAfterDelay:(NSTimeInterval)delayTime performBlockWhenHide:(dispatch_block_t)block {
  _hud.mode = MBProgressHUDModeText;
  _hud.bezelView.color = [QTTColor translucentBlackColor];
  _hud.label.text = nil;
  _hud.detailsLabel.text = string;
  _hud.detailsLabel.font = FONT(16);
  [_hud layoutIfNeeded];
  [self show];
  [self hideWithDelayTime:delayTime performBlockWhenHide:block];
}

- (void)hideWithDelayTime:(NSTimeInterval)time performBlockWhenHide:(dispatch_block_t)block {
  __weak __typeof__(self) weakSelf = self;
  self.hideDelayTimer = [NSTimer bk_scheduledTimerWithTimeInterval:time block:^(NSTimer *timer) {
    [weakSelf hide];
    if (block) {
      block();
    }
  } repeats:NO];
}

#pragma mark - Accessors

- (void)setYoffset:(CGFloat)Yoffset {
  _Yoffset = Yoffset;
  self.hud.offset = CGPointMake(self.hud.offset.x, Yoffset);
}

- (QTTMETLodingView *)loadingView {
  if (!_loadingView) {
    _loadingView = [[QTTMETLodingView alloc] initWithPreferredSize];
    _loadingView.lineWidth = 3;
  }
  return _loadingView;
}

@end
