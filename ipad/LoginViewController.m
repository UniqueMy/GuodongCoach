//
//  LoginViewController.m
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "LoginViewController.h"
#import "amendViewController.h"
#import "ViewController.h"
#import "APService.h"
#import "AppDelegate.h"
@implementation LoginViewController
{
    UITextField *ZtextField;
    UITextField *MtextField;
    NSString *path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:27.00/255 green:27.00/255 blue:27.00/255 alpha:1];
    UIView *daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.text=@"登录";
    titlelabel.font=[UIFont fontWithName:FONT size:36];
    titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self createView];
    
}

-(void)createView
{
 
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/d.plist"];
   
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   
    UILabel *zanghaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 150, 150, 100)];
    zanghaoLabel.text = @"账号：";
    zanghaoLabel.textColor = [UIColor whiteColor];
    zanghaoLabel.font = [UIFont fontWithName:FONT size:36];
    [self.view addSubview:zanghaoLabel];
    
    UILabel *mimaLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 300, 150, 100)];
    mimaLabel.text = @"密码：";
    mimaLabel.textColor = [UIColor whiteColor];
    mimaLabel.font = [UIFont fontWithName:FONT size:36];
    [self.view addSubview:mimaLabel];
    
   
    ZtextField = [[UITextField alloc] initWithFrame:CGRectMake(350, 160, 450, 80)];
    ZtextField.borderStyle =UITextBorderStyleRoundedRect;
    ZtextField.placeholder = @"请输入您的账号";
    ZtextField.text = [dict objectForKey:@"zhanghao"];
    ZtextField.keyboardType=UIKeyboardTypeNumberPad;
    ZtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    ZtextField.font = [UIFont fontWithName:FONT size:30];
    [ZtextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ZtextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:ZtextField];
    
    MtextField = [[UITextField alloc] initWithFrame:CGRectMake(350, 310, 450, 80)];
    MtextField.borderStyle =UITextBorderStyleRoundedRect;
    MtextField.placeholder = @"请输入您的密码";
    MtextField.delegate = self;
    MtextField.text = [dict objectForKey:@"mima"];
     MtextField.secureTextEntry = YES;
    MtextField.keyboardType=UIKeyboardTypeDefault;
    MtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    MtextField.font = [UIFont fontWithName:FONT size:30];
    [MtextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [MtextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:MtextField];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(620, 500, 180, 70);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"denglured"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(gotomain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *xiugaiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    xiugaiButton.frame = CGRectMake(250, 500, 180, 70);
    [xiugaiButton setBackgroundImage:[UIImage imageNamed:@"amend"] forState:UIControlStateNormal];
    [xiugaiButton addTarget:self action:@selector(gotoxiugai:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiugaiButton];
    
}

-(void)gotomain:(UIButton *)button
{
    NSString *url = [NSString stringWithFormat:@"%@gdlogin/?number=%@&passwd=%@",BASEURL,ZtextField.text,[MtextField.text MD5]];
    NSDictionary *dict = @{@"registerID":[APService registrationID]};
    NSLog(@"注册ID    %@",[APService registrationID]);
    
    [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"responseObject  %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue]==0) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            
            [dict setObject:ZtextField.text forKey:@"zhanghao"];
            [dict setObject:MtextField.text forKey:@"mima"];
            // NSHomeDirectory() 沙盒根目录的路径
            path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/d.plist"];
            [dict writeToFile:path atomically:YES];
            NSLog(@"dict  %@",[dict objectForKey:@"zhanghao"]);
            [self.navigationController pushViewController:[ViewController new] animated:YES];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    } fail:^(NSError *error) {
        NSLog(@"error   %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }];
}
-(void)gotoxiugai:(UIButton *)button
{
    [self.navigationController pushViewController:[amendViewController new] animated:YES];
}
-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    NSLog(@"frame.origin.y  %f",frame.origin.y);
    NSLog(@"self.view.height  %f",self.view.frame.size.height);
    
    //552  frame.origin.y + 32 - (self.view.frame.size.height - 216.0)
    int offset = 352-textField.frame.origin.y-textField.frame.size.height;//键盘高度216
    NSLog(@"offset   %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //100, 500, 820,150
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    
    if(offset < 0)
        self.view.frame = CGRectMake(0.0f, offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


@end
