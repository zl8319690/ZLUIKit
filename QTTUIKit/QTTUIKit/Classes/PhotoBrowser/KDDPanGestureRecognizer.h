//
//  KDDPanGestureRecognizer.h
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KDDPanGestureRecognizerDirection) {
    KDDPanGestureRecognizerDirectionVertical,
    KDDPanGestureRecognizerDirectionHorizontal
};

@interface KDDPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) KDDPanGestureRecognizerDirection direction;

@end

NS_ASSUME_NONNULL_END
