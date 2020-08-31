//
//  QTTUIKit.h
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QTTAnimationType) {
  QTTAnimationTypePresent,
  QTTAnimationTypePush
};

@interface QTTUIKit : NSObject

/**
 Show a view controller using Present animation type
 
 @param controller a view controller
 */
+ (void)showViewController:(__kindof UIViewController *)controller NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 *  Show a view controller using Present animation type
 *  @param controller a view controller
 *  @param showCancel showCancel 是否显示取消按钮
 */
+ (void)showViewController:(UIViewController *)controller showCancelButton:(BOOL)showCancel;

/**
 Show a view controller using specified animation type.
 
 @param controller a view controller
 @param type       push or present
 */
+ (void)showViewController:(__kindof UIViewController *)controller animationType:(QTTAnimationType)type NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 Show a view controller based on animation_type specified in a scheme
 
 @param controller a view controller
 @param params     params from a scheme, just throw it in
 */
+ (void)showViewController:(__kindof UIViewController *)controller withParameters:(NSDictionary *)params NS_EXTENSION_UNAVAILABLE_IOS("");

@end

NS_ASSUME_NONNULL_END
