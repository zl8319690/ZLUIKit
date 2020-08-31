//
//  UIView+KDDErrorView.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
  KDDErrorViewTypeNoNetWork,      // 无网络异常页，有重试按钮
  KDDErrorViewTypeNetWorkError,   // 网络异常页面，有重试按钮
  KDDErrorViewTypeNoVideo,        // 暂无视频页面，无重试按钮
  KDDErrorViewTypeNoData,         // 暂无内容页面，无重试按钮
  KDDErrorViewTypeNoneSearched,   // 搜不到内容页面，无重试按钮
  KDDErrorViewTypeNoneUploaded,   // 暂未上传视频页面，无重试按钮
  KDDErrorViewTypeNoComment       // 无评论页面，无重试按钮
} KDDErrorViewType;

@interface KDDErrorPage : UIView

@end

@interface KDDNetworkFixTipsView : UIView

@end

@interface UIView (KDDErrorView)

@property (nonatomic, strong, readonly) KDDErrorPage *kdd_errorPage;

- (void)kdd_showErrorPageWithType:(KDDErrorViewType)type;

/**
 显示异常页（包括：空数据页、网络异常页）

 @param type 异常类型
 @param actionHandler 重试事件（仅网络异常时需要传入，其他状态传nil即可）
 */
- (void)kdd_showErrorPageWithType:(KDDErrorViewType)type RetryActionHandler:(void (^)(void))actionHandler;

/**
 隐藏异常页面
 */
- (void)kdd_hiddenErrorPage;

@end

NS_ASSUME_NONNULL_END
