//
//  KDDPhotoView.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDDPhoto.h"
#import "KDDPhotoBrowserScrollView.h"
#import "KDDWebImageProtocol.h"
#import "KDDPhotoBrowserLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@class KDDPhotoView;

@interface KDDPhotoView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) KDDPhotoBrowserScrollView *scrollView;

@property (nonatomic, strong, readonly) UIImageView  *imageView;

@property (nonatomic, strong, readonly) KDDPhotoBrowserLoadingView *loadingView;

@property (nonatomic, strong, readonly) KDDPhoto *photo;

@property (nonatomic, copy) void(^zoomEnded)(KDDPhotoView *photoView, CGFloat scale);
@property (nonatomic, copy) void(^loadFailed)(KDDPhotoView *photoView);
@property (nonatomic, copy) void(^loadProgressBlock)(KDDPhotoView *photoView, float progress, BOOL isOriginImage);

/** 横屏时是否充满屏幕宽度，默认YES，为NO时图片自动填充屏幕 */
@property (nonatomic, assign) BOOL isFullWidthForLandSpace;

/** 图片最大放大倍数 */
@property (nonatomic, assign) CGFloat maxZoomScale;

/**
 开启这个选项后 在加载gif的时候 会大大的降低内存.与YYImage对gif的内存优化思路一样 default is NO
 */
@property (nonatomic, assign) BOOL isLowGifMemory;

/** 是否重新布局 */
@property (nonatomic, assign) BOOL isLayoutSubViews;

@property (nonatomic, assign) KDDPhotoBrowserLoadStyle loadStyle;
@property (nonatomic, assign) KDDPhotoBrowserLoadStyle originLoadStyle;
@property (nonatomic, assign) KDDPhotoBrowserFailStyle failStyle;

@property (nonatomic, copy) NSString *failureText;
@property (nonatomic, strong) UIImage *failureImage;

- (instancetype)initWithFrame:(CGRect)frame imageProtocol:(id<KDDWebImageProtocol>)imageProtocol;

// 设置数据
- (void)setupPhoto:(KDDPhoto *)photo;

// 加载原图（必须传originUrl）
- (void)loadOriginImage;

// 缩放
- (void)zoomToRect:(CGRect)rect animated:(BOOL)animated;

// 跳转布局
- (void)adjustFrame;
// 重新布局
- (void)resetFrame;

- (void)startGifAnimation;

- (void)stopGifAnimation;

@end

NS_ASSUME_NONNULL_END
