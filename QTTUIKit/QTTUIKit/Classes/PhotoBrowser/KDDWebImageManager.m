//
//  KDDWebImageManager.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDWebImageManager.h"

@implementation KDDWebImageManager

- (id)loadImageWithURL:(NSURL *)url progress:(kddWebImageProgressBlock)progress completed:(kddWebImageCompletionBlock)completion {
    // 进度block
    SDWebImageDownloaderProgressBlock progressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        !progress ? : progress(receivedSize, expectedSize);
    };
    
    // 图片加载完成block
    SDInternalCompletionBlock completionBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        !completion ? : completion(image, data, error, cacheType, finished, imageURL);
    };
    
    return [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:progressBlock completed:completionBlock];
}

- (void)cancelImageRequestWithImageView:(UIImageView *)imageView {
    [imageView sd_cancelCurrentImageLoad];
}

- (UIImage *)imageFromMemoryForURL:(NSURL *)url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    return [imageCache imageFromCacheForKey:key];
}

@end
