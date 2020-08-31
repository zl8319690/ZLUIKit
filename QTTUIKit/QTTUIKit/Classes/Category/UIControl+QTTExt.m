//
//  UIControl+QTTExt.m
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIControl+QTTExt.h"
#import <objc/runtime.h>

@implementation UIControl (QTTExt)

- (void)qtt_addTarget:(id)target action:(SEL)action {
  [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)qtt_addEventHandler:(void (^)(void))handler {
  [self qtt_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

static char QTTControlHandlerKey;
- (void)qtt_addEventHandler:(void (^)(void))handler forControlEvents:(UIControlEvents)controlEvents {
  objc_setAssociatedObject(self, &QTTControlHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self addTarget:self action:@selector(qtt_didTappedButton) forControlEvents:controlEvents];
}

- (void)qtt_didTappedButton {
  void (^handler)(void) = objc_getAssociatedObject(self, &QTTControlHandlerKey);
  if (handler) {
    handler();
  }
}

@end
