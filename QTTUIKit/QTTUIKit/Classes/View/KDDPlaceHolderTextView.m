//
//  KDDPlaceHolderTextView.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDPlaceHolderTextView.h"

@interface KDDPlaceHolderTextView ()

@property (nonatomic, retain) UILabel *placeHolderLabel;

@end

@implementation KDDPlaceHolderTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self){
    self.placeholder = @"";
    self.placeholderColor = UIColor.lightGrayColor;
    self.placeHolderInset = UIEdgeInsetsMake(8, 8, 8, 8);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
  }
  return self;
}

- (void)textChanged:(NSNotification *)notification {
  if(self.placeholder.length == 0) {
    return;
  }
  
  [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
    if(self.text.length == 0) {
      [[self viewWithTag:999] setAlpha:1];
    } else {
      [[self viewWithTag:999] setAlpha:0];
    }
  }];
}

- (void)setText:(NSString *)text {
  [super setText:text];
  [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
  if( self.placeholder.length > 0 ) {
    if (_placeHolderLabel == nil ) {
      _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.placeHolderInset.left, self.placeHolderInset.top, self.bounds.size.width - self.placeHolderInset.left - self.placeHolderInset.right, 0)];
      _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
      _placeHolderLabel.numberOfLines = 0;
      _placeHolderLabel.font = self.font;
      _placeHolderLabel.backgroundColor = [UIColor clearColor];
      _placeHolderLabel.textColor = self.placeholderColor;
      _placeHolderLabel.alpha = 0;
      _placeHolderLabel.tag = 999;
      [self addSubview:_placeHolderLabel];
    }
    
    _placeHolderLabel.text = self.placeholder;
    [_placeHolderLabel sizeToFit];
    [self sendSubviewToBack:_placeHolderLabel];
  }
  
  if( self.text.length == 0 && self.placeholder.length > 0 ) {
    [[self viewWithTag:999] setAlpha:1];
  }
  
  [super drawRect:rect];
}

@end
