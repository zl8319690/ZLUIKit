//
//  KDDPopupViewController.m
//  QTTUIKit
//
//  Created by XIN on 2020/1/7.
//  Copyright © 2020 Qutoutiao. All rights reserved.
//

#import "KDDPopupViewController.h"
#import "QTTColor.h"
#import <QTTFoundation/QTTFoundation.h>
#import "UIControl+QTTExt.h"

@interface KDDPopupViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIControl *bgControl;
@property (nonatomic, strong, readwrite) UIView *containerView;

@end

@implementation KDDPopupViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.clearColor;
  [self loadPopupViews];
}

- (void)loadPopupViews {
  NSAssert(self.containerViewHeight > 0, @"pop up contaner view height must more than 0");
  [self.view addSubview:self.bgControl];
  [self.bgControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
  [self.bgControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
  [self.bgControl.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
  [self.bgControl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
  
  self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_FULL_SIZE_HEIGHT, DEVICE_FULL_SIZE_WIDTH, self.containerViewHeight)];
  self.containerView.backgroundColor = UIColor.whiteColor;
  [self.view addSubview:self.containerView];
}

#pragma mark - Accsrrors

- (UIControl *)bgControl {
  if (!_bgControl) {
    _bgControl = [[UIControl alloc] init];
    _bgControl.backgroundColor = [UIColor clearColor];
    _bgControl.translatesAutoresizingMaskIntoConstraints = false;
    weakify(self);
    [_bgControl qtt_addEventHandler:^{
      strongify(self);
      [self dismissViewControllerAnimated:YES completion:nil];
    }];
  }
  return _bgControl;
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    UIView *container = [transitionContext containerView];
    [container addSubview:self.view];
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:.9f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
      self.view.backgroundColor = QTTColor.translucentBlackColor;
      self.containerView.frame = CGRectMake(0, DEVICE_FULL_SIZE_HEIGHT - self.containerViewHeight, DEVICE_FULL_SIZE_WIDTH, self.containerViewHeight);
    }
                     completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
  if (self.isBeingDismissed) {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
      self.view.backgroundColor = [UIColor clearColor];
      self.containerView.frame = CGRectMake(0, DEVICE_FULL_SIZE_HEIGHT, DEVICE_FULL_SIZE_WIDTH, self.containerViewHeight);
    }
                     completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    return 0.3;
  }
  return 0.2;
}

@end
