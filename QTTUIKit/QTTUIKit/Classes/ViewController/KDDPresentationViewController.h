//
//  KDDPresentationViewController.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/6.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTViewController.h"

@protocol KDDPresentationDelegate <NSObject>

@optional
- (void)animateAlongPresentation:(BOOL)appear;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDDPresentationViewController : QTTViewController

- (instancetype)initWithContentViewController:(QTTViewController<KDDPresentationDelegate> *)viewController;

@property (nonatomic, strong, readonly) QTTViewController<KDDPresentationDelegate> *contentViewController;

+ (void)showContentViewController:(QTTViewController <KDDPresentationDelegate> *)viewController
         fromSourceViewController:(UIViewController *)sourceViewController;

@end

NS_ASSUME_NONNULL_END
