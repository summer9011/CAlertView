//
//  UIView+CAlertAction.h
//  AlertView
//
//  Created by 赵立波 on 16/3/15.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ViewActionBlock)(UIView *view);

@interface UIView (CAlertAction)

- (void)addViewAction:(ViewActionBlock)actionHandler;

@end
