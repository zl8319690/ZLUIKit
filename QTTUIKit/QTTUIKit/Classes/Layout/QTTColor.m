//
//  QTTColor.m
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTColor.h"
#import <UIKit/UIKit.h>
#import "UIColor+QTTColor.h"

#define QTTCOLORDEFINEVALUE(__name__, __value__)                                                                       \
+(UIColor *)__name__ {                                                                                               \
static UIColor *color;                                                                                             \
static dispatch_once_t onceToken;                                                                                  \
dispatch_once(&onceToken, ^{                                                                                       \
color = __value__;                                                                                               \
});                                                                                                                \
return color;                                                                                                      \
}

#define QTTCOLORDEFINEHEX(__name__, __hex__) QTTCOLORDEFINEVALUE(__name__, QTTColorFromRGB(__hex__))

@implementation QTTColor

QTTCOLORDEFINEHEX(color20, 0x202020)
QTTCOLORDEFINEHEX(color28, 0x282828)
QTTCOLORDEFINEHEX(color33, 0x333333)
QTTCOLORDEFINEHEX(colorF0, 0xF0F0F0)
QTTCOLORDEFINEHEX(color7E, 0x7E7E7E)
QTTCOLORDEFINEHEX(color73, 0x737373)
QTTCOLORDEFINEHEX(color76, 0x767676)
QTTCOLORDEFINEHEX(color95, 0x959595)
QTTCOLORDEFINEHEX(colorBB, 0xBBBBBB)
QTTCOLORDEFINEHEX(colorC3, 0xC3C3C3)
QTTCOLORDEFINEHEX(color6D, 0x6D6D6D)
QTTCOLORDEFINEHEX(colorE9, 0xE9E9E9)
QTTCOLORDEFINEHEX(colorA7, 0xA7A7A7)
QTTCOLORDEFINEHEX(colorDD, 0xDDDDDD)
QTTCOLORDEFINEHEX(colorD8, 0xD8D8D8)
QTTCOLORDEFINEHEX(color50, 0x505050)
QTTCOLORDEFINEHEX(colorCC, 0xCCCCCC)
QTTCOLORDEFINEHEX(color9B, 0x9B9B9B)
QTTCOLORDEFINEHEX(color79, 0x797979)
QTTCOLORDEFINEHEX(colorF3, 0xF3F3F3)
QTTCOLORDEFINEHEX(colorF6, 0xF6F6F6)
QTTCOLORDEFINEHEX(color74, 0x747474)
QTTCOLORDEFINEHEX(color8B, 0x8B8B8B)
QTTCOLORDEFINEHEX(colorB8, 0xB8B8B8)
QTTCOLORDEFINEHEX(color9C, 0x9C9C9C)
QTTCOLORDEFINEHEX(color4C, 0x4C4C4C)
QTTCOLORDEFINEHEX(color38, 0x383838)
QTTCOLORDEFINEHEX(colorAB, 0xABABAB)
QTTCOLORDEFINEHEX(colorEE, 0xEEEEEE)
QTTCOLORDEFINEHEX(color65, 0x656565)
QTTCOLORDEFINEHEX(colorF7, 0xF7F7F7)
QTTCOLORDEFINEHEX(colorEA, 0xEAEAEA)
QTTCOLORDEFINEHEX(color99, 0x999999)
QTTCOLORDEFINEHEX(colorF8, 0xF8F8F8)

QTTCOLORDEFINEHEX(textBrownColor, 0x403434)
QTTCOLORDEFINEHEX(textDarkBrownColor, 0x4B3D3F)
QTTCOLORDEFINEHEX(backgroundLightRedColor, 0xFFEBED)
QTTCOLORDEFINEHEX(textBlueColor, 0x1985FF)
QTTCOLORDEFINEHEX(buttonRedColor, 0xFA1F40)
QTTCOLORDEFINEHEX(buttonTitleGrayColor, 0x3C3437)
QTTCOLORDEFINEHEX(alertTitleColor, 0x313332)
QTTCOLORDEFINEHEX(grayBorderColor, 0xBCB7B3)
QTTCOLORDEFINEHEX(textGrayColor, 0x686666)
QTTCOLORDEFINEHEX(tableViewHeaderFooterColor, 0x99999B)
QTTCOLORDEFINEHEX(backgroundBlueColor, 0x2D85F3)
QTTCOLORDEFINEHEX(textDarkGrayColor, 0x2F2929)
QTTCOLORDEFINEVALUE(buttonDisableColor, self.colorC3);
QTTCOLORDEFINEHEX(seperateLineGrayColor, 0xDCDDDE)

QTTCOLORDEFINEHEX(detailColor, 0x989CA4)
QTTCOLORDEFINEHEX(chatRedColor, 0xFF5A5A)
QTTCOLORDEFINEHEX(imageViewBackgroundColor, 0xE1E1E1)

QTTCOLORDEFINEHEX(qttRedColor, 0xFA2640)
QTTCOLORDEFINEHEX(qttLightRedColor, 0xFF2B87)
QTTCOLORDEFINEHEX(colorTextLightGrayColor, 0x3A404C)

QTTCOLORDEFINEVALUE(backgroundColor, UIColor.whiteColor)
QTTCOLORDEFINEVALUE(navigationBarColor,UIColor.whiteColor)
QTTCOLORDEFINEVALUE(navigationBarTitleColor, UIColor.blackColor)
QTTCOLORDEFINEVALUE(translucentQttRedColor, [UIColor colorWithRed:250/255.0 green:38/255.0 blue:64/255.0 alpha:0.4])
QTTCOLORDEFINEVALUE(translucentBlackColor, [[UIColor blackColor] colorWithAlphaComponent:0.6])

@end
