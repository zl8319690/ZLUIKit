//
//  QTTTableViewController.m
//  QTTUIKit
//
//  Created by XIN on 2019/8/7.
//  Copyright © 2019 Qutoutiao, Ltd. All rights reserved.
//

#import "QTTTableViewController.h"
#import "QTTTableView.h"
#import <Masonry/Masonry.h>

@interface QTTTableViewController ()

@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation QTTTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _style = style;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addTableViewToViewHierarchyIfNeeded];
}

- (void)addTableViewToViewHierarchyIfNeeded {
  if (!self.tableView.superview) {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
    }];
  }
}

- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QTTTableView alloc] initWithFrame:CGRectZero style:self.style];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert(NO, @"subclass should implement this");
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSAssert(NO, @"subclass should implement this");
  return 0;
}

@end
