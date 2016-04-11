//
//  amendViewController.m
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "amendViewController.h"
#import "ViewController.h"
@implementation amendViewController

-(void)viewWillAppear:(BOOL)animated
{
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
    titlelabel.text=@"修改密码";
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
    NSArray *array = @[@"原密码：",@"新密码：",@"重复密码：",];
    NSArray *textArray = @[@"请输入您的原密码",@"请输入您的新密码",@"请重复您的密码",];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 150+100*i, 200, 100)];
        label.textColor = [UIColor whiteColor];
        label.text = array[i];
        label.font = [UIFont fontWithName:FONT size:36];
        [self.view addSubview:label];
        
        UITextField *MtextField = [[UITextField alloc] initWithFrame:CGRectMake(420, 160+100*i, 450, 80)];
        MtextField.borderStyle =UITextBorderStyleRoundedRect;
        MtextField.placeholder = textArray[i];
        MtextField.delegate = self;
        MtextField.tag = 1+i;
        MtextField.keyboardType=UIKeyboardTypeDefault;
        MtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        MtextField.font = [UIFont fontWithName:FONT size:30];
        [MtextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [MtextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        [self.view addSubview:MtextField];
        
    }
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureButton.frame = CGRectMake(700, 600, 170, 65);
    [sureButton setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}



-(void)sureButton:(UIButton *)button
{   UITextField *yuantextField = (UITextField *)[self.view viewWithTag:1];
    UITextField *newtextField = (UITextField *)[self.view viewWithTag:2];
    UITextField *congtextField = (UITextField *)[self.view viewWithTag:3];
    
    if (newtextField.text.length  == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    
    
    if ([congtextField.text isEqualToString:newtextField.text]) {
        NSLog(@"密码一致");
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.modify_passwd",BASEURL];
        NSDictionary *dict = @{@"old_passwd":[yuantextField.text MD5],@"new_passwd":[newtextField.text MD5]};
        [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
            NSLog(@"res   %@",responseObject);
            
            if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                [self.navigationController pushViewController:[ViewController new] animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
            
        } fail:^(NSError *error) {
            NSLog(@"error   %@",error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];

        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    
    
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
