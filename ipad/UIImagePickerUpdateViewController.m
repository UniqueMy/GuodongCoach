//
//  UIImagePickerUpdateViewController.m
//  Test1
//
//  Created by zheng ping on 15/12/24.
//  Copyright © 2015年 zheng ping. All rights reserved.
//

#import "UIImagePickerUpdateViewController.h"

@interface UIImagePickerUpdateViewController ()<UIImagePickerControllerDelegate>

@end

@implementation UIImagePickerUpdateViewController

-(UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL) shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientationMask) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
