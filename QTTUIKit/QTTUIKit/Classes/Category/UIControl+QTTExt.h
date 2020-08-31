//
//  UIControl+QTTExt.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (QTTExt)

- (void)qtt_addTarget:(id)target action:(SEL)action;

- (void)qtt_addEventHandler:(void (^)(void))handler;

- (void)qtt_addEventHandler:(void (^)(void))handler forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
