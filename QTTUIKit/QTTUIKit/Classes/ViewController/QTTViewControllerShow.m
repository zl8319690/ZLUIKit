//
//  QTTUIKit.m
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTViewControllerShow.h"
#import "QTTViewController.h"
#import "QTTNavigationController.h"
#import "UIViewController+QTTExt.h"
#import <QTTFoundation/QTTFoundation.h>

@implementation QTTUIKit

+ (void)showViewController:(UIViewController *)controller {
  [self showViewController:controller animationType:QTTAnimationTypePresent showCancelButton:YES];
}

+ (void)showViewController:(UIViewController *)controller showCancelButton:(BOOL)showCancel {
  [self showViewController:controller animationType:QTTAnimationTypePresent showCancelButton:showCancel];
}

+ (void)showViewController:(__kindof UIViewController *)controller animationType:(QTTAnimationType)type {
  [self showViewController:controller animationType:type enableTransition:YES];
}

+ (void)showViewController:(UIViewController *)controller animationType:(enum QTTAnimationType)type enableTransition:(BOOL)enabled {
  [self showViewController:controller animationType:type enableTransition:enabled showCancelButton:YES];
}

+ (void)showViewController:(__kindof UIViewController *)controller animationType:(QTTAnimationType)type showCancelButton:(BOOL)showCancel {
  [self showViewController:controller animationType:type enableTransition:YES showCancelButton:showCancel];
}

+ (void)showViewController:(UIViewController *)controller animationType:(enum QTTAnimationType)type enableTransition:(BOOL)enabled showCancelButton:(BOOL)showCancel {
  if (controller == nil) {
    return;
  }
  UIViewController *rootViewController = [UIViewController qtt_visiableViewController];
  if (rootViewController.presentingViewController && !rootViewController.navigationController) {
    [rootViewController dismissViewControllerAnimated:YES completion:^{
      if ([rootViewController isKindOfClass:QTTViewController.class]) {
        QTTViewController *root = (QTTViewController *)rootViewController;
        BLOCK_EXEC(root.autoDismissBlock);
      }
      [QTTUIKit showViewController:controller animationType:type enableTransition:enabled showCancelButton:showCancel];
    }];
    return;
  }
  if (type == QTTAnimationTypePresent) {
    if ([controller isKindOfClass:[QTTViewController class]]) {
      ((QTTViewController *)controller).showCancelButton = showCancel;
    }
    QTTNavigationController *navController = [[QTTNavigationController alloc] initWithRootViewController:controller];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    dispatch_async(dispatch_get_main_queue(), ^{
      [rootViewController presentViewController:navController animated:enabled completion:nil];
    });
  } else {
    UINavigationController *parentNavigationController = [rootViewController navigationController];
    if (parentNavigationController) {
      [parentNavigationController pushViewController:controller animated:enabled];
    } else {
      [QTTUIKit showViewController:controller animationType:QTTAnimationTypePresent];
    }
  }
}

+ (void)showViewController:(UIViewController *)controller withParameters:(NSDictionary *)params {
  if (controller == nil) {
    return;
  }
  QTTAnimationType type;
  NSString *number = params[@"animation_type"];
  if (number) {
    type = [number integerValue];
  } else {
    type = QTTAnimationTypePush;
  }
  NSString *enableTransition = params[@"animated_transition"];
  BOOL enabled = YES;
  if (enableTransition) {
    enabled = [enableTransition boolValue];
  }
  
  if([controller isKindOfClass:[QTTViewController class]]) {
    ((QTTViewController *)controller).kdd_queryParams = params;
  }
  [QTTUIKit showViewController:controller animationType:type enableTransition:enabled];
}


@end
