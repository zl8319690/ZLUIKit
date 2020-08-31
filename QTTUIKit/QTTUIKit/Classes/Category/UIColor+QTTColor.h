//
//  UIColor+QTTColor.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern UIColor * QTTColorConvenience(unsigned c);
extern UIColor * QTTColorFromRGB(NSUInteger value);
extern UIColor * QTTColorFromRGBA(NSUInteger value, CGFloat alpha);
extern UIColor * QTTRandomColor(void);
extern UIColor * QTTRGBColor(unsigned r, unsigned g, unsigned b);
extern UIColor * QTTRGBAColor(unsigned r, unsigned g, unsigned b, CGFloat a);
extern UIColor * QTTColorFromHexString(NSString *hex);

NS_ASSUME_NONNULL_END
