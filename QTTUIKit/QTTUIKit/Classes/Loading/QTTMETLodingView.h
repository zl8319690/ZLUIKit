//
//  QTTMETLodingView.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KDDMETLoadingType) {
  KDDMETLoadingTypeKeep,
  KDDMETLoadingTypeFadeOut,
};

@interface QTTMETLodingView : UIView

/// size: {44, 44}
- (instancetype)initWithPreferredSize;

/// default is KDDMETLoadingTypeFadeOut.
@property (nonatomic, assign) KDDMETLoadingType animType;

/// default is QTTColor.qttRedColor.
@property (nonatomic, strong, null_resettable) UIColor *lineColor;

/// Sets the line width of the spinner's circle, default is 1
@property (nonatomic) CGFloat lineWidth;

/// Sets whether the view is hidden when not animating., default is YES.
@property (nonatomic) BOOL hidesWhenStopped;

/// Property indicating the duration of the animation, default is 1s.
@property (nonatomic, readwrite) NSTimeInterval duration;

/// anima state
@property (nonatomic, assign, readonly, getter=isAnimating) BOOL animating;

/**
 *  Starts animation of the spinner.
 */
- (void)startAnimating;

/**
 *  Stops animation of the spinnner.
 */
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
