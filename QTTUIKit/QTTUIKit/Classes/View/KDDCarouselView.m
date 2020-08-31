//
//  KDDCarouselView.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDCarouselView.h"
#import "KDDPageControl.h"
#import "UIView+QTTPosition.h"
#import <QTTFoundation/QTTFoundation.h>
#import <BlocksKit/BlocksKit.h>

@interface KDDCarouselView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) KDDPageControl *pageControl;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) NSTimer *carouselTimer;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL shouldResetContentOffset;

@end

@implementation KDDCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.carouselInterval = 4.f;
    self.automaticScroll = YES;
    [self loadScrollView];
    [self loadPageControl];
  }
  return self;
}

- (void)loadScrollView {
  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.delegate = self;
  self.scrollView.pagingEnabled = YES;
  self.scrollView.showsVerticalScrollIndicator = NO;
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.scrollsToTop = NO;
  self.scrollView.bounces = NO;
  [self addSubview:self.scrollView];
  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
  [self.scrollView addGestureRecognizer:tapGestureRecognizer];
}

- (void)tapGestureRecognizer {
  if (self.tapAction) {
    self.tapAction(self.currentIndex);
  }
}

- (void)loadPageControl {
  self.pageControl = [[KDDPageControl alloc] init];
  self.pageControl.hidesForSinglePage = YES;
  self.pageControl.userInteractionEnabled = NO;
  [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.scrollView.frame = self.bounds;
  self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 3, self.scrollView.height);
  CGRect contentRect = CGRectMake(self.contentViewInset.left, self.contentViewInset.top, self.width - self.contentViewInset.left - self.contentViewInset.right, self.height - self.contentViewInset.top - self.contentViewInset.bottom);
  self.middleView.frame = CGRectOffset(contentRect, self.scrollView.width, 0);
  self.leftView.frame = contentRect;
  self.rightView.frame = CGRectOffset(self.middleView.frame, self.scrollView.width, 0);
  
  [self.pageControl sizeToFit];
  self.pageControl.centerX = self.width / 2;
  self.pageControl.bottom = self.height;
  self.pageControl.top += self.pageControlEdgeInsets.top;
  self.pageControl.bottom -= self.pageControlEdgeInsets.bottom;
  if (self.shouldResetContentOffset) {
    [self.scrollView setContentOffset:CGPointMake(self.width, 0)];
    self.shouldResetContentOffset = NO;
  }
}

- (void)didMoveToWindow {
  [super didMoveToWindow];
  if (self.numberOfPages > 1) {
    if (self.window) {
      [self resumeTimer];
    } else {
      [self invalidTimer];
    }
  }
}

- (void)stopAutomaticScroll {
  [self invalidTimer];
}

- (void)resumeAutomaticScroll {
  [self resumeTimer];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self scrollViewDidEndScroll:scrollView delayTimer:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (!decelerate) {
    [self scrollViewDidEndScroll:scrollView delayTimer:YES];
  }
}

- (void)scrollViewDidEndScroll:(UIScrollView *)scrollView delayTimer:(BOOL)delayTimer {
  NSInteger pageIndex = (NSInteger)(scrollView.contentOffset.x / scrollView.width);
  if (pageIndex == 0) {
    // ------->
    self.currentIndex = [self leftIndexAtIndex:self.currentIndex];
  } else if (pageIndex == 2) {
    // <-------
    self.currentIndex = [self rightIndexAtIndex:self.currentIndex];
  }
  BLOCK_EXEC(self.didDisplay, self.middleView, self.currentIndex);
  
  [self configAllContentView];
  [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
  if (delayTimer) {
    [self delayTimer];
  }
}

- (void)configAllContentView {
  if (self.configContentViewBlock) {
    self.configContentViewBlock(self.leftView, [self leftIndexAtIndex:self.currentIndex]);
    self.configContentViewBlock(self.middleView, [self currentIndex]);
    self.configContentViewBlock(self.rightView, [self rightIndexAtIndex:self.currentIndex]);
  }
}

- (void)reloadData {
  self.pageControl.numberOfPages = self.numberOfPages;
  [self.scrollView qtt_removeAllSubviews];
  [self.carouselTimer invalidate];
  
  if (self.numberOfPages > 0 && self.configContentViewBlock && [self.contentViewClass isSubclassOfClass:[UIView class]]) {
    self.currentIndex = 0;
    
    self.middleView = [self.contentViewClass new];
    [self.scrollView addSubview:self.middleView];
    
    // bug fix: 首次启动时，无法统计到第一个banner坑位的曝光，这里用pageControl替代第一个banner坑位
    BLOCK_EXEC(self.didDisplay, self.pageControl, 0);
    
    if (self.numberOfPages > 1) {
      self.leftView = [self.contentViewClass new];
      [self.scrollView addSubview:self.leftView];
      
      self.rightView = [self.contentViewClass new];
      [self.scrollView addSubview:self.rightView];
      
      [self resumeTimer];
      [self configAllContentView];
      self.scrollView.scrollEnabled = YES;
    } else {
      // 单页情况
      self.scrollView.scrollEnabled = NO;
      self.configContentViewBlock(self.middleView, [self currentIndex]);
    }
    self.shouldResetContentOffset = YES;
  }
  [self setNeedsLayout];
}

#pragma mark - timer

- (void)invalidTimer {
  [self.carouselTimer invalidate];
}

- (void)resumeTimer {
  if (![self.carouselTimer isValid] && self.automaticScroll && self.numberOfPages > 1) {
    weakify(self);
    self.carouselTimer = [NSTimer bk_scheduledTimerWithTimeInterval:self.carouselInterval block:^(NSTimer *timer) {
      strongify(self);
      [UIView animateWithDuration:.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0)];
      } completion:^(BOOL finished) {
        [self scrollViewDidEndScroll:self.scrollView delayTimer:NO];
      }];
    } repeats:YES];
  }
}

- (void)delayTimer {
  if ([self.carouselTimer isValid]) {
    NSDate *dateAfter = [NSDate dateWithTimeIntervalSinceNow:self.carouselInterval];
    self.carouselTimer.fireDate = dateAfter;
  }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
  _currentIndex = currentIndex;
  self.pageControl.currentPage = currentIndex;
}

- (NSInteger)leftIndexAtIndex:(NSInteger)index {
  return index == 0 ? self.numberOfPages - 1 : index - 1;
}

- (NSInteger)rightIndexAtIndex:(NSInteger)index {
  return index == self.numberOfPages - 1 ? 0 : index + 1;
}

- (void)setShowPageControl:(BOOL)showPageControl {
  _showPageControl = showPageControl;
  self.pageControl.hidden = !showPageControl;
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
  _pageIndicatorTintColor = pageIndicatorTintColor;
  self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
  _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
  self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

@end
