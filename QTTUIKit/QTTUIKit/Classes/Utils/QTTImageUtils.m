//
//  QTTImageUtils.m
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTImageUtils.h"
#import "QTTImageMaker.h"
#import "QTTFoundation.h"

@implementation QTTImageUtils

+ (UIImage *)setImage:(UIImage *)image opacity:(float)opacity {
  UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
  CGContextScaleCTM(ctx, 1, -1);
  CGContextTranslateCTM(ctx, 0, -area.size.height);
  CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
  CGContextSetAlpha(ctx, opacity);
  CGContextDrawImage(ctx, area, image.CGImage);
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, image.capInsets)) {
    newImage = [newImage resizableImageWithCapInsets:image.capInsets];
  }
  if (newImage.renderingMode != image.renderingMode) {
    newImage = [newImage imageWithRenderingMode:image.renderingMode];
  }
  return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
  if (!image || CGSizeEqualToSize(CGSizeZero, image.size)) {
    return nil;
  }
  if (CGSizeEqualToSize(image.size, size)) {
    return image;
  }
  UIImage *result = nil;
  CGImageRef imageRef = image.CGImage;
  CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
  CGFloat scale = [UIScreen mainScreen].scale;
  CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
  
  BOOL hasAlpha = NO;
  if (alphaInfo == kCGImageAlphaPremultipliedLast ||
      alphaInfo == kCGImageAlphaPremultipliedFirst ||
      alphaInfo == kCGImageAlphaLast ||
      alphaInfo == kCGImageAlphaFirst) {
    hasAlpha = YES;
  }
  CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
  bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(NULL, newSize.width, newSize.height, 8, 0, colorSpace, bitmapInfo);
  CGContextDrawImage(context, CGRectMake(0, 0, newSize.width, newSize.height), imageRef);
  CGImageRef resultImageRef = CGBitmapContextCreateImage(context);
  result = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:image.imageOrientation];
  CGContextRelease(context);
  CGColorSpaceRelease(colorSpace);
  CGImageRelease(resultImageRef);
  return result;
}

+ (UIImage *)uniformlyScaleImage:(UIImage *)image toSize:(CGSize)size {
  if (image && !CGSizeEqualToSize(CGSizeZero, image.size)) {
    if (CGSizeEqualToSize(image.size, size)) {
      return image;
    }
    CGFloat widthScale = size.width / image.size.width;
    CGFloat heightScale = size.height / image.size.height;
    CGFloat scale = MAX(widthScale, heightScale);
    CGFloat scaledWidth = image.size.width * scale;
    CGFloat scaledHeight = image.size.height * scale;
    CGFloat xOrigin = -(scaledWidth - size.width) / 2;
    CGFloat yOrigin = -(scaledHeight - size.height) / 2;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:CGRectMake(xOrigin, yOrigin, scaledWidth, scaledHeight)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
  } else {
    return nil;
  }
}

+ (UIImage*)imageWithShadowForImage:(UIImage *)initialImage {
  CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef shadowContext = CGBitmapContextCreate(NULL,
                                                     initialImage.size.width,
                                                     initialImage.size.height + 5,
                                                     CGImageGetBitsPerComponent(initialImage.CGImage),
                                                     0,
                                                     colourSpace,
                                                     (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
  CGColorSpaceRelease(colourSpace);
  CGContextSetShadowWithColor(shadowContext, CGSizeMake(0,0), 5, [UIColor blackColor].CGColor);
  CGContextDrawImage(shadowContext,
                     CGRectMake(0, 5, initialImage.size.width, initialImage.size.height),
                     initialImage.CGImage);
  CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
  CGContextRelease(shadowContext);
  UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
  CGImageRelease(shadowedCGImage);
  return shadowedImage;
}

+ (UIImage *)roundImageWithOriginImage:(UIImage *)image withDiameter:(CGFloat)diameter {
  CGSize imageSize = CGSizeMake(diameter, diameter);
  CGRect imageRect = CGRectMake(0, 0, diameter, diameter);
  
  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextAddEllipseInRect(context, imageRect);
  CGContextClip(context);
  
  [image drawInRect:imageRect];
  UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resultImage;
}

+ (UIImage *)templateImageWithImage:(UIImage *)oriImage {
  return [oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)maskImage:(UIImage *)image withColor:(UIColor *)maskColor {
  CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, 0, rect.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
  CGContextClipToMask(context, rect, image.CGImage);
  CGContextSetFillColorWithColor(context, maskColor.CGColor);
  CGContextFillRect(context, rect);
  UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return smallImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
  if (FLOAT_EQUAL(size.width, 0.) || FLOAT_EQUAL(size.height, 0.)) {
    return nil;
  }
  UIGraphicsBeginImageContextWithOptions(size, NO, 0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)roundedRectImageWithColor:(UIColor *)color
                          cornerRadius:(CGFloat)radius
                                  size:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 0);
  [color set];
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width,
                                                                          size.height)
                                                  cornerRadius:radius];
  [path fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)resizableHollowRoundedRectImageWithColor:(UIColor *)color
                                         cornerRadius:(CGFloat)radius {
  CGSize size = CGSizeMake(radius * 2 + 1, radius * 2 + 1);
  UIImage *image = qtt_beginImage(size).cornerRadius(radius).borderColor(color).make;
  return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
}

+ (UIImage *)resizableHollowRoundedRectImageWithColor:(UIColor *)color
                                            fillColor:(UIColor *)fillColor
                                         cornerRadius:(CGFloat)radius {
  CGSize size = CGSizeMake(radius * 2 + 1, radius * 2 + 1);
  UIImage *image = qtt_beginImage(size).cornerRadius(radius).borderColor(color).fillColor(fillColor).make;
  return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
}

+ (void)calculateBrightnessOfImage:(UIImage *)image completionHandler:(void (^)(double brightness))completionHandler {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *)calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel
    // format.
    
    double totalBrightness = 0;
    NSInteger byteCount = height * width * 4;
    for (NSInteger byteIndex = 0; byteIndex < byteCount; byteIndex += 4) {
      CGFloat red = (rawData[byteIndex] * 1.0) / 255.0;
      CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
      CGFloat blue = (rawData[byteIndex + 2] * 1.0) / 255.0;
      
      // Y = 0.299*R + 0.587*G + 0.144*B
      // HSV 模式与 RGB 模式值换算
      
      double pixelBrightness = 0.299 * red + 0.587 * green + 0.144 * blue;
      totalBrightness += pixelBrightness;
    }
    
    free(rawData);
    
    double averageBrightness = 0;
    if (width > 0 && height > 0) {
      averageBrightness = totalBrightness / (height * width) * 255.f;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(averageBrightness);
    });
  });
}

@end
