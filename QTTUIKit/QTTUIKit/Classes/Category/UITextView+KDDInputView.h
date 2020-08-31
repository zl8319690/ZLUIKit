//
//  UITextView+KDDInputView.h
//  KDDSquareModule
//
//  Created by lyj on 2019/9/6.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDDInputViewDelegate <NSObject>

- (void)kdd_inputViewDidChangeHeight:(CGFloat)height;

@end

@interface UITextView (KDDInputView)

@property (nonatomic, weak) id<KDDInputViewDelegate> kdd_delegate;

@property (nonatomic,copy) NSString *kdd_placeholder;

@property (nonatomic,copy) UIColor *kdd_placeholderColor;

@property (nonatomic,strong) UIFont *kdd_placeholderFont;

@property (nonatomic,assign) NSUInteger kdd_maxNumberOfLines;

@property (nonatomic,assign) BOOL kdd_autoLineBreak;

@end

NS_ASSUME_NONNULL_END
