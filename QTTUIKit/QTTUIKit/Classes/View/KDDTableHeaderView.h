//
//  KDDTableHeaderView.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/5.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

+ (KDDTableHeaderView *)tableHeaderLabelWithTitle:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
