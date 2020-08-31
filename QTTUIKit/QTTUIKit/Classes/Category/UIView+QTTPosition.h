//
//  UIView+QTTPosition.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (QTTPosition)

/** View's X Position */
@property (nonatomic, assign) CGFloat   x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   y;

/** View's width */
@property (nonatomic, assign) CGFloat   width;

/** View's height */
@property (nonatomic, assign) CGFloat   height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** Y value representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   right;

/** X Value representing the top of the view (alias of x) **/
@property (nonatomic, assign) CGFloat   left;

/** Y Value representing the top of the view (alias of y) **/
@property (nonatomic, assign) CGFloat   top;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   centerY;

/** Returns the Subview with the heighest X value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;

/** Returns the Subview with the heighest Y value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

/** View's bounds X value **/
@property (nonatomic, assign) CGFloat   boundsX;

/** View's bounds Y value **/
@property (nonatomic, assign) CGFloat   boundsY;

/** View's bounds width **/
@property (nonatomic, assign) CGFloat   boundsWidth;

/** View's bounds height **/
@property (nonatomic, assign) CGFloat   boundsHeight;

/**
 Centers the view to its parent view (if exists)
 */
-(void)qtt_centerToParent;

#pragma mark - subviews

- (void)qtt_removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
