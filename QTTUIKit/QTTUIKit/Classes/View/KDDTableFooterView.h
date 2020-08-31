//
//  KDDTableFooterView.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/5.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDTableFooterView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textLabelTextAlignment;

@end

@interface UITableViewHeaderFooterView (KDDExt)

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
