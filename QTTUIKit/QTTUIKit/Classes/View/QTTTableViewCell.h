//
//  QTTTableViewCell.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTTableViewCell : UITableViewCell

/// 是否隐藏系统分割线
@property (nonatomic, assign) BOOL shouldHideSeparatorView;

@end

@interface UITableViewCell (QTTExtension)

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
