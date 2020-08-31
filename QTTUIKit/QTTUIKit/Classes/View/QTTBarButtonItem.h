//
//  QTTBarButtonItem.h
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTBarButtonItem : UIBarButtonItem

typedef void (^QTTBarButtonItemAction)(void);

@property (nonatomic, copy) QTTBarButtonItemAction blockAction;

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                    handler:(nullable QTTBarButtonItemAction)action;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title handler:(nullable QTTBarButtonItemAction)action;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImage:(UIImage *)image handler:(nullable QTTBarButtonItemAction)action;

@end

NS_ASSUME_NONNULL_END
