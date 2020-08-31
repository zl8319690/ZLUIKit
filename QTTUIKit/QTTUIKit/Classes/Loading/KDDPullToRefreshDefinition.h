//
//  KDDPullToRefreshDefinition.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/19.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

@import UIKit;

#ifndef KDDPullToRefreshDefinition_h
#define KDDPullToRefreshDefinition_h

typedef NS_ENUM(NSUInteger, KDDPullToRefreshViewBackgroundMode) {
  KDDPullToRefreshViewBackgroundModeDefault,
  KDDPullToRefreshViewBackgroundModeBlue
};

typedef NS_ENUM(NSUInteger, KDDPullToRefreshState) {
  KDDPullToRefreshStateStopped = 0,
  KDDPullToRefreshStateTriggered,
  KDDPullToRefreshStateLoading
};

extern CGFloat const KDDPullToRefreshViewHeight;
extern CGFloat const KDDLoadMoreViewHeight;
extern CGFloat const KDDInfiniteScrollingViewHeight;

extern CGFloat const KDDLogoLoadingViewPreferredWidth;

extern CGFloat const KDDPullRefreshOuterCicleWidth;
extern CGFloat const KDDPullRefreshInnerCicleWidth;

#endif /* KDDPullToRefreshDefinition_h */
