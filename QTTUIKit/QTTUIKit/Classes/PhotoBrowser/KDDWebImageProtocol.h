//
//  KDDWebImageProtocol.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPhotoBrowserConfigure.h"

typedef void (^kddWebImageProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void (^kddWebImageCompletionBlock)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL);

@protocol KDDWebImageProtocol<NSObject>

// 加载图片
- (id _Nonnull )loadImageWithURL:(nullable NSURL *)url
                        progress:(nullable kddWebImageProgressBlock)progress
                       completed:(nullable kddWebImageCompletionBlock)completion;

- (void)cancelImageRequestWithImageView:(nullable UIImageView *)imageView;

- (UIImage *_Nullable)imageFromMemoryForURL:(nullable NSURL *)url;

@end
