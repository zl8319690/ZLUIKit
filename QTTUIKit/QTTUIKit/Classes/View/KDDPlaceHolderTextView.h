//
//  KDDPlaceHolderTextView.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDDPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

@property (nonatomic, assign) UIEdgeInsets placeHolderInset;

@end

NS_ASSUME_NONNULL_END
