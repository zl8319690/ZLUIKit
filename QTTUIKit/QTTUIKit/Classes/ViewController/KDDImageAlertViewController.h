//
//  KDDImageAlertViewController.h
//  QTTUIKit
//
//  Created by lyj on 2019/12/9.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDImageAlertViewController : UIViewController

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle
               submitBtnTitle:(NSString *)submitBtnTitle;

@property (nonatomic, assign) BOOL showClose;

@property (nonatomic, copy) void(^submitActionHandler)(KDDImageAlertViewController *alert);
@property (nonatomic, copy) void(^closeActionHandler)(KDDImageAlertViewController *alert);

- (void)close;

@end

NS_ASSUME_NONNULL_END
