//
//  UIImage+QRCode.m
//  QTTUIKit
//
//  Created by lyj on 2019/9/12.
//  Copyright © 2019 Qutoutiao, Ltd. All rights reserved.
//

#import "UIImage+QRCode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (Category)

+ (UIImage *)qrImgForString:(NSString *)string size:(CGSize)size waterImg:(UIImage *)waterImg {
  CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
  [filter setDefaults];
  
  NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
  [filter setValue:data forKey:@"inputMessage"];
  [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
  CIImage *outPutImage = [filter outputImage];
  
  if (!waterImg) {
    return [[[self alloc] init] getHDImgWithCIImage:outPutImage size:size];
  } else {
    return [[[self alloc] init] getHDImgWithCIImage:outPutImage size:size waterImg:waterImg];;
  }
}

- (UIImage *)getHDImgWithCIImage:(CIImage *)img size:(CGSize)size {
  CGRect extent = CGRectIntegral(img.extent);
  CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));

  size_t width = CGRectGetWidth(extent) * scale;
  size_t height = CGRectGetHeight(extent) * scale;

  CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();

  CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
  CIContext *context = [CIContext contextWithOptions:nil];

  CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
  
  CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
  CGContextScaleCTM(bitmapRef, scale, scale);
  CGContextDrawImage(bitmapRef, extent, bitmapImage);
  
  CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
  CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);

  UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
  return outputImage;
}

- (UIImage *)sencond_getHDImgWithCIImage:(CIImage *)img size:(CGSize)size {
  UIColor *pointColor = [UIColor blackColor];
  UIColor *backgroundColor = [UIColor whiteColor];
  CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                     keysAndValues:
                           @"inputImage", img,
                           @"inputColor0", [CIColor colorWithCGColor:pointColor.CGColor],
                           @"inputColor1", [CIColor colorWithCGColor:backgroundColor.CGColor],
                           nil];
  
  CIImage *qrImage = colorFilter.outputImage;
  
  CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
  UIGraphicsBeginImageContext(size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetInterpolationQuality(context, kCGInterpolationNone);
  CGContextScaleCTM(context, 1.0, -1.0);
  CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
  UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  CGImageRelease(cgImage);
  
  return codeImage;
}

- (UIImage *)getHDImgWithCIImage:(CIImage *)img size:(CGSize)size waterImg:(UIImage *)waterImg {
  CGRect extent = CGRectIntegral(img.extent);
  CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));

  size_t width = CGRectGetWidth(extent) * scale;
  size_t height = CGRectGetHeight(extent) * scale;

  CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();

  CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
  CIContext *context = [CIContext contextWithOptions:nil];

  CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
  CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
  CGContextScaleCTM(bitmapRef, scale, scale);
  CGContextDrawImage(bitmapRef, extent, bitmapImage);

  CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
  CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);

  UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];

  UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
  [outputImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
  [waterImg drawInRect:CGRectMake((size.width-waterImg.size.width)/2.0, (size.height-waterImg.size.height)/2.0, waterImg.size.width, waterImg.size.height)];
  UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newPic;
}

+ (UIImage *)spliceImg1:(UIImage *)img1 img2:(UIImage *)img2 img2Location:(CGPoint)location {
  CGSize size2 = img2.size;
  
  UIGraphicsBeginImageContextWithOptions(img1.size, NO, [[UIScreen mainScreen] scale]);
  [img1 drawInRect:CGRectMake(0, 0, img1.size.width, img1.size.height)];

  [img2 drawInRect:CGRectMake(location.x, location.y, size2.width, size2.height)];
  UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newPic;
}

+ (UIImage *)changeColorWithQRCodeImg:(UIImage *)image red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    
  const int imageWidth = image.size.width;
  const int imageHeight = image.size.height;
  size_t bytesPerRow = imageWidth * 4;
  uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
  
  CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);

  int pixelNumber = imageHeight * imageWidth;
  [self changeColorOnPixel:rgbImageBuf pixelNum:pixelNumber red:red green:green blue:blue];
  
  CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, ProviderReleaseData);
  
  CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
  UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
  CGImageRelease(imageRef);
  CGColorSpaceRelease(colorSpace);
  CGContextRelease(context);
  return resultImage;
}

+ (void)changeColorOnPixel: (uint32_t *)rgbImageBuf pixelNum: (int)pixelNum red: (NSUInteger)red green: (NSUInteger)green blue: (NSUInteger)blue {
  uint32_t * pCurPtr = rgbImageBuf;
  for (int i = 0; i < pixelNum; i++, pCurPtr++) {
    if ((*pCurPtr & 0xffffff00) < 0xd0d0d000) {
      uint8_t * ptr = (uint8_t *)pCurPtr;
      ptr[3] = red;
      ptr[2] = green;
      ptr[1] = blue;
    } else {
      uint8_t * ptr = (uint8_t *)pCurPtr;
      ptr[0] = 0;
    }
  }
}

void ProviderReleaseData(void * info, const void * data, size_t size) {
  free((void *)data);
}

@end
