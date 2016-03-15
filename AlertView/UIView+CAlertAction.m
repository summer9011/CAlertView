//
//  UIView+CAlertAction.m
//  AlertView
//
//  Created by 赵立波 on 16/3/15.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import "UIView+CAlertAction.h"
#import <objc/runtime.h>

static const void *tagKey = &tagKey;

@interface UIView ()

@property (nonatomic, strong) ViewActionBlock handler;

@end

@implementation UIView (CAlertAction)

- (void)addViewAction:(ViewActionBlock)actionHandler {
    self.handler = actionHandler;
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    } else if ([self isKindOfClass:[UITextField class]]) {
        
    } else if ([self isKindOfClass:[UITextView class]]) {
        
    } else {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
        [self addGestureRecognizer:tap];
    }
}

#pragma mark - Action

- (void)tapOnView:(UITapGestureRecognizer *)tap {
    self.handler(tap.view);
}

- (void)buttonTouchUpInside:(UIButton *)button {
    self.handler(button);
}

#pragma mark - Getting, Setting

- (ViewActionBlock)handler {
    return objc_getAssociatedObject(self, tagKey);
}

- (void)setHandler:(ViewActionBlock)handler {
    objc_setAssociatedObject(self, tagKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
