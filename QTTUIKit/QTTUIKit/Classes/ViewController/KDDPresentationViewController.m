//
//  KDDPresentationViewController.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/6.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPresentationViewController.h"
#import <Masonry/Masonry.h>

static NSTimeInterval const KDDPresentDuration = 0.5;
static NSTimeInterval const KDDDismissDuration = 0.3;

@interface KDDPresentationViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, readwrite, strong) QTTViewController<KDDPresentationDelegate> *contentViewController;

@end

@implementation KDDPresentationViewController

- (instancetype)initWithContentViewController:(QTTViewController<KDDPresentationDelegate> *)viewController {
  if (self = [super initWithNibName:nil bundle:nil]) {
    self.contentViewController = viewController;
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.modalPresentationCapturesStatusBarAppearance = YES;
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addChildViewController:self.contentViewController];
  self.contentViewController.view.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.width.height.equalTo(self.view);
  }];
  [self.contentViewController didMoveToParentViewController:self];
}

# pragma mark - status bar

- (BOOL)prefersStatusBarHidden {
  return self.contentViewController ? [self.contentViewController prefersStatusBarHidden] : NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.contentViewController ? [self.contentViewController preferredStatusBarStyle] : UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
  return self.contentViewController ? [self.contentViewController preferredStatusBarUpdateAnimation] : UIStatusBarAnimationFade;
}

#pragma mark - Transtioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    return KDDPresentDuration;
  } else if (self.isBeingDismissed) {
    return KDDDismissDuration;
  }
  
  return 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isBeingPresented) {
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:self.view];
    self.view.backgroundColor = [UIColor clearColor];
    self.contentViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:KDDPresentDuration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       [self setNeedsStatusBarAppearanceUpdate];
                       self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
                       self.contentViewController.view.transform = CGAffineTransformIdentity;
                       [self animateContentViewControllerAppearance:YES];
                     }
                     completion:^(BOOL finished) {
                       [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
  } else if(self.isBeingDismissed) {
    [UIView  animateWithDuration:KDDDismissDuration animations:^{
      [self setNeedsStatusBarAppearanceUpdate];
      self.view.backgroundColor = [UIColor clearColor];
      self.contentViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
      [self animateContentViewControllerAppearance:NO];
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
}

- (void)animateContentViewControllerAppearance:(BOOL)isAppear {
  if ([self.contentViewController respondsToSelector:@selector(animateAlongPresentation:)]) {
    [self.contentViewController animateAlongPresentation:isAppear];
  }
}

+ (void)showContentViewController:(QTTViewController<KDDPresentationDelegate> *)viewController
         fromSourceViewController:(UIViewController *)sourceViewController {
  KDDPresentationViewController *presentation = [[KDDPresentationViewController alloc] initWithContentViewController:viewController];
  [sourceViewController presentViewController:presentation animated:YES completion:nil];
}

@end

