//
//  KDDPageControl.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPageControl.h"

static const CGFloat kESPPageControlWidth = 10;
static const CGFloat kESPPageControlHeight = 2;
static const CGFloat kESPPageControlSpacing = 2;

@implementation KDDPageControl

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _numberOfPages = 0;
    _currentPage = 0;
    _hidesForSinglePage = NO;
    _pageIndicatorTintColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    _currentPageIndicatorTintColor = UIColor.whiteColor;
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
  if (_numberOfPages == numberOfPages) {
    return;
  }
  if (numberOfPages < 0) {
    NSAssert(NO, @"⚠️ numberOfPages must be greater than or equal to 0");
    return;
  }
  _numberOfPages = numberOfPages;
  [self invalidateIntrinsicContentSize];
  [self _updateHiddenAfterNumberOfPagesChange];
  [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage {
  if (_currentPage == currentPage) {
    return;
  }
  if (currentPage + 1 > self.numberOfPages || currentPage < 0) {
    return;
  }
  _currentPage = currentPage;
  [self setNeedsDisplay];
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
  if (_hidesForSinglePage == hidesForSinglePage) {
    return;
  }
  _hidesForSinglePage = hidesForSinglePage;
  [self setNeedsDisplay];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
  _pageIndicatorTintColor = pageIndicatorTintColor;
  [self setNeedsDisplay];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
  _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
  [self setNeedsDisplay];
}

- (CGSize)intrinsicContentSize {
  const NSInteger numberOfPages = self.numberOfPages;
  return CGSizeMake(numberOfPages * kESPPageControlWidth + (numberOfPages - 1) * kESPPageControlSpacing,
                    kESPPageControlHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self intrinsicContentSize];
}

#pragma mark - private sync status

- (void)_updateHiddenAfterNumberOfPagesChange {
  if (self.hidesForSinglePage == YES) {
    if (self.numberOfPages <= 1) {
      self.hidden = YES;
    } else {
      self.hidden = NO;
    }
  }
}

#pragma mark - draw

- (void)drawRect:(CGRect)rect {
  const NSInteger numberOfPages = self.numberOfPages;
  const NSInteger currentPage = self.currentPage;
  UIColor *const normalColor = self.pageIndicatorTintColor;
  UIColor *const selectColor = self.currentPageIndicatorTintColor;
  
  const CGFloat fullIndicatorsWidth =
  numberOfPages * kESPPageControlWidth + (numberOfPages - 1) * kESPPageControlSpacing;
  const CGFloat left = (CGRectGetWidth(rect) - fullIndicatorsWidth) / 2;
  const CGFloat top = (CGRectGetHeight(rect) - kESPPageControlHeight) / 2;
  CGContextRef context = UIGraphicsGetCurrentContext();
  for (NSInteger index = 0; index < numberOfPages; index++) {
    CGRect currentIndicatorFrame = CGRectMake(left + index * (kESPPageControlWidth + kESPPageControlSpacing), top,
                                              kESPPageControlWidth, kESPPageControlHeight);
    [KDDPageControl _drawIndicatorWithColor:index == currentPage ? selectColor : normalColor
                                      frame:currentIndicatorFrame
                                  inContext:context];
  }
}

+ (void)_drawIndicatorWithColor:(UIColor *)color frame:(CGRect)frame inContext:(CGContextRef)context {
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, frame);
}

@end
