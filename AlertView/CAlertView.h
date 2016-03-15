//
//  CAlertView.h
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAlertAction.h"

#import "UIView+CAlertAction.h"

@interface CAlertView : UIView

@property (nonatomic, copy) NSString *alertTitle;

@property (nonatomic, copy) NSString *alertDescription;

- (instancetype)init;

- (void)showInView:(UIView *)view;

- (void)addAlertAction:(CAlertAction *)action;

- (void)addAlertActions:(NSArray<CAlertAction *> *)actions;

- (void)addAlertContentView:(UIView *)contentView;

@end
