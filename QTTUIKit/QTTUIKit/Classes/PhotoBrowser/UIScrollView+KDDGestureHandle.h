//
//  UIScrollView+KDDGestureHandle.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (KDDGestureHandle)

/**
 * 是否启用手势处理功能，默认为NO
 * 为了防止与APP中其他UIScrollview滑动的冲突，默认设置为NO，需要时设置为YES即可
 */
@property (nonatomic, assign) BOOL kdd_gestureHandleEnabled;

@end
