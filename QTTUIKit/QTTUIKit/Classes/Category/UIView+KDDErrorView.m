//
//  UIView+KDDErrorView.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIView+KDDErrorView.h"
#import "QTTUIKit.h"
#import <QTTFoundation/QTTFoundation.h>
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@interface KDDErrorPage()

@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *methodLink;
@property (nonatomic, strong) UIButton *retryBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *tipsBgView;

@end

@implementation KDDErrorPage

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUpUI];
  }
  return self;
}

- (void)setUpUI {
  [self setBackgroundColor:[UIColor whiteColor]];
  self.bgView = [[UIView alloc] init];
  [self.bgView setBackgroundColor:[UIColor whiteColor]];
  self.tipsBgView = [[UIView alloc] init];
  [self.tipsBgView setBackgroundColor:[UIColor whiteColor]];
  self.errorImageView = [[UIImageView alloc] init];
  
  self.tipsLabel = [[UILabel alloc] init];
  [self.tipsLabel setTextAlignment:NSTextAlignmentCenter];
  [self.tipsLabel setNumberOfLines:0];
  [self.tipsLabel setFont:[QTTFont titleFont]];
  [self.tipsLabel setTextColor:[QTTColor color6D]];
  
  self.methodLink = [[UILabel alloc] init];
  [self.methodLink setFont:[QTTFont titleFont]];
  [self.methodLink setTextColor:[QTTColor textBlueColor]];
  
  self.retryBtn = [[UIButton alloc] init];
  [self.retryBtn setBackgroundColor:[QTTColor buttonRedColor]];
  [self.retryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.retryBtn.titleLabel setFont:[QTTFont titleFont]];
  [self.retryBtn setTitle:@"点击重试" forState:UIControlStateNormal];
  self.retryBtn.layer.cornerRadius = 5.0;
  self.retryBtn.layer.masksToBounds = YES;
  
  [self addSubview:self.bgView];
  [self.bgView addSubview:self.errorImageView];
  [self.bgView addSubview:self.tipsBgView];
  [self.tipsBgView addSubview:self.tipsLabel];
  [self.tipsBgView addSubview:self.methodLink];
  [self.bgView addSubview:self.retryBtn];
  
  [self.errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(0);
    make.centerX.mas_equalTo(0);
    make.size.mas_equalTo(CGSizeMake(180, 180));
  }];
  
  [self.tipsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_lessThanOrEqualTo(DEVICE_FULL_SIZE_WIDTH - 2*DEFAULT_INDENTATION);
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(self.errorImageView.mas_bottom).mas_offset(10);
    make.height.mas_greaterThanOrEqualTo(22);
  }];
  
  [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(0);
    make.top.bottom.mas_equalTo(0);
  }];
  
  [self.methodLink mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(0);
    make.centerY.mas_equalTo(0);
    make.left.mas_equalTo(self.tipsLabel.mas_right).mas_offset(5);
  }];
  
  [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(111, 38));
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(14);
  }];
  
  [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(0);
    make.width.mas_equalTo(DEVICE_FULL_SIZE_WIDTH - 2*DEFAULT_INDENTATION);
    make.top.mas_equalTo(self.errorImageView.mas_top);
    make.bottom.mas_equalTo(self.retryBtn.mas_bottom);
  }];
}

- (void)setErrorType:(KDDErrorViewType)type {
  if (type == KDDErrorViewTypeNoNetWork) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:YES];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:NO];
    
    [self.tipsLabel setText:@"网络未连接"];
    [self.methodLink setText:@""];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"no_network"]];
  } else if (type == KDDErrorViewTypeNetWorkError) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:NO];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:NO];
    
    [self.tipsLabel setText:@"网络异常"];
    [self.methodLink setText:@"查看解决方案"];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"no_network"]];
  } else if (type == KDDErrorViewTypeNoneUploaded) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:YES];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:YES];
    
    [self.tipsLabel setText:@"该用户暂未上传视频"];
    [self.methodLink setText:@""];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"none_upload"]];
  } else if (type == KDDErrorViewTypeNoneSearched) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:YES];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:YES];
    
    [self.tipsLabel setText:@"搜不到相关内容\n请重新输入"];
    [self.methodLink setText:@""];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"none_search"]];
  } else if (type == KDDErrorViewTypeNoVideo) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:YES];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:YES];
    
    [self.tipsLabel setText:@"暂无视频"];
    [self.methodLink setText:@""];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"none_upload"]];
  } else if (type == KDDErrorViewTypeNoData) {
    [self.tipsLabel setHidden:NO];
    [self.methodLink setHidden:YES];
    [self.errorImageView setHidden:NO];
    [self.retryBtn setHidden:YES];
    
    [self.tipsLabel setText:@"暂无内容"];
    [self.methodLink setText:@""];
    [self.errorImageView setImage:[UIImage qtt_imageNamedInQTTUIKit:@"none_upload"]];
  } else if (type == KDDErrorViewTypeNoComment) {
    self.tipsLabel.hidden = NO;
    self.methodLink.hidden = YES;
    self.errorImageView.hidden = NO;
    self.retryBtn.hidden = YES;
    
    self.tipsLabel.text = @"还没有人评论，快抢沙发吧~";
    self.methodLink.text = @"";
    self.errorImageView.image = [UIImage qtt_imageNamedInQTTUIKit:@"none_upload"];
  }
}

@end

#pragma mark 网络异常修复提示页面

@interface KDDNetworkFixTipsView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *seperateLine;
@property (nonatomic, strong) UILabel *tipsLine1;
@property (nonatomic, strong) UILabel *tipsLine2;
@property (nonatomic, strong) UILabel *tipsLine3;
@property (nonatomic, strong) UILabel *tipsLine4;

@end

@implementation KDDNetworkFixTipsView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUpUI];
  }
  return self;
}

- (void)setUpUI {
  [self addSubview:self.titleLabel];
  [self addSubview:self.seperateLine];
  [self addSubview:self.tipsLine1];
  [self addSubview:self.tipsLine2];
  [self addSubview:self.tipsLine3];
  [self addSubview:self.tipsLine4];

  [self setBackgroundColor:[UIColor whiteColor]];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(KDDNavigationBarHeight + 30);
  }];
  
  [self.seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15);
    make.height.mas_equalTo(1);
  }];
  
  [self.tipsLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(self.seperateLine.mas_bottom).mas_offset(15);
  }];
  
  [self.tipsLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(self.tipsLine1.mas_bottom).mas_offset(15);
  }];
  
  [self.tipsLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(self.tipsLine2.mas_bottom).mas_offset(15);
  }];
  
  [self.tipsLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(25);
    make.right.mas_equalTo(-25);
    make.top.mas_equalTo(self.tipsLine3.mas_bottom).mas_offset(15);
  }];
}

#pragma mark GET

- (UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setFont:[QTTFont boldTitleFont]];
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setText:@"你的设备未启用移动网络或WIFI网络"];
  }
  return _titleLabel;
}

- (UIView *)seperateLine {
  if (!_seperateLine) {
    _seperateLine = [[UIView alloc] init];
    [_seperateLine setBackgroundColor:[QTTColor colorE9]];
  }
  return _seperateLine;
}

- (UILabel *)tipsLine1 {
  if (!_tipsLine1) {
    _tipsLine1 = [[UILabel alloc] init];
    [_tipsLine1 setNumberOfLines:0];
    [_tipsLine1 setFont:[QTTFont detailFont]];
    [_tipsLine1 setTextColor:[QTTColor colorA7]];
    [_tipsLine1 setText:@"建议你："];
  }
  return _tipsLine1;
}

- (UILabel *)tipsLine2 {
  if (!_tipsLine2) {
    _tipsLine2 = [[UILabel alloc] init];
    [_tipsLine2 setNumberOfLines:0];
    [_tipsLine2 setFont:[QTTFont detailFont]];
    [_tipsLine2 setTextColor:[UIColor blackColor]];
    [_tipsLine2 setText:@"• 在设备的“设置”-“WLAN”选择一个可用的网络。"];
  }
  return _tipsLine2;
}

- (UILabel *)tipsLine3 {
  if (!_tipsLine3) {
    _tipsLine3 = [[UILabel alloc] init];
    [_tipsLine3 setNumberOfLines:0];
    [_tipsLine3 setFont:[QTTFont detailFont]];
    [_tipsLine3 setTextColor:[UIColor blackColor]];
    [_tipsLine3 setText:@"• 在设备中“设置”-“移动网络”，打开“启用数据流量”（可能会收取流量费）"];
  }
  return _tipsLine3;
}

- (UILabel *)tipsLine4 {
  if (!_tipsLine4) {
    _tipsLine4 = [[UILabel alloc] init];
    [_tipsLine4 setNumberOfLines:0];
    [_tipsLine4 setFont:[QTTFont detailFont]];
    [_tipsLine4 setTextColor:[QTTColor colorA7]];
    [_tipsLine4 setText:@"*如你已链接到WLAN网络，请检查该WLAN网络是否已接入互联网"];
  }
  return _tipsLine4;
}

@end

static char UIViewKDDErrorView;

@implementation UIView (KDDErrorView)
@dynamic kdd_errorPage;

- (void)kdd_showErrorPageWithType:(KDDErrorViewType)type {
  [self kdd_showErrorPageWithType:type RetryActionHandler:^{}];
}

- (void)kdd_showErrorPageWithType:(KDDErrorViewType)type RetryActionHandler:(void (^)(void))actionHandler {
  if (!self.kdd_errorPage) {
    self.kdd_errorPage = [[KDDErrorPage alloc] init];
    [self addSubview:self.kdd_errorPage];
    
    [self.kdd_errorPage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(0);
    }];
  }
  
  [self.kdd_errorPage setErrorType:type];
  [self.kdd_errorPage setHidden:NO];
  
  __weak typeof(self)weakSelf = self;
  [self.kdd_errorPage.retryBtn qtt_addEventHandler:^{
    __strong typeof(weakSelf)strongSelf = weakSelf;
    [strongSelf.kdd_errorPage setHidden:YES];
    if (actionHandler) {
      actionHandler();
    }
  } forControlEvents:UIControlEventTouchUpInside];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kdd_showMethod)];
  [self.kdd_errorPage.methodLink setUserInteractionEnabled:YES];
  [self.kdd_errorPage.methodLink addGestureRecognizer:tap];
  
  [self bringSubviewToFront:self.kdd_errorPage];
}

#pragma mark Actions

- (void)kdd_hiddenErrorPage {
  if (self.kdd_errorPage) {
    [self.kdd_errorPage setHidden:YES];
  }
}

- (void)kdd_showMethod {
  UINavigationController *navi = self.navigationController;
  if (navi) {
    QTTViewController *tipsVC = [[QTTViewController alloc] init];
    KDDNetworkFixTipsView *tipsView = [[KDDNetworkFixTipsView alloc] init];
    [tipsVC.view addSubview:tipsView];
    [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(0);
    }];
    [navi pushViewController:tipsVC animated:YES];
  }
}

#pragma mark GET+SET

- (void)setKdd_errorPage:(KDDErrorPage *)errorPage {
  [self willChangeValueForKey:@"kdd_errorPage"];
  objc_setAssociatedObject(self, &UIViewKDDErrorView,
                           errorPage,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self didChangeValueForKey:@"kdd_errorPage"];
}

- (KDDErrorPage *)kdd_errorPage {
  return objc_getAssociatedObject(self, &UIViewKDDErrorView);
}
@end
