//
//  KDDPhotoBrowserLoadingView.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDDPhotoBrowserConfigure.h"

typedef NS_ENUM(NSUInteger, KDDLoadingStyle) {
    KDDLoadingStyleIndeterminate,      // 不明确的加载方式
    KDDLoadingStyleIndeterminateMask,  // 不明确的加载方式带阴影
    KDDLoadingStyleDeterminate,        // 明确的加载方式--进度条
    KDDLoadingStyleCustom              // 自定义
};

@interface KDDPhotoBrowserLoadingView : UIView

+ (instancetype)loadingViewWithFrame:(CGRect)frame style:(KDDLoadingStyle)style;

@property (nonatomic, assign) KDDPhotoBrowserFailStyle failStyle;

@property (nonatomic, strong) UIButton *centerButton;

/** 线条宽度：默认4 */
@property (nonatomic, assign) CGFloat lineWidth;

/** 圆弧半径：默认24 */
@property (nonatomic, assign) CGFloat radius;

/** 圆弧的背景颜色：默认半透明黑色 */
@property (nonatomic, strong) UIColor *bgColor;

/** 进度的颜色：默认白色 */
@property (nonatomic, strong) UIColor *strokeColor;

/** 进度，loadingStyle为GKLoadingStyleDeterminate时使用 */
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) NSString  *failText;
@property (nonatomic, strong) UIImage *failImage;

@property (nonatomic, copy) void (^progressChange)(KDDPhotoBrowserLoadingView *loadingView, CGFloat progress);

@property (nonatomic, copy) void (^tapToReload)(void);

/**
 开始动画方法-loadingStyle为GKLoadingStyleIndeterminate，GKLoadingStyleIndeterminateMask时使用
 */
- (void)startLoading;

/**
 结束动画方法
 */
- (void)stopLoading;

- (void)showFailure;

- (void)hideFailure;

- (void)hideLoadingView;

- (void)removeAnimation;

// 在duration时间内加载，
- (void)startLoadingWithDuration:(NSTimeInterval)duration completion:(void (^)(KDDPhotoBrowserLoadingView *loadingView, BOOL finished))completion;

@end
