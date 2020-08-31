//
//  UIWindow+QTTHud.h
//  QTTUIKit
//
//  Created by XIN on 2019/8/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QTTProgressHUD;

@interface UIWindow (QTTHud)

@property (nonatomic, strong) QTTProgressHUD *hud NS_EXTENSION_UNAVAILABLE_IOS("");

@end

NS_ASSUME_NONNULL_END
