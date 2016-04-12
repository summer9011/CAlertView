//
//  CTextView.m
//  AlertView
//
//  Created by 赵立波 on 16/4/11.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import "CTextView.h"

@interface CTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation CTextView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - Setting

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.placeholderLabel.numberOfLines = 1;
    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.f];
    
    [self addSubview:self.placeholderLabel];
    
    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:self.placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:8.f];
    NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:self.placeholderLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.f constant:5.f];
    NSLayoutConstraint *trailingCons = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.placeholderLabel attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
    
    [self addConstraints:@[topCons, leadingCons, trailingCons]];
    
    self.placeholderLabel.text = placeholder;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
    }
}

#pragma mark - Notification

- (void)textViewTextDidChange:(NSNotification *)notification {
    CTextView *textView = notification.object;
    
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

@end
