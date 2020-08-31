//
//  KDDTimerButton.m
//  QTTUIKit
//
//  Created by XIN on 2019/11/3.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDTimerButton.h"
#import <QTTFoundation/QTTFoundation.h>

@interface KDDTimerButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countDownNumber;
@property (nonatomic, copy) void (^timerCallBack)(void);
@property (nonatomic, assign) BOOL isInTiming;

@property (nonatomic, assign) NSUInteger innerCountDown;

@end

@implementation KDDTimerButton

- (instancetype)initWithCountDownTime:(NSUInteger)countDown {
  self = [super init];
  if (self) {
    _innerCountDown = countDown;
    _countDownNumber = countDown;
    self.title = @"重新获取";
    self.disableTitle = @"已发送";
  }
  return self;
}

- (void)setUpTimer {
  if (self.timer == nil) {
    self.timer = [NSTimer qtt_ScheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpdate) userInfo:nil repeat:YES];
  }
}

- (void)setTimerCallBackBlock:(void (^)(void))timerCallBack {
  _timerCallBack = [timerCallBack copy];
}

- (void)startTimer {
  if (self.timer == nil) {
    [self setUpTimer];
  }
  self.countDownNumber = self.innerCountDown;
  [self.timer fire];
  self.isInTiming = YES;
}

- (void)stopTimer {
  [self.timer invalidate];
}

- (BOOL)isInTiming {
  return [self.timer isValid];
}

#pragma mark - NSTimer call back

- (void)timeUpdate {
  if (self.countDownNumber > 0) {
    self.enabled = NO;
    NSString *title = self.disableTitle;
    NSString *text = [NSString stringWithFormat:@"%@(%lis)", title, (long)(self.countDownNumber)];
    [self setTitle:text forState:UIControlStateDisabled];
  } else {
    self.isInTiming = NO;
    [self.timer invalidate];
    self.timer = nil;
    self.enabled = YES;
    NSString *text = self.title;
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitle:text forState:UIControlStateDisabled];
  }
  self.countDownNumber--;
  if (self.timerCallBack) {
    self.timerCallBack();
  }
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
