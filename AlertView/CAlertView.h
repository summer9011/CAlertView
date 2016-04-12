//
//  CAlertView.h
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAlertAction.h"
#import "CTextView.h"

#import "UIView+CAlertAction.h"

@interface CAlertView : UIView

/**
 *  弹出框标题
 */
@property (nonatomic, copy) NSString *alertTitle;

/**
 *  弹出框描述
 */
@property (nonatomic, copy) NSString *alertDescription;

/**
 *  输入框
 */
@property (nonatomic, strong, readonly) UITextField *alertTextField;

/**
 *  输入文本框
 */
@property (nonatomic, strong, readonly) CTextView *alertTextView;

- (instancetype)init;

/**
 *  显示AlertView
 *
 *  @param view 父级的View
 */
- (void)showInView:(UIView *)view;

/**
 *  添加按钮Action
 *
 *  @param action 按钮Action
 */
- (void)addAlertAction:(CAlertAction *)action;

/**
 *  添加按钮Action
 *
 *  @param actions 按钮Action数组
 */
- (void)addAlertActions:(NSArray<CAlertAction *> *)actions;

/**
 *  添加输入框
 *
 *  @param placeholder placeholder文字
 *  @param text  内容文字
 */
- (void)addTextFieldWithPlaceholder:(NSString *)placeholder text:(NSString *)text;

/**
 *  添加输入文本框
 *
 *  @param placeholder placeholder文字
 *  @param text  内容文字
 */
- (void)addTextViewWithPlaceholder:(NSString *)placeholder text:(NSString *)text;

/**
 *  添加自定义视图
 *
 *  @param contentView 自定义视图
 */
- (void)addAlertContentView:(UIView *)contentView;

@end
