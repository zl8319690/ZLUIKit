//
//  KDDPhoto.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPhoto.h"
#import <QTTFoundation/QTTFoundation.h>

@interface KDDPhoto() {
    NSOperationQueue *_requestQueue;
    dispatch_semaphore_t _lock;
}

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval accumulator;
@property (nonatomic, strong) UIImage *currentGifImage;

@property (nonatomic, assign) BOOL      isAnimation;

@end

@implementation KDDPhoto

- (instancetype)init {
  if (self = [super init]) {
    _requestQueue = [[NSOperationQueue alloc] init];
    _requestQueue.maxConcurrentOperationCount = 1;
    _lock = dispatch_semaphore_create(1);
  }
  return self;
}

#pragma mark - gif & 定时器

- (CADisplayLink *)displayLink {
  if (!_displayLink) {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeKeyframe:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
  }
  return _displayLink;
}

- (void)changeKeyframe:(CADisplayLink *)displayLink {
  NSMutableDictionary *buffer = self.currentGifImage.kdd_imageBuffer;
  if (self.currentGifImage.kdd_totalFrameCount.intValue == 0) return;
  NSUInteger nextIndex = (self.currentGifImage.kdd_handleIndex.intValue + 1) % self.currentGifImage.kdd_totalFrameCount.intValue;
  BOOL bufferIsFull = NO;
  NSTimeInterval delay = 0;
  if (self.currentGifImage.bufferMiss.boolValue == NO) {
    self.accumulator += displayLink.duration;
    delay = [self.currentGifImage animatedImageDurationAtIndex:self.currentGifImage.kdd_handleIndex.intValue];
    if (self.accumulator < delay) return;
    self.accumulator -= delay;
    delay = [self.currentGifImage animatedImageDurationAtIndex:(int)nextIndex];
    if (self.accumulator > delay) self.accumulator = delay;
  }
  UIImage *bufferedImage = buffer[@(nextIndex)];
  if (bufferedImage) {
    if (self.currentGifImage.needUpdateBuffer.boolValue) {
      [buffer removeObjectForKey:@(nextIndex)];
    }
    [self.currentGifImage kdd_setHandleIndex:@(nextIndex)];
    self.imageView.image = bufferedImage;
    [self.currentGifImage kdd_setBufferMiss:@(NO)];
    nextIndex = (self.currentGifImage.kdd_handleIndex.intValue + 1) % self.currentGifImage.kdd_totalFrameCount.intValue;
    if (buffer.count == self.currentGifImage.totalFrameCount.unsignedIntValue) {
      bufferIsFull = YES;
    }
  } else {
    [self.currentGifImage kdd_setBufferMiss:@(YES)];
  }
  if (bufferIsFull == NO && _requestQueue.operationCount == 0) {
    KDDPhotoDecoder *decoder = [KDDPhotoDecoder new];
    decoder.nextIndex = nextIndex;
    decoder.curImage = self.currentGifImage;
    decoder.lock = _lock;
    [_requestQueue addOperation:decoder];
  }
}

- (void)startAnimation {
  if (self.isAnimation) return;
  self.isAnimation = YES;
  self.displayLink.paused = YES;
  self.currentGifImage = self.gifImage;
  if (!self.isGif) return;
  if (self.gifData.length == 0) return;
  [self.gifImage kdd_animatedGIFData:self.gifData];
  self.accumulator = 0;
  self.displayLink.paused = NO;
}

- (void)stopAnimation {
  if (!self.isAnimation) return;
  self.isAnimation = NO;
  if (_displayLink) {
    [_displayLink invalidate];
    _displayLink = nil;
  }
  
  self.imageView = nil;
  self.currentGifImage = nil;
  if (_requestQueue) {
    [_requestQueue cancelAllOperations];
  }
}

- (void)setCurrentGifImage:(UIImage *)currentGifImage {
  if (_currentGifImage == currentGifImage) {
    return;
  }
  KDDLOCK([_currentGifImage imageViewShowFinished]);
  _currentGifImage = currentGifImage;
}

@end

@implementation KDDPhotoDecoder

- (void)main {
  if ([self isCancelled]) return;
  int incrBufferCount = _curImage.kdd_incrBufferCount.intValue;
  [_curImage kdd_setIncrBufferCount:@(incrBufferCount + 1)];
  if (_curImage.kdd_incrBufferCount.intValue > _curImage.kdd_maxBufferCount.intValue) {
    [_curImage kdd_setIncrBufferCount:_curImage.kdd_maxBufferCount];
  }
  
  NSUInteger index = _nextIndex;
  NSUInteger max   = _curImage.kdd_incrBufferCount.intValue;
  NSUInteger total = _curImage.kdd_totalFrameCount.intValue;
  for (int i = 0; i < max; i++, index++) {
    @autoreleasepool {
      if (index >= total) index = 0;
      if ([self isCancelled]) break;
      KDDLOCK(BOOL miss = (_curImage.kdd_imageBuffer[@(index)]) == nil);
      if (miss) {
        if ([self isCancelled]) break;
        KDDLOCK(UIImage *img = [_curImage animatedImageFrameAtIndex:(int)index]);
        if (img) {
          KDDLOCK([_curImage.kdd_imageBuffer setObject:img forKey:@(index)]);
        }
      }
    }
  }
}

@end
