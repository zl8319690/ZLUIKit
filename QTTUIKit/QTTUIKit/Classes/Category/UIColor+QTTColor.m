//
//  UIColor+QTTColor.m
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIColor+QTTColor.h"

UIColor * QTTColorConvenience(unsigned c) {
  return [UIColor colorWithRed:(CGFloat)c / 255.0
                         green:(CGFloat)c / 255.0
                          blue:(CGFloat)c / 255.0
                         alpha:1];
}

UIColor * QTTColorFromRGB(NSUInteger value) {
  return QTTColorFromRGBA(value, 1.0);
}

UIColor * QTTColorFromRGBA(NSUInteger value, CGFloat alpha) {
  return [UIColor colorWithRed:((value & 0xff0000) >> 16) / 255.0
                         green:((value & 0x00ff00) >> 8) / 255.0
                          blue:(value & 0x0000ff) / 255.0
                         alpha:alpha];
}

UIColor * QTTRandomColor() {
  CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
  CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
  CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

UIColor * QTTRGBColor(unsigned r, unsigned g, unsigned b) {
  return QTTRGBAColor(r, g, b, 1);
}

UIColor * QTTRGBAColor(unsigned r, unsigned g, unsigned b, CGFloat a) {
  return [UIColor colorWithRed:(CGFloat)r / 255.0
                         green:(CGFloat)g / 255.0
                          blue:(CGFloat)b / 255.0
                         alpha:a];
}
