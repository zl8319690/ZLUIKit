//
//  QTTTableView.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTTableView : UITableView

@end

@interface UITableView (QTTReuse)

/**
 *  regist a cell class which inhired from QTTTableViewCell, required method reuseIdentifier
 *
 *  @param cellClass is cell class
 */
- (void)qtt_registerCellClass:(nonnull Class)cellClass;

- (void)qtt_registerHeaderFooterClass:(nonnull Class)headerFooterClass;

- (nullable __kindof UITableViewCell *)qtt_dequeueReusableCellWithClass:(nonnull Class)cellClass;

- (nullable __kindof UITableViewHeaderFooterView *)qtt_dequeueReusableHeaderFooterViewWithClass:(nonnull Class)headerFooterClass;

@end

NS_ASSUME_NONNULL_END
