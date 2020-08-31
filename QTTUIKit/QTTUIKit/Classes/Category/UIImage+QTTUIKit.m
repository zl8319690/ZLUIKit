//
//  UIImage+QTTUIKit.m
//  Tiny
//
//  Created by XIN on 2019/8/1.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UIImage+QTTUIKit.h"

@implementation UIImage (QTTUIKit)

+ (UIImage *)qtt_imageNamedInQTTUIKit:(NSString *)imageName {
  static NSBundle *resourceBundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSBundle *shoppingLibBundle = [NSBundle bundleForClass:NSClassFromString(@"QTTViewController")];
    NSString *bundlePath = [[shoppingLibBundle bundlePath] stringByAppendingPathComponent:@"QTTUIKit.bundle"];
    resourceBundle = [NSBundle bundleWithPath:bundlePath];
  });
  UIImage *image = [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
  NSAssert(image, @"FBI Warning:missing image!!!");
  return image;
}

+ (UIImage *)qtt_backButtonDarkImage {
  return [[UIImage qtt_imageNamedInQTTUIKit:@"icon_navigation_back_dark"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)qtt_backButtonLightImage {
  return [[UIImage qtt_imageNamedInQTTUIKit:@"icon_navigation_back_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)qtt_closeButtonDarkImage {
  return [[UIImage qtt_imageNamedInQTTUIKit:@"icon_shut"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (NSArray<UIImage *> *)qtt_refreshAnimationImages {
  static NSArray *images = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSMutableArray *tempImages = [NSMutableArray array];
    for (int i=0; i<=89; i++) {
      NSString *imageName = [NSString stringWithFormat:@"refresh_%i",i];
      UIImage *image = [UIImage qtt_imageNamedInQTTUIKit:imageName];
      [tempImages addObject:image];
    }
    images = [tempImages copy];
  });
  
  return images;
}

+ (NSArray<UIImage *> *)qtt_voicePlayAnimationImages {
  static NSArray *images = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSMutableArray *tempImages = [NSMutableArray array];
    for (int i=0; i<=34; i++) {
      NSString *imageName = [NSString stringWithFormat:@"voice_play_%i",i];
      UIImage *image = [UIImage qtt_imageNamedInQTTUIKit:imageName];
      [tempImages addObject:image];
    }
    images = [tempImages copy];
  });
  
  return images;
}

+ (NSString *)qtt_splashImageNameForOrientation:(UIInterfaceOrientation)orientation {
  CGSize viewSize = [UIScreen mainScreen].bounds.size;
  NSString *viewOrientation = @"Portrait";
  
  if (UIInterfaceOrientationIsLandscape(orientation)) {
    viewSize = CGSizeMake(viewSize.height, viewSize.width);
    viewOrientation = @"Landscape";
  }
  
  NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
  
  for (NSDictionary *dict in imagesDict) {
    CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
    if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
      return dict[@"UILaunchImageName"];
  }
  return nil;
}

+ (UIImage *)qtt_splashImageForOrientation:(UIInterfaceOrientation)orientation {
  NSString *imageName = [self qtt_splashImageNameForOrientation:orientation];
  UIImage *image = [UIImage imageNamed:imageName];
  return image;
}

+ (UIImage *)qtt_splashImage {
  return [UIImage imageNamed:@"splash_image"];
}

@end
