//
//  UIImage+KDDDecoder.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KDDDecoder)

// 存储图片
@property (nonatomic, setter=kdd_setImageBuffer:,getter=kdd_imageBuffer) NSMutableDictionary *buffer;

// 是否需要不停刷新buffer
@property (nonatomic, setter=kdd_setNeedUpdateBuffer:,getter=kdd_needUpdateBuffer) NSNumber *needUpdateBuffer;

// 当前展示到哪一张图片了
@property (nonatomic, setter=kdd_setHandleIndex:,getter=kdd_handleIndex) NSNumber *handleIndex;

// 最大的缓存图片数
@property (nonatomic, setter=kdd_setMaxBufferCount:,getter=kdd_maxBufferCount) NSNumber *maxBufferCount;

// 当前这帧图像是否展示
@property (nonatomic, setter=kdd_setBufferMiss:,getter=kdd_bufferMiss) NSNumber *bufferMiss;

// 增加的buffer数目
@property (nonatomic, setter=kdd_setIncrBufferCount:,getter=kdd_incrBufferCount) NSNumber *incrBufferCount;

// 该gif 一共多少帧
@property (nonatomic, setter=kdd_setTotalFrameCount:,getter=kdd_totalFrameCount) NSNumber *totalFrameCount;

+ (UIImage *)sdOverdue_animatedGIFWithData:(NSData *)data;

- (void)kdd_animatedGIFData:(NSData *)data;

- (NSTimeInterval)animatedImageDurationAtIndex:(int)index;

- (UIImage *)animatedImageFrameAtIndex:(int)index;

- (void)imageViewShowFinished;

@end
