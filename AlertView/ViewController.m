//
//  ViewController.m
//  AlertView
//
//  Created by 赵立波 on 16/3/14.
//  Copyright © 2016年 赵立波. All rights reserved.
//

#import "ViewController.h"
#import "CAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAlert:(id)sender {
    //alloc一个AlertView
    CAlertView *alertView = [[CAlertView alloc] init];
    
    //设置标题和描述
    alertView.alertTitle = @"测试测试测试";
    alertView.alertDescription = @"描述描述描述描述";
    
    //设置Action
    CAlertAction *cancelAction = [CAlertAction actionWithTitle:@"取消" style:CAlertActionNormal handler:^(CAlertAction *alertAction) {
        NSLog(@"取消");
    }];
    
    CAlertAction *doneAction = [CAlertAction actionWithTitle:@"完成" style:CAlertActionDone handler:^(CAlertAction *alertAction) {
        NSLog(@"alertTextField结果 %@", alertView.alertTextField.text);
        NSLog(@"alertTextView结果 %@", alertView.alertTextView.text);
    }];
    
    [alertView addAlertActions:@[cancelAction, doneAction]];
    
    //设置文本TextField
    [alertView addTextFieldWithPlaceholder:@"这里是placeholder" text:@"222"];
    
    //设置文本TextView
//    [alertView addTextViewWithPlaceholder:@"这里是输入文本框" text:@"111"];
    
    /*
    //设置自定义的视图
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil];
    UIView *customView = nibViews[0];
    
    UIButton *button = customView.subviews[0];
    UITextField *textFiled = customView.subviews[1];
    UIView *view = customView.subviews[2];
    
    [button addViewAction:^(UIView *view) {
        NSLog(@"按钮");
    }];
    
    [view addViewAction:^(UIView *view) {
        NSLog(@"自定义的View");
    }];
    
    [alertView addAlertContentView:customView];
     */
    
    //显示视图
    [alertView showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
