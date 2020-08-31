//
//  KDDRefreshFooter.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/21.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDRefreshFooter.h"
#import "KDDPullToRefreshDefinition.h"

@interface KDDRefreshFooter ()

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation KDDRefreshFooter

- (void)prepare {
  [super prepare];
  self.mj_h = KDDLoadMoreViewHeight;
  
  UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  loadingView.hidesWhenStopped = YES;
  [self addSubview:loadingView];
  self.loadingView = loadingView;
}

#pragma mark 在这里设置子控件的位置和尺寸

- (void)placeSubviews {
  [super placeSubviews];
  
  self.loadingView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

- (void)setState:(MJRefreshState)state {
  MJRefreshCheckState
  
  // 根据状态做事情
  if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
    [self.loadingView stopAnimating];
  } else if (state == MJRefreshStateRefreshing) {
    [self.loadingView startAnimating];
  }
}
@end
