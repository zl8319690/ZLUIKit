//
//  KDDRefreshHeader.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/20.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDRefreshHeader : MJRefreshHeader

/// 下拉动画中间的颜色，默认为白色
@property (nonatomic, strong) UIColor *centerBgColor;

@end

NS_ASSUME_NONNULL_END
