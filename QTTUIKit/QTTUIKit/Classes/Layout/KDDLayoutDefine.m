//
//  KDDLayoutDefine.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/4.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDLayoutDefine.h"
#import "QTTColor.h"

CGFloat KDDScreenWidth(KDDScaleReferenceDevice referenceDevice) {
  switch (referenceDevice) {
    case KDDScaleReferenceDevice6:
      return 375.f;
      break;
      
    case KDDScaleReferenceDevice4:
      return 320.f;
      break;
      
    default:
      NSCAssert(NO, @"referenceDevice not valid");
      return 375.f;
      break;
  }
}

CGFloat KDDScreenHeight(KDDScaleReferenceDevice referenceDevice) {
  switch (referenceDevice) {
    case KDDScaleReferenceDevice6:
      return 667.f;
      break;
      
    case KDDScaleReferenceDevice4:
      return 480.f;
      break;
      
    default:
      NSCAssert(NO, @"referenceDevice not valid");
      return 667.f;
      break;
  }
}

CGFloat KDDHorizontallyScaledValue(CGFloat originalValue, KDDScaleReferenceDevice referenceDevice) {
  return originalValue * [UIScreen mainScreen].bounds.size.width / KDDScreenWidth(referenceDevice);
}

CGFloat KDDHorizScale6(CGFloat originalValue) {
  return KDDHorizontallyScaledValue(originalValue, KDDScaleReferenceDevice6);
}

CGFloat KDDVerticallyScaledValue(CGFloat originalValue, KDDScaleReferenceDevice referenceDevice) {
  return originalValue * [UIScreen mainScreen].bounds.size.height / KDDScreenHeight(referenceDevice);
}

CGFloat KDDVertScale6(CGFloat originalValue) {
  return KDDVerticallyScaledValue(originalValue, KDDScaleReferenceDevice6);
}

UIImage* KDDGradientImage(UIColor *startColor, UIColor*endColor, CGSize size) {
  static dispatch_once_t onceToken;
  static UIImage *gradientImage = nil;
  dispatch_once(&onceToken, ^{
    NSArray *colors = @[startColor, endColor ];
    CFMutableArrayRef colorsRef = CFArrayCreateMutable(NULL, colors.count, NULL);
    for (UIColor *color in colors) {
      CFArrayAppendValue(colorsRef, color.CGColor);
    }
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpaceRef,
                                             kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpaceRef, colorsRef, NULL);
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(size.width, 0),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGGradientRelease(gradient);
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpaceRef);
    if (colorsRef) {
      CFRelease(colorsRef);
    }
    gradientImage = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
  });
  return gradientImage;
}

UIImage* KDDGradientImageWithSize(CGSize size) {
  CGSize fullSize = CGSizeMake([[UIScreen mainScreen] nativeBounds].size.width, 2);
  UIImage *originImage = KDDGradientImage(QTTColor.qttRedColor, QTTColor.qttLightRedColor, fullSize);
  UIGraphicsBeginImageContextWithOptions(size, NO, 0);
  [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}
