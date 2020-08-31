//
//  UIWindow+QTTHud.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIWindow+QTTHud.h"
#import "QTTProgressHUD.h"
#import <objc/runtime.h>

static char UIWindowHud;

@implementation UIWindow (QTTHud)

@dynamic hud;

- (QTTProgressHUD *)hud {
  id hud = objc_getAssociatedObject(self, &UIWindowHud);
  if (hud == nil) {
    hud = [[QTTProgressHUD alloc] initWithTargetView:self];
    [self setHud:hud];
  }
  return hud;
}

- (void)setHud:(QTTProgressHUD *)hud {
  [self willChangeValueForKey:NSStringFromSelector(@selector(hud))];
  objc_setAssociatedObject(self, &UIWindowHud, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self didChangeValueForKey:NSStringFromSelector(@selector(hud))];
}

@end
