//
//  CAlertView.m
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import "CAlertView.h"

#define CColor_333333 [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f]
#define CColor_c60000 [UIColor colorWithRed:198/255.f green:0 blue:0 alpha:1.f]
#define CColor_cccccc [UIColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1.f]

@interface CAlertView ()

@property (nonatomic, assign) CGRect contentRect;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray<CAlertAction *> *actionArr;
@property (nonatomic, strong) NSMutableArray<UIButton *> *actionButtonArr;

@end

@implementation CAlertView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.contentRect = CGRectMake(30, CGRectGetHeight([UIScreen mainScreen].bounds)/2.f - 5, CGRectGetWidth([UIScreen mainScreen].bounds) - 30 * 2, 10);
        
        self.contentView = [[UIView alloc] initWithFrame:self.contentRect];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 4.f;
        
        self.actionArr = [NSMutableArray array];
        self.actionButtonArr = [NSMutableArray array];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
        [self addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Public Method

- (void)showInView:(UIView *)view {
    if (![view.subviews containsObject:self]) {
         self.alpha = 0.f;
         self.transform = CGAffineTransformMakeScale(1.2, 1.2);
         
         [view addSubview:self];
         
         [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 1.f;
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}

- (void)addAlertAction:(CAlertAction *)action {
    [self addActionLine];
    [self addAction:action];
}

- (void)addAlertActions:(NSArray<CAlertAction *> *)actions {
    [self addActionLine];
    
    for (CAlertAction *action in actions) {
        [self addAction:action];
    }
}

- (void)addTextFieldWithPlaceholder:(NSString *)placeholder text:(NSString *)text {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    _alertTextField = [[UITextField alloc] init];
    _alertTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _alertTextField.borderStyle = UITextBorderStyleRoundedRect;
    _alertTextField.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
    _alertTextField.font = [UIFont systemFontOfSize:16];
    
    [contentView addSubview:_alertTextField];
    
    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:_alertTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:_alertTextField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:_alertTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:10.f];
    NSLayoutConstraint *trailingCons = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_alertTextField attribute:NSLayoutAttributeTrailing multiplier:1.f constant:10.f];
    
    [contentView addConstraints:@[topCons, bottomCons, leadingCons, trailingCons]];
    
    [self addAlertContentView:contentView];
    
    _alertTextField.placeholder = placeholder;
    _alertTextField.text = text;
}

- (void)addTextViewWithPlaceholder:(NSString *)placeholder text:(NSString *)text {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    
    _alertTextView = [[CTextView alloc] init];
    _alertTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _alertTextView.font = [UIFont systemFontOfSize:14];
    _alertTextView.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
    
    _alertTextView.layer.borderColor = [UIColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1.f].CGColor;
    _alertTextView.layer.borderWidth = 0.5;
    _alertTextView.layer.cornerRadius = 4.f;
    
    [contentView addSubview:_alertTextView];
    
    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:_alertTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:_alertTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:_alertTextView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:10.f];
    NSLayoutConstraint *trailingCons = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_alertTextView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:10.f];
    
    [contentView addConstraints:@[topCons, bottomCons, leadingCons, trailingCons]];
    
    [self addAlertContentView:contentView];
    
    _alertTextView.placeholder = placeholder;
    _alertTextView.text = text;
}

- (void)addAlertContentView:(UIView *)contentView {
    CGRect tmpRect = contentView.frame;
    
    tmpRect.origin.x = 0.f;
    
    CGFloat originY = 20;
    CGFloat heightOffset = 20.f;
    if (self.titleLabel != nil) {
        originY += self.titleLabel.frame.origin.y + CGRectGetHeight(self.titleLabel.frame);
    }
    
    if (self.descLabel != nil) {
        originY += CGRectGetHeight(self.descLabel.frame);
        heightOffset = 0.f;
    }
    
    tmpRect.origin.y = originY;
    
    tmpRect.size.width = CGRectGetWidth(self.contentRect);
    contentView.frame = tmpRect;
    
    [contentView layoutIfNeeded];
    
    [self plusContentRectHeight:heightOffset + CGRectGetHeight(contentView.frame)];
    
    [self.contentView addSubview:contentView];
    
    [self resetPosition];
}

#pragma mark - Private Method

- (void)tapOnView:(UITapGestureRecognizer *)tap {
    [self endEditing:YES];
}

- (void)hidden {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addActionLine {
    if (self.actionArr.count == 0) {
        [self plusContentRectHeight:CAlertActionHeight + 0.5];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentRect) - CAlertActionHeight - 0.5, CGRectGetWidth(self.contentRect), 0.5)];
        self.lineView.backgroundColor = CColor_cccccc;
        
        [self.contentView addSubview:self.lineView];
    }
}

- (void)addAction:(CAlertAction *)action {
    [self.actionArr addObject:action];
    
    //计算增加Action后每个Action的宽度
    CGFloat actionWidth = CGRectGetWidth(self.contentRect)/(CGFloat)self.actionArr.count;
    
    //重新调整之前增加Action的位置
    [self resetPosition];
    
    //增加Action
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake((self.actionArr.count - 1) * actionWidth, CGRectGetHeight(self.contentRect) - CAlertActionHeight, actionWidth, CAlertActionHeight);
    [actionButton setTitle:action.title forState:UIControlStateNormal];
    
    UIColor *color;
    
    switch (action.style) {
        case CAlertActionDone: {
            color = CColor_c60000;
        }
            break;
            
        default: {
            color = CColor_333333;
        }
            break;
    }
    
    [actionButton setTitleColor:color forState:UIControlStateNormal];
    actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [actionButton addTarget:self action:@selector(doButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果Action不只一个，则需要增加竖线
    if (self.actionArr.count > 1) {
        UIView *buttonLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, CAlertActionHeight)];
        buttonLine.backgroundColor = CColor_cccccc;
        
        [actionButton addSubview:buttonLine];
    }
    
    [self.contentView addSubview:actionButton];
    [self.actionButtonArr addObject:actionButton];
}

- (void)doButtonAction:(UIButton *)button {
    [self tapOnView:nil];
    
    NSInteger index = [self.actionButtonArr indexOfObject:button];
    CAlertAction *action = self.actionArr[index];
    
    if (action.enabled) {
        action.handler(action);
        [self hidden];
    }
}

- (void)resetPosition {
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.contentRect) - CAlertActionHeight - 0.5, CGRectGetWidth(self.contentRect), 0.5);
    
    CGFloat actionWidth = CGRectGetWidth(self.contentRect)/(CGFloat)self.actionArr.count;
    
    int i = 0;
    for (UIView *subview in self.contentView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.frame = CGRectMake(i * actionWidth, CGRectGetHeight(self.contentRect) - CAlertActionHeight, actionWidth, CAlertActionHeight);
            
            i ++;
        }
    }
}

- (void)plusContentRectHeight:(CGFloat)height {
    CGRect tmpRect = self.contentRect;
    
    tmpRect.size.height += height;
    tmpRect.origin.y = (CGRectGetHeight([UIScreen mainScreen].bounds) - tmpRect.size.height)/2.f;
    
    self.contentRect = tmpRect;
    self.contentView.frame = self.contentRect;
}

- (void)animationContentViewWithHeight:(CGFloat)height {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, height, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    }];
}

#pragma mark - Setting

- (void)setAlertTitle:(NSString *)alertTitle {
    _alertTitle = [alertTitle copy];
    
    self.titleLabel = [[UILabel alloc] init];
    
    self.titleLabel.textColor = CColor_333333;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:17 weight:1.2];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.titleLabel.text = self.alertTitle;
    
    CGFloat titleLabelWidth = CGRectGetWidth(self.contentRect) - 20;
    
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(titleLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size;
    self.titleLabel.frame = CGRectMake(10, 20, titleLabelWidth, titleSize.height);
    
    [self plusContentRectHeight:20 + CGRectGetHeight(self.titleLabel.frame)];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self resetPosition];
}

- (void)setAlertDescription:(NSString *)alertDescription {
    _alertDescription = [alertDescription copy];
    
    self.descLabel = [[UILabel alloc] init];
    
    self.descLabel.textColor = CColor_333333;
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.font = [UIFont systemFontOfSize:14];
    self.descLabel.numberOfLines = 0;
    self.descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.descLabel.text = self.alertDescription;
    
    CGFloat descLabelWidth = CGRectGetWidth(self.contentRect) - 20;
    
    CGSize descSize = [self.descLabel.text boundingRectWithSize:CGSizeMake(descLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.descLabel.font} context:nil].size;
    
    CGFloat originY = 20;
    if (self.titleLabel != nil) {
        originY = self.titleLabel.frame.origin.y + CGRectGetHeight(self.titleLabel.frame) + 10;
    }
    
    self.descLabel.frame = CGRectMake(10, originY, descLabelWidth, descSize.height);
    
    [self plusContentRectHeight:20 + CGRectGetHeight(self.descLabel.frame)];
    
    [self.contentView addSubview:self.descLabel];
    
    [self resetPosition];
}

#pragma mark - Notification

- (void)keyboardWillChange:(NSNotification *)notification {
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGFloat newHeight = (CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardSize.height - CGRectGetHeight(self.contentView.frame))/2.f;
    [self animationContentViewWithHeight:newHeight];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat newHeight = (CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.contentView.frame))/2.f;
    [self animationContentViewWithHeight:newHeight];
}

@end
