//
//  KDDPageControl.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDPageControl : UIView

@property (nonatomic) NSInteger numberOfPages; // default is 0
@property (nonatomic) NSInteger currentPage;   // default is 0. value pinned to 0..numberOfPages-1

@property (nonatomic) BOOL hidesForSinglePage; // hide the the indicator if there is only one page. default is NO

@property (nullable, nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nullable, nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@end

NS_ASSUME_NONNULL_END
