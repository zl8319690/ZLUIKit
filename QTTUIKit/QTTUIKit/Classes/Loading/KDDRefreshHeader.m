//
//  KDDRefreshHeader.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/20.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDRefreshHeader.h"
#import "KDDPullToRefreshDefinition.h"
#import "UIImage+QTTUIKit.h"
#import "QTTColor.h"
#import "UIView+QTTPosition.h"

@interface KDDRefreshHeader ()

@property (nonatomic, strong) UIImageView *pullImageView;
@property (nonatomic, strong) UIImageView *loadingImageView;

@end

@implementation KDDRefreshHeader

#pragma mark - 在这里做一些初始化配置（比如添加子控件）

- (void)prepare {
  [super prepare];
  self.mj_h = KDDPullToRefreshViewHeight;
  [self loadSubviews];
}

- (void)loadSubviews {
  self.pullImageView = [[UIImageView alloc] init];
  self.pullImageView.contentMode = UIViewContentModeCenter;
  [self addSubview:self.pullImageView];
  
  self.loadingImageView = [[UIImageView alloc] init];
  self.loadingImageView.frame = CGRectMake(0, 0, 40.0, 40.0);
  self.loadingImageView.animationImages = [UIImage qtt_refreshAnimationImages];
  self.loadingImageView.animationDuration = 2.5;
  [self addSubview:self.loadingImageView];
}

#pragma mark - 在这里设置子控件的位置和尺寸

- (void)placeSubviews {
  [super placeSubviews];
  self.pullImageView.centerX = self.centerX;
  self.pullImageView.y = (self.height - self.pullImageView.height) / 2.f;
  
  self.loadingImageView.centerX = self.centerX;
  self.loadingImageView.y = (self.height - self.loadingImageView.height) / 2.f;
}

#pragma mark 监听scrollView的contentOffset改变
//
//- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
//  [super scrollViewContentOffsetDidChange:change];
//  NSValue *pointValue = change[NSKeyValueChangeNewKey];
//  CGFloat offsetY = [pointValue CGPointValue].y;
//  CGFloat progress = fabs(offsetY) / KDDPullToRefreshViewHeight;
//  [self updatePullWithProgress:progress];
//}

- (void)updatePullWithProgress:(CGFloat)progress {
  if (progress >= 1) {
    [self resetWithCompleteImageView];
  } else {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KDDPullRefreshOuterCicleWidth, KDDPullRefreshOuterCicleWidth), NO,[UIScreen mainScreen].scale);
    [[QTTColor qttRedColor] set];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, KDDPullRefreshOuterCicleWidth, KDDPullRefreshOuterCicleWidth)];
    [path1 fill];
    
    if (self.centerBgColor) {
      [self.centerBgColor set];
    } else {
      [[UIColor whiteColor] set];
    }
    
    CGFloat circleW = KDDPullRefreshInnerCicleWidth * progress;
    CGFloat circleH = circleW;
    CGFloat space = (KDDPullRefreshOuterCicleWidth - circleW) / 2.0;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(space , space, circleW, circleH)];
    [path2 fill];
    self.pullImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
  [super setPullingPercent:pullingPercent];
  if (self.scrollView.isDragging) {
    [self updatePullWithProgress:pullingPercent];
  }
}

- (void)resetWithCompleteImageView {
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(KDDPullRefreshOuterCicleWidth, KDDPullRefreshOuterCicleWidth), NO,[UIScreen mainScreen].scale);
  [[QTTColor qttRedColor] set];
  UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, KDDPullRefreshOuterCicleWidth, KDDPullRefreshOuterCicleWidth)];
  [path1 fill];
  
  if (self.centerBgColor) {
    [self.centerBgColor set];
  } else {
    [[UIColor whiteColor] set];
  }

  UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, KDDPullRefreshInnerCicleWidth, KDDPullRefreshInnerCicleWidth)];
  [path2 fill];
  self.pullImageView.image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
}

#pragma mark - 监听scrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
  [super scrollViewPanStateDidChange:change];
}

#pragma mark - 监听控件的刷新状态

- (void)setState:(MJRefreshState)state {
  MJRefreshCheckState;
  
  if (state == MJRefreshStatePulling) {
    if (@available(iOS 10.0, *)) {
      if (self.scrollView.isDragging) {
        [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
      }
    }
  } else if (state == MJRefreshStateRefreshing) {
    self.pullImageView.hidden = YES;
    self.loadingImageView.hidden = NO;
    [self.loadingImageView startAnimating];
  } else if (state == MJRefreshStateIdle) {
    [self.loadingImageView stopAnimating];
    [self resetWithCompleteImageView];
    self.pullImageView.hidden = NO;
    self.loadingImageView.hidden = YES;
  } else if (state == MJRefreshStateWillRefresh) {
    
  }
}

@end
