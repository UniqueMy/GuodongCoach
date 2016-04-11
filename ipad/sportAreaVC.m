//
//  sportAreaVC.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "sportAreaVC.h"
@implementation sportAreaVC

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
    titlelabel.text=@"运动区域表格";
    titlelabel.font=[UIFont fontWithName:FONT size:36];
    titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:backButton];
    
    [self createView];
    [self requestView];
}

-(void)requestView
{
    UITextField *textField1 = (UITextField *) [self.view viewWithTag:1];
    UITextField *textField2 = (UITextField *) [self.view viewWithTag:2];
    UITextField *textField3 = (UITextField *) [self.view viewWithTag:3];
    
    NSString *url =[NSString stringWithFormat:@"%@pad/?method=coach.details&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        // NSLog(@"res  %@",responseObject);
        //enthusiasm  热情
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSDictionary *recard = [data objectForKey:@"area"];
        NSLog(@"recard  %@",recard);
        textField1.text  = [recard objectForKey:@"area"];
        textField2.text  = [recard objectForKey:@"xggd"];
        textField3.text  = [recard objectForKey:@"apparatu"];
        
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    
}
-(void)createView
{
    NSArray *array = @[@"运动面积：",@"悬挂固定：",@"自有器械："];
    for (int i = 0; i < 3 ; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150+150*i, 200, 50)];
        label.text = array[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:FONT size:36];
        [self.view addSubview:label];
        
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(290, 150 + 150*i, 500, 60)];
        textField.borderStyle =UITextBorderStyleRoundedRect;
        textField.textAlignment = 1;
        textField.delegate = self;
        textField.tag = 1+i;
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        [self.view addSubview:textField];
        switch (i) {
            case 0:
            {
                textField.keyboardType=UIKeyboardTypeNumberPad;
                textField.placeholder = @"xxx平米";
                [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
                [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(700, 600, 150, 60);
    [saveButton setBackgroundImage:[UIImage imageNamed:@"tijiao"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}
-(void)buttonClick:(UIButton *)button
{
    UITextField *textField1 = (UITextField *) [self.view viewWithTag:1];
    UITextField *textField2 = (UITextField *) [self.view viewWithTag:2];
    UITextField *textField3 = (UITextField *) [self.view viewWithTag:3];
    
    if (textField1.text.length == 0||textField2.text.length == 0||textField3.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"都是必填项哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    else
    {
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.sport_area",BASEURL];
        NSDictionary *dict = @{
                               @"order_id":self.order_id,
                               @"area":textField1.text,
                               @"xggd":textField2.text,
                               @"apparatu":textField3.text
                               };
        [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
            NSLog(@"res   %@",responseObject);
            if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
            
        } fail:^(NSError *error) {
            NSLog(@"error  %@",error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }];
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
