//
//  UITextView+KDDInputView.m
//  KDDSquareModule
//
//  Created by lyj on 2019/9/6.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "UITextView+KDDInputView.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic,strong) UITextView *placeHolderTextView;
@property (nonatomic,assign) CGFloat originalHeight;

@end

@implementation UITextView (KDDInputView)

+ (void)load {
  [super load];
  method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),class_getInstanceMethod(self.class,@selector(exchanged_dealloc)));
}

- (void)exchanged_dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  UITextView *textView = objc_getAssociatedObject(self, @selector(placeHolderTextView));
  if (textView) {
    for (NSString *key in self.class.observedKeys) {
      @try {
        [self removeObserver:self forKeyPath:key];
      }
      @catch (NSException *exception) {
        
      }
    }
  }
  [self exchanged_dealloc];
}

+ (NSArray *)observedKeys {
  return @[@"attributedText",@"bounds",@"font",@"frame",@"text",@"textAlignment",@"textContainerInset",@"textContainer.exclusionPaths"];
}

- (CGFloat)originalHeight {
  static CGFloat originalHeight;
  static dispatch_once_t onceToken;
  if (self.bounds.size.height > 0) {
    dispatch_once(&onceToken, ^{
      [self.superview layoutIfNeeded];
      originalHeight = self.bounds.size.height;
    });
  }
  
  return originalHeight;
}

- (NSString *)kdd_placeholder {
  return objc_getAssociatedObject(self, @selector(kdd_placeholder));
}

- (void)setKdd_placeholder:(NSString *)kdd_placeholder {
  objc_setAssociatedObject(self, @selector(kdd_placeholder), kdd_placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
  [self placeHolderTextView];
  [self textViewValueChanged];
}

- (id<KDDInputViewDelegate>)kdd_delegate {
  return objc_getAssociatedObject(self, @selector(kdd_delegate));
}

- (void)setKdd_delegate:(id<KDDInputViewDelegate>)kdd_delegate {
  objc_setAssociatedObject(self, @selector(kdd_delegate), kdd_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)kdd_placeholderColor {
  return objc_getAssociatedObject(self, @selector(kdd_placeholderColor));
}

- (void)setKdd_placeholderColor:(UIColor *)kdd_placeholderColor {
  objc_setAssociatedObject(self, @selector(kdd_placeholderColor), kdd_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self textViewValueChanged];
}

- (UIFont *)kdd_placeholderFont {
  return objc_getAssociatedObject(self, @selector(kdd_placeholderFont));
}

- (void)setKdd_placeholderFont:(UIFont *)kdd_placeholderFont {
  objc_setAssociatedObject(self, @selector(kdd_placeholderFont), kdd_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self textViewValueChanged];
}

- (NSUInteger)kdd_maxNumberOfLines {
  return [objc_getAssociatedObject(self, @selector(kdd_maxNumberOfLines)) integerValue];
}

- (void)setKdd_maxNumberOfLines:(NSUInteger)kdd_maxNumberOfLines {
  objc_setAssociatedObject(self, @selector(kdd_maxNumberOfLines), @(kdd_maxNumberOfLines), OBJC_ASSOCIATION_ASSIGN);
  [self textViewValueChanged];
}

- (BOOL)kdd_autoLineBreak {
  return [objc_getAssociatedObject(self, @selector(kdd_autoLineBreak)) boolValue];
}

- (void)setKdd_autoLineBreak:(BOOL)kdd_autoLineBreak {
  objc_setAssociatedObject(self, @selector(kdd_autoLineBreak), @(kdd_autoLineBreak), OBJC_ASSOCIATION_ASSIGN);
  [self textViewValueChanged];
}

- (UITextView *)placeHolderTextView {
  UITextView *placeHolderTextView = objc_getAssociatedObject(self, @selector(placeHolderTextView));
  if (!placeHolderTextView) {
    self.text = @"";
    placeHolderTextView = [UITextView new];
    placeHolderTextView.userInteractionEnabled = NO;
    placeHolderTextView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    objc_setAssociatedObject(self, @selector(placeHolderTextView), placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self insertSubview:placeHolderTextView atIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewValueChanged) name:UITextViewTextDidChangeNotification object:self];
    
    for (NSString *key in self.class.observedKeys) {
      [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    }
    [self textViewValueChanged];
  }
  
  return placeHolderTextView;
}

- (void)updateHeight {
  self.placeHolderTextView.hidden = self.text.length;
  
  CGFloat maxHeight =  ceil(self.font.lineHeight * self.kdd_maxNumberOfLines +  self.textContainerInset.top + self.textContainerInset.bottom);
  NSInteger height = self.text.length > 0 ? ceil([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height) : self.originalHeight;
  
  self.scrollEnabled = !self.kdd_autoLineBreak;
  
  if (self.kdd_autoLineBreak && !self.kdd_maxNumberOfLines && height > self.originalHeight) {
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
  }
  
  self.scrollEnabled = height > maxHeight && self.kdd_maxNumberOfLines;
  if (maxHeight >= height && height >= self.originalHeight) {
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
  }
  
  if ([self.kdd_delegate respondsToSelector:@selector(kdd_inputViewDidChangeHeight:)]) {
    [self.kdd_delegate kdd_inputViewDidChangeHeight:self.frame.size.height];
  }
}

- (void)textViewValueChanged {
  self.placeHolderTextView.hidden = self.text.length;
  
  if(!self.text.length) {
    self.placeHolderTextView.text= self.kdd_placeholder;
    self.placeHolderTextView.textColor = self.kdd_placeholderColor ?: [UIColor lightGrayColor];
    self.placeHolderTextView.font = self.kdd_placeholderFont?:self.font;
    
    self.placeHolderTextView.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
    
    self.placeHolderTextView.textAlignment = self.textAlignment;
    self.placeHolderTextView.frame = CGRectMake(self.textContainerInset.left, 0, self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right, self.bounds.size.height);
    
  }
  [self updateHeight];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  if (object != self.placeHolderTextView && [keyPath isEqualToString:@"text"]) {
    [self updateHeight];
  }
}

@end
