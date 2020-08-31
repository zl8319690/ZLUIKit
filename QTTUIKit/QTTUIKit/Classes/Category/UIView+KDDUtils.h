//
//  UIView+KDDUtils.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/14.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KDDUtils)

/**
 当前view所在的UINavigationController
 */
@property (nonatomic, readonly)  UINavigationController * _Nullable navigationController;

@property (nonatomic, readonly) UIViewController * _Nullable viewController;

@end

NS_ASSUME_NONNULL_END
