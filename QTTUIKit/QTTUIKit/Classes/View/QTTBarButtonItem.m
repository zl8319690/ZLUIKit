//
//  QTTBarButtonItem.m
//  Tiny
//
//  Created by XIN on 2019/8/2.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTBarButtonItem.h"

@implementation QTTBarButtonItem

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem {
  return [self initWithBarButtonSystemItem:systemItem handler:nil];
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(QTTBarButtonItemAction)action {
  self = [super initWithBarButtonSystemItem:systemItem target:self action:@selector(handleAction:)];
  if (self) {
    self.blockAction = action;
  }
  return self;
}

- (id)initWithTitle:(NSString *)title {
  return [self initWithTitle:title handler:nil];
}

- (id)initWithTitle:(NSString *)title handler:(QTTBarButtonItemAction)action {
  self = [super initWithTitle:title
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(handleAction:)];
  if (self) {
    self.blockAction = action;
  }
  return self;
}

- (id)initWithImage:(UIImage *)image {
  return [self initWithImage:image handler:nil];
}

- (instancetype)initWithImage:(UIImage *)image
                      handler:(nullable QTTBarButtonItemAction)action {
  self = [super initWithImage:image
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(handleAction:)];
  if (self) {
    self.blockAction = action;
  }
  return self;
}

- (void)handleAction:(id)sender {
  if (self.blockAction) {
    self.blockAction();
  }
}

@end
