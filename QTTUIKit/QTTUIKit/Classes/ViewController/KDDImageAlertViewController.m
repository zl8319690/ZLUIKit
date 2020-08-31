//
//  KDDImageAlertViewController.m
//  QTTUIKit
//
//  Created by lyj on 2019/12/9.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDImageAlertViewController.h"
#import <Masonry/Masonry.h>
#import <QTTFoundation/QTTFoundation.h>
#import "QTTColor.h"
#import "QTTFont.h"
#import "QTTButtonUtils.h"
#import "UIColor+QTTColor.h"
#import "UIControl+QTTExt.h"
#import "UIImage+QTTUIKit.h"

@interface KDDImageAlertViewController ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *alertBgView;
@property (nonatomic, strong) UIImageView *alertImgV;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *submitBtnTitle;

@end

@implementation KDDImageAlertViewController

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle
               submitBtnTitle:(NSString *)submitBtnTitle {
  self = [super init];
  if (self) {
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    self.image = image;
    self.alertTitle = title;
    self.subTitle = subTitle;
    self.submitBtnTitle = submitBtnTitle;
    
    [self loadSubviews];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)loadSubviews {
  [self.view addSubview:self.alertBgView];
  [self.alertBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(0);
  }];
  
  [self.alertBgView addSubview:self.alertImgV];
  [self.alertImgV mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.mas_equalTo(0);
    make.size.mas_equalTo(CGSizeMake(280, 157));
  }];
  
  [self.alertBgView addSubview:self.alertTitleLabel];
  [self.alertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.alertImgV.mas_bottom).mas_offset(2);
    make.centerX.mas_equalTo(0);
    make.width.mas_lessThanOrEqualTo(280 - 15*2);
  }];
  
  [self.alertBgView addSubview:self.alertContentLabel];
  [self.alertContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.alertTitleLabel.mas_bottom).mas_offset(6);
    make.centerX.mas_equalTo(0);
    make.width.mas_lessThanOrEqualTo(280 - 15*2);
  }];
  
  [self.alertBgView addSubview:self.submitBtn];
  [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.alertContentLabel.mas_bottom).mas_offset(16);
    make.size.mas_equalTo(CGSizeMake(250, 50));
    make.bottom.mas_equalTo(-15);
    make.centerX.mas_equalTo(0);
  }];
  
  [self.alertBgView addSubview:self.closeBtn];
  [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(10);
    make.right.mas_equalTo(-10);
    make.size.mas_equalTo(CGSizeMake(25, 25));
  }];
  
  self.alertImgV.image = self.image;
  self.alertTitleLabel.text = self.alertTitle;
  self.alertContentLabel.text = self.subTitle;
  [self.submitBtn setTitle:self.submitBtnTitle forState:UIControlStateNormal];
}

- (void)close {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    self.view.backgroundColor = [UIColor clearColor];
    UIView *container = [transitionContext containerView];
    [container addSubview:self.view];
    self.alertBgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.alertBgView.alpha = 0;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:.9f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
      self.view.backgroundColor = QTTColor.translucentBlackColor;
      self.alertBgView.transform = CGAffineTransformMakeScale(1, 1);
      self.alertBgView.alpha = 1;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
  if (self.isBeingDismissed) {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
      self.view.backgroundColor = [UIColor clearColor];
      self.alertBgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
      self.alertBgView.alpha = 0;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    return 0.5;
  }
  return 0.5;
}

#pragma mark - Accessors

- (UIView *)alertBgView {
  if (!_alertBgView) {
    _alertBgView = [[UIView alloc] init];
    _alertBgView.backgroundColor = UIColor.whiteColor;
    _alertBgView.layer.cornerRadius = 4;
    _alertBgView.layer.masksToBounds = YES;
  }
  return _alertBgView;
}

- (UIImageView *)alertImgV {
  if (!_alertImgV) {
    _alertImgV = [[UIImageView alloc] init];
  }
  return _alertImgV;
}

- (UILabel *)alertTitleLabel {
  if (!_alertTitleLabel) {
    _alertTitleLabel = [[UILabel alloc] init];
    _alertTitleLabel.font = BOLD_FONT(18);
    _alertTitleLabel.textColor = UIColor.blackColor;
  }
  return _alertTitleLabel;
}

- (UILabel *)alertContentLabel {
  if (!_alertContentLabel) {
    _alertContentLabel = [[UILabel alloc] init];
    _alertContentLabel.font = FONT(14);
    _alertContentLabel.textColor = QTTColorFromRGB(0x737373);
    _alertContentLabel.numberOfLines = 0;
  }
  return _alertContentLabel;
}

- (UIButton *)submitBtn {
  if (!_submitBtn) {
    _submitBtn = [QTTButtonUtils roundedButtonWithColor:QTTColor.qttRedColor cornerRadius:4];
    [_submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = FONT(16);
    weakify(self);
    [_submitBtn qtt_addEventHandler:^{
      strongify(self);
      BLOCK_EXEC(self.submitActionHandler,self);
    }];
  }
  return _submitBtn;
}

- (UIButton *)closeBtn {
  if (!_closeBtn) {
    _closeBtn = [[UIButton alloc] init];
    [_closeBtn qtt_setImage:[UIImage qtt_imageNamedInQTTUIKit:@"icon_shut"]];
    weakify(self);
    [_closeBtn qtt_addEventHandler:^{
      strongify(self);
      BLOCK_EXEC(self.closeActionHandler,self);
      [self dismissViewControllerAnimated:YES completion:nil];
    }];
  }
  return _closeBtn;
}

- (void)setShowClose:(BOOL)showClose {
  _showClose = showClose;
  self.closeBtn.hidden = !_showClose;
}

@end
