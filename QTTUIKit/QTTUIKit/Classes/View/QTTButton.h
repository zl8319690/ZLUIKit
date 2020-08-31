//
//  QTTButton.h
//  QTTUIKit
//
//  Created by XIN on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTButton : UIButton

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 扩大按钮点击响应区域
 */
@property (nonatomic, assign) UIEdgeInsets enlargeEdgeInsets;

@end

NS_ASSUME_NONNULL_END
