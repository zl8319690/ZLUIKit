//
//  KDDCarouselView.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDCarouselView : UIView


@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSTimeInterval carouselInterval; // default is 4s

@property (nonatomic, assign) BOOL showPageControl; // default rely on numberOfPages
@property (nonatomic, assign) UIEdgeInsets pageControlEdgeInsets; // default is UIEdgeInsetsZero
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, strong) Class contentViewClass; // should is subclass of `UIView`
@property (nonatomic, assign) UIEdgeInsets contentViewInset; // default is UIEdgeInsetsZero
@property (nonatomic, copy) void(^configContentViewBlock)(__kindof UIView *contentView, NSInteger index); // contentView is kind of `contentViewClass`

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@property (nonatomic, assign) BOOL automaticScroll; // default is YES;

@property (nonatomic, copy) void(^tapAction)(NSInteger index);

@property (nonatomic, copy) void (^didDisplay)(UIView* bannerView, NSInteger index);

- (void)reloadData;

- (void)stopAutomaticScroll;
- (void)resumeAutomaticScroll;

@end

NS_ASSUME_NONNULL_END
