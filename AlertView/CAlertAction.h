//
//  CAlertAction.h
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CAlertActionHeight 44

@class CAlertAction;

typedef void (^ActionBlock)(CAlertAction *alertAction);

typedef NS_ENUM(NSUInteger, CAlertActionStyle) {
    CAlertActionNormal,
    CAlertActionDone
};

@interface CAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(CAlertActionStyle)style handler:(ActionBlock)handler;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ActionBlock handler;
@property (nonatomic, assign) CAlertActionStyle style;

@property (nonatomic, assign) BOOL enabled;

@end
