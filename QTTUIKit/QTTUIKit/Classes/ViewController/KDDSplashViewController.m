//
//  KDDSplashViewController.m
//  QTTUIKit
//
//  Created by lyj on 2019/12/14.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDSplashViewController.h"
#import "UIImage+QTTUIKit.h"
#import <Masonry/Masonry.h>

@interface KDDSplashViewController ()

@property (nonatomic, strong) UIImageView *splashImageView;

@end

@implementation KDDSplashViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadSplash];
}

- (void)loadSplash {
  [self.view addSubview:self.splashImageView];
  [self.splashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
  }];
}

#pragma mark - Accessors

- (UIImageView *)splashImageView {
  if (!_splashImageView) {
    _splashImageView = [[UIImageView alloc] initWithImage:[UIImage qtt_splashImage]];
  }
  return _splashImageView;
}

@end
