//
//  UINavigationBar+QTTUIKit.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UINavigationBar+QTTUIKit.h"

@implementation UINavigationBar (QTTUIKit)
  
@dynamic qtt_backgroundImage;
  
- (UIImage *)qtt_backgroundImage {
  return [self backgroundImageForBarMetrics:UIBarMetricsDefault];
}
  
- (void)setqtt_backgroundImage:(UIImage *)qtt_backgroundImage {
  [self qtt_setBackgroundImage:qtt_backgroundImage animated:NO];
}
  
-(void)qtt_setBackgroundImage:(UIImage *)image animated:(BOOL)animated {
  if (self.qtt_backgroundImage == image) {
    return;
  }
  
  [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
  if (animated) {
    [self addTransitionToBackgroundView];
  }
}
  
- (UIView *)qtt_backgroundView {
  return [self valueForKey:@"_backgroundView"];
}
  
- (void)addTransitionToBackgroundView {
  CATransition *animation = [CATransition animation];
  animation.duration = 0.35;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.type = kCATransitionFade;
  [self.qtt_backgroundView.layer addAnimation:animation forKey:nil];
}

@end
