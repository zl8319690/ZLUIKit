//
//  KDDGradientButton.m
//  QTTUIKit
//
//  Created by XIN on 2019/10/30.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDGradientButton.h"

@interface KDDGradientButton ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation KDDGradientButton

- (void)layoutSubviews {
  [super layoutSubviews];
  self.gradientLayer.frame = self.bounds;
}

+ (KDDGradientButton *)drawGradientWithColors:(NSArray<UIColor *> *)colors {
  return [self drawGradientWithColors:colors
                           startPoint:CGPointMake(0, 0)
                             endPoint:CGPointMake(1, 0)
                            locations:@[@(0.f), @(1.f)]
                         cornerRadius:2.f];
}

+ (KDDGradientButton *)drawGradientWithColors:(NSArray<UIColor *> *)colors
                                   startPoint:(CGPoint)startPoint
                                     endPoint:(CGPoint)endPoint
                                    locations:(NSArray<NSNumber *> *)locations
                                 cornerRadius:(CGFloat)cornerRadius {
  CAGradientLayer *layer = [self gradientLayerWithColors:colors
                                              startPoint:startPoint
                                                endPoint:endPoint
                                               locations:locations];
  KDDGradientButton *button = [self buttonWithType:UIButtonTypeCustom];
  button.gradientLayer = layer;
  button.layer.masksToBounds = YES;
  button.layer.cornerRadius = cornerRadius;
  [button.layer insertSublayer:layer atIndex:0];
  [button bringSubviewToFront:button.imageView];
  return button;
}

+ (CAGradientLayer *)gradientLayerWithColors:(NSArray<UIColor *> *)colors
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint
                                   locations:(NSArray<NSNumber *> *)locations {
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  NSMutableArray *cgColors = [NSMutableArray array];
  [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [cgColors addObject:(__bridge id)obj.CGColor];
  }];
  gradientLayer.colors = cgColors;
  gradientLayer.locations = locations;
  gradientLayer.startPoint = startPoint;
  gradientLayer.endPoint = endPoint;
  
  return gradientLayer;
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    self.alpha = 0.5f;
  } else {
    self.alpha = 1.f;
  }
}

@end
