//
//  CourseViewController.m
//  SUES
//
//  Created by lixu on 16/9/7.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "CourseViewController.h"
#import <React/RCTRootView.h>


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
    [button setTitle:@"reactNative" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reactNative:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) reactNative:(id) sender
{
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"RNApp"
                         initialProperties :
     @{
       @"scores" : @[
               @{
                   @"name" : @"Alex",
                   @"value": @"42"
                   },
               @{
                   @"name" : @"Joel",
                   @"value": @"10"
                   }
               ]
       }
                          launchOptions    : nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
