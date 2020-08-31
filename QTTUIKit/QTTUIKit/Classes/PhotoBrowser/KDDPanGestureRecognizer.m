//
//  KDDPanGestureRecognizer.m
//  QTTUIKit
//
//  Created by lyj on 2019/8/13.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPanGestureRecognizer.h"

int const static kDirectionPanThreshold = 5;

@interface KDDPanGestureRecognizer()

@property (nonatomic, assign) BOOL isDrag;
@property (nonatomic, assign) int moveX;
@property (nonatomic, assign) int moveY;

@end

@implementation KDDPanGestureRecognizer

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  if (self.state == UIGestureRecognizerStateFailed) return;
  CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
  CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
  _moveX += prevPoint.x - nowPoint.x;
  _moveY += prevPoint.y - nowPoint.y;
  if (!self.isDrag) {
    if (abs(_moveX) > kDirectionPanThreshold) {
      if (_direction == KDDPanGestureRecognizerDirectionVertical) {
        self.state = UIGestureRecognizerStateFailed;
      } else {
        _isDrag = YES;
      }
    } else if (abs(_moveY) > kDirectionPanThreshold) {
      if (_direction == KDDPanGestureRecognizerDirectionHorizontal) {
        self.state = UIGestureRecognizerStateFailed;
      } else {
        _isDrag = YES;
      }
    }
  }
}

- (void)reset {
  [super reset];
  _isDrag = NO;
  _moveX = 0;
  _moveY = 0;
}

@end
