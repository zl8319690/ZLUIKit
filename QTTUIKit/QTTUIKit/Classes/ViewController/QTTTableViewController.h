//
//  QTTTableViewController.h
//  QTTUIKit
//
//  Created by XIN on 2019/8/7.
//  Copyright © 2019 Qutoutiao All rights reserved.
//

#import "QTTViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class QTTTableView;

@interface QTTTableViewController : QTTViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@property (nonatomic, strong, null_resettable) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
