//
//  UIImage+KDDDecoder.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIImage+KDDDecoder.h"
#import <ImageIO/ImageIO.h>
#import <objc/runtime.h>
#import <mach/mach.h>

//这里参考了YYImage的源码
#define BUFFER_SIZE (10 * 1024 * 1024) // 10MB (minimum memory buffer size)

static int64_t _YYDeviceMemoryTotal() {
  int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
  if (mem < -1) mem = -1;
  return mem;
}

static int64_t _YYDeviceMemoryFree() {
  mach_port_t host_port = mach_host_self();
  mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  vm_size_t page_size;
  vm_statistics_data_t vm_stat;
  kern_return_t kern;
  
  kern = host_page_size(host_port, &page_size);
  if (kern != KERN_SUCCESS) return -1;
  kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
  if (kern != KERN_SUCCESS) return -1;
  return vm_stat.free_count * page_size;
}

@interface UIImage ()

@property (nonatomic, setter = kdd_setImageSource:,getter=kdd_source) CGImageSourceRef source;
@property (nonatomic, setter = kdd_setMaxBufferSize:,getter=kdd_maxBufferSize) NSNumber *maxBufferSize;

@end

@implementation UIImage (LBDecoder)

- (NSNumber *)kdd_needUpdateBuffer {
  return objc_getAssociatedObject(self, @selector(kdd_needUpdateBuffer));
}

- (void)kdd_setNeedUpdateBuffer:(NSNumber *)needUpdateBuffer {
  objc_setAssociatedObject(self, @selector(kdd_needUpdateBuffer), needUpdateBuffer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)kdd_imageBuffer {
  return objc_getAssociatedObject(self, @selector(kdd_imageBuffer));
}

- (void)kdd_setImageBuffer:(NSMutableDictionary *)buffer {
  objc_setAssociatedObject(self, @selector(kdd_imageBuffer), buffer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGImageSourceRef)kdd_source {
  return (__bridge CGImageSourceRef)objc_getAssociatedObject(self, @selector(kdd_source));
}
- (void)kdd_setImageSource:(CGImageSourceRef)source {
  objc_setAssociatedObject(self, @selector(kdd_source), (__bridge id)(source), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kdd_handleIndex {
  return objc_getAssociatedObject(self, @selector(kdd_handleIndex));
}

- (void)kdd_setHandleIndex:(NSNumber *)handleIndex {
  objc_setAssociatedObject(self, @selector(kdd_handleIndex), handleIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kdd_totalFrameCount {
  return objc_getAssociatedObject(self, @selector(kdd_totalFrameCount));
}

- (void)kdd_setTotalFrameCount:(NSNumber *)totalFrameCount{
  objc_setAssociatedObject(self, @selector(kdd_totalFrameCount), totalFrameCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kdd_maxBufferCount {
  return objc_getAssociatedObject(self, @selector(kdd_maxBufferCount));
}

- (void)kdd_setMaxBufferCount:(NSNumber *)maxBufferCount{
  objc_setAssociatedObject(self, @selector(kdd_maxBufferCount), maxBufferCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kdd_maxBufferSize {
  return objc_getAssociatedObject(self, @selector(kdd_maxBufferSize));
}

- (void)kdd_setMaxBufferSize:(NSNumber *)maxBufferSize{
  objc_setAssociatedObject(self, @selector(kdd_maxBufferSize), maxBufferSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kdd_bufferMiss {
  return objc_getAssociatedObject(self, @selector(kdd_bufferMiss));
}

- (void)kdd_setBufferMiss:(NSNumber *)bufferMiss {
  objc_setAssociatedObject(self, @selector(kdd_bufferMiss), bufferMiss, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSNumber *)kdd_incrBufferCount {
  return objc_getAssociatedObject(self, @selector(kdd_incrBufferCount));
}

- (void)kdd_setIncrBufferCount:(NSNumber *)incrBufferCount {
  objc_setAssociatedObject(self, @selector(kdd_incrBufferCount), incrBufferCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 这里是老版的SDWebImage提供的加载Gif的动画的方法 新版取消了 只默认取gif的第一帧

// 高内存 低cpu --> 对较大的gif图片来说  内存会很大
+ (UIImage *)sdOverdue_animatedGIFWithData:(NSData *)data {
  if (!data) return nil;
  CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
  size_t count = CGImageSourceGetCount(source);
  UIImage *animatedImage;
  
  if (count <= 1) {
    animatedImage = [[UIImage alloc] initWithData:data];
  } else {
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval duration = 0.0f;
  
    for (size_t i = 0; i < count; i++) {
      CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
      duration += [self sdOverdue_frameDurationAtIndex:i source:source];
      [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
      CGImageRelease(image);
    }
  
    if (!duration) {
      duration = (1.0f / 10.0f) * count;
    }
    animatedImage = [UIImage animatedImageWithImages:images duration:duration];
  }
  
  CFRelease(source);
  return animatedImage;
}

+ (float)sdOverdue_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
  float frameDuration = 0.1f;
  CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
  NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
  NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
  
  NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
  if (delayTimeUnclampedProp) {
    frameDuration = [delayTimeUnclampedProp floatValue];
  } else {
    NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
    if (delayTimeProp) {
      frameDuration = [delayTimeProp floatValue];
    }
  }
  
  if (frameDuration < 0.011f) {
    frameDuration = 0.100f;
  }
  CFRelease(cfFrameProperties);
  
  return frameDuration;
}

- (void)kdd_animatedGIFData:(NSData *)data {
  if (!data) return;
  CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
  
  [self kdd_setImageSource:source];
  [self calcMaxBufferCount];
  size_t count = CGImageSourceGetCount(source);
  // 需要不停地解压-->
  [self kdd_setImageBuffer:[NSMutableDictionary dictionary]];
  [self kdd_setHandleIndex:@(0)];
  [self kdd_setBufferMiss:@(NO)];
  [self kdd_setIncrBufferCount:@(0)];
  [self kdd_setTotalFrameCount:@(count)];
  if (count > self.maxBufferCount.intValue) {
    [self kdd_setNeedUpdateBuffer:@(YES)];
  }
}

- (void)calcMaxBufferCount { // 合适的加载图片数目
  // 1 获取每帧的图片内存占用大小
  CGImageRef image  = CGImageSourceCreateImageAtIndex(self.kdd_source, 0, NULL);
  NSUInteger bytesPerFrame = CGImageGetBytesPerRow(image) * CGImageGetHeight(image);
  
  int64_t bytes = (int64_t)bytesPerFrame;
  if (bytes == 0) bytes = 1024;
  int64_t total = _YYDeviceMemoryTotal();
  int64_t free  = _YYDeviceMemoryFree();
  int64_t max   = MIN(total * 0.2, free * 0.6);
  max = MAX(max, BUFFER_SIZE);
  // 获取到最多可以加载的图片数
  double maxBufferCount = (double)max / (double)bytes;
  if (maxBufferCount < 1) maxBufferCount = 1;
  else if (maxBufferCount > 512) maxBufferCount = 512;
  [self kdd_setMaxBufferCount:@(maxBufferCount)];
  CGImageRelease(image);
}

- (NSTimeInterval)animatedImageDurationAtIndex:(int)index {
  return [self.class sdOverdue_frameDurationAtIndex:index source:self.kdd_source];
}

- (UIImage *)animatedImageFrameAtIndex:(int)index {
  CGImageRef cgImage = NULL;
  cgImage = CGImageSourceCreateImageAtIndex(self.kdd_source, index, NULL);
  UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
  CGImageRelease(cgImage);
  return image;
}

- (void)imageViewShowFinished {
  if (self.kdd_source) {
    NSMutableDictionary *buffer = [self kdd_imageBuffer];
    [buffer removeAllObjects];
    CGImageSourceRef source = self.kdd_source;
    CFRelease(source);
    objc_removeAssociatedObjects(self);
  }
}

@end
