//
//  UINavigationBar+QTTUIKit.h
//  QTTUIKit
//
//  Created by XIN on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (QTTUIKit)
  
@property (nonatomic, strong) UIImage *qtt_backgroundImage;

- (void)qtt_setBackgroundImage:(UIImage *)image
                      animated:(BOOL)animated;

// expose private property
@property (nonatomic, strong, readonly) UIView *qtt_backgroundView;

@end

NS_ASSUME_NONNULL_END
