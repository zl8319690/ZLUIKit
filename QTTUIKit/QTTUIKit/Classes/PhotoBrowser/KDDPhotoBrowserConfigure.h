//
//  KDDPhotoBrowserConfigure.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#ifndef KDDPhotoBrowserConfigure_h
#define KDDPhotoBrowserConfigure_h

#import "UIImage+KDDDecoder.h"
#import "UIScrollView+KDDGestureHandle.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>

// 图片浏览器的显示方式
typedef NS_ENUM(NSUInteger, KDDPhotoBrowserShowStyle) {
    KDDPhotoBrowserShowStyleNone,       // 直接显示，默认方式
    KDDPhotoBrowserShowStyleZoom,       // 缩放显示，动画效果
    KDDPhotoBrowserShowStylePush        // push方式展示
};

// 图片浏览器的隐藏方式
typedef NS_ENUM(NSUInteger, KDDPhotoBrowserHideStyle) {
    KDDPhotoBrowserHideStyleZoom,           // 点击缩放消失
    KDDPhotoBrowserHideStyleZoomScale,      // 点击缩放消失、滑动缩小后消失
    KDDPhotoBrowserHideStyleZoomSlide       // 点击缩放消失、滑动平移后消失
};

// 图片浏览器的加载方式
typedef NS_ENUM(NSUInteger, KDDPhotoBrowserLoadStyle) {
    KDDPhotoBrowserLoadStyleIndeterminate,        // 不明确的加载方式
    KDDPhotoBrowserLoadStyleIndeterminateMask,    // 不明确的加载方式带阴影
    KDDPhotoBrowserLoadStyleDeterminate,          // 明确的加载方式带进度条
    KDDPhotoBrowserLoadStyleCustom                // 自定义加载方式
};

// 图片加载失败的显示方式
typedef NS_ENUM(NSUInteger, KDDPhotoBrowserFailStyle) {
    KDDPhotoBrowserFailStyleOnlyText,           // 显示文字
    KDDPhotoBrowserFailStyleOnlyImage,          // 显示图片
    KDDPhotoBrowserFailStyleImageAndText,       // 显示图片+文字
    KDDPhotoBrowserFailStyleCustom              // 自定义（如：显示HUD）
};

#endif /* GKPhotoBrowserConfigure_h */
