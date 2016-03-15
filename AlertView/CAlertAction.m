//
//  CAlertAction.m
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import "CAlertAction.h"

@implementation CAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(CAlertActionStyle)style handler:(ActionBlock)handler {
    CAlertAction *alertAction = [[CAlertAction alloc] init];
    
    alertAction.title = title;
    alertAction.handler = handler;
    alertAction.style = style;
    
    alertAction.enabled = YES;
    
    return alertAction;
}

@end
