//
//  CourseViewController.m
//  SUES
//
//  Created by lixu on 16/9/7.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "CourseViewController.h"
#import "RCTRootView.h"
#import <DLModulesCenter/DLModulesCenter.h>


@interface CourseViewController ()

@end

@implementation CourseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(100, 300, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button setTitle:@"商城业务" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMall:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton new];
    button1.frame = CGRectMake(100, 300, 100, 30);
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
    [button1 setTitle:@"VIP业务" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showVIPCenter:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) showMall:(id) sender
{
    DLModuleParameter *params = [[DLModuleParameter alloc] init];
    
    //66代表商城组件,0代表首页
    params.originalParams = @{MODULE_MAIN_SERVICE_ID:@"RNMall",@"subID":@"main"};
    params.localParams = @{@"rootVC":self};
    
    [DLModulesManager openModuleWithParams:params];
    
    return;
}

- (void) showVIPCenter:(id) sender
{
    
}

@end
