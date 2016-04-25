//
//  clientVC.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "clientVC.h"
#import "questionnaireVC.h"
#import "ClientComment.h"
#import "XQViewController.h"
#import "bodyTextVC.h"
@implementation clientVC {
   
    ClientComment *baseclient;
    ClientComment *healthclient;
    ClientComment *bodyclient;
    NSString *sex;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:27.00/255 green:27.00/255 blue:27.00/255 alpha:1];
    UIView *daohangView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text     = @"客户资料";
    titlelabel.font     = [UIFont fontWithName:FONT size:36];
    titlelabel.frame    = CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:backButton];
    
    
    [self createView];
    
}
- (NSString *)setString2:(NSString *)string
{
    string = [string mutableCopy];
    _order_id = string;
    NSLog(@"order_id%@",_order_id);
    return string;
}

-(void)createView
{
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(10, 90, 500, 220)];
    baseView.backgroundColor = [UIColor colorWithRed:83.00/255 green:83.00/255 blue:83.00/255 alpha:1];
    [self.view addSubview:baseView];
    UIView *sportView = [[UIView alloc] initWithFrame:CGRectMake(10, 320, 500, 220)];
    sportView.backgroundColor = [UIColor colorWithRed:252.00/255 green:119.00/255 blue:7.00/255 alpha:1];
    [self.view addSubview:sportView];
    UIView *recordView = [[UIView alloc] initWithFrame:CGRectMake(10, 550, 1004, 195)];
    recordView.backgroundColor = [UIColor colorWithRed:153.00/255 green:115.00/255 blue:175.00/255 alpha:1];
    recordView.userInteractionEnabled = YES;
    [self.view addSubview:recordView];
    
    NSString *url =[NSString stringWithFormat:@"%@pad/?method=coach.details&order_id=%@",BASEURL,_order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
      //  NSLog(@"res  %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            
            NSDictionary *baseDict = [data objectForKey:@"base"];
            NSDictionary *healthDict = [data objectForKey:@"recard"];
            NSDictionary *bodyDict = [data objectForKey:@"area"];
            
            if ([[data objectForKey:@"area"] count] !=0) {
                bodyclient = [[ClientComment alloc] initWithDictionary:bodyDict];
                UILabel *area = (UILabel *)[sportView viewWithTag:6];
                area.text = [NSString stringWithFormat:@"运动面积：%@平米",bodyclient.area];
                UILabel *xggd = (UILabel *)[sportView viewWithTag:7];
                xggd.text = [NSString stringWithFormat:@"悬挂固定：%@",bodyclient.xggd];
                UILabel *apparatu = (UILabel *)[sportView viewWithTag:8];
                apparatu.text = [NSString stringWithFormat:@"自有器械：%@",bodyclient.apparatu];
                
            }
            if ([[data objectForKey:@"recard"] count] != 0) {
                healthclient = [[ClientComment alloc] initWithDictionary:healthDict];
                // 时间戳转时间的方法:
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YY年MM月dd日"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[healthclient.date intValue]];
                
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                NSLog(@"1296035591  = %@",confromTimespStr);
                UILabel *date = (UILabel *)[recordView viewWithTag:9];
                date.text = [NSString stringWithFormat:@"日期：%@",confromTimespStr];
                
                
                UILabel *time = (UILabel *)[recordView viewWithTag:10];
                time.text = [NSString stringWithFormat:@"时长：%@",healthclient.time];
                UILabel *coach = (UILabel *)[recordView viewWithTag:11];
                coach.text = [NSString stringWithFormat:@"教练员：%@",healthclient.coach];
                UILabel *content = (UILabel *)[recordView viewWithTag:12];
                content.text = [NSString stringWithFormat:@"练习内容：%@",healthclient.content];
                UILabel *heart_rate = (UILabel *)[recordView viewWithTag:13];
                heart_rate.text = [NSString stringWithFormat:@"最高心率：%@",healthclient.heart_rate];
                NSArray *array = @[@"一般",@"良好",@"活跃"];
                
                UILabel *expression = (UILabel *)[recordView viewWithTag:14];
                NSLog(@"[healthclient.expression intValue] %d",[healthclient.expression intValue]);
                
                expression.text = [NSString stringWithFormat:@"运动表现：%@",array[[healthclient.expression intValue]]];
            
                UILabel *enthusiasm = (UILabel *)[recordView viewWithTag:15];
                enthusiasm.text = [NSString stringWithFormat:@"会员热情度：%@",array[[healthclient.enthusiasm intValue]]];
            }
            
            if ([[data objectForKey:@"base"] count] !=0) {
                baseclient = [[ClientComment alloc] initWithDictionary:baseDict];
                
                
                
                UILabel *nameLabel = (UILabel *)[baseView viewWithTag:1];
                nameLabel.text = baseclient.name;
                UILabel *sexLabel = (UILabel *)[baseView viewWithTag:2];
                NSLog(@"sex   %@",baseclient.sex);
                
                sexLabel.text = [NSString stringWithFormat:@"性别：%@",baseclient.sex];
                
                UILabel *ageLabel = (UILabel *)[baseView viewWithTag:3];
                ageLabel.text = [NSString stringWithFormat:@"年龄：%@",baseclient.age];
                UILabel *number = (UILabel *)[baseView viewWithTag:4];
                number.text = [NSString stringWithFormat:@"电话：%@",baseclient.number];
                UILabel *address = (UILabel *)[baseView viewWithTag:5];
                address.text = [NSString stringWithFormat:@"地址：%@",baseclient.address];
                
            }
            
            
            
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error   %@",error   );
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(650, 180 + 150*i, 270, 80);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"health%d",i]] forState:UIControlStateNormal];
        button.tag = 17+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 5, 150, 30)];
    baseLabel.text = @"基本资料";
    baseLabel.textColor = [UIColor whiteColor];
    baseLabel.font = [UIFont fontWithName:FONT size:30];
    [baseView addSubview:baseLabel];
    
    
    for (int a = 0; a < 3; a++)
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + 150*a, 50, 150, 30)];
        label1.tag = 1 + a;
        label1.textColor = [UIColor colorWithRed:202.00/255 green:187.00/255 blue:187.00/255 alpha:1];
        label1.font = [UIFont fontWithName:FONT size:25];
        [baseView addSubview:label1];
    }
    
    for (int b = 0; b < 2; b++)
    {
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20 , 95 , 480, 30)];
        label2.tag = 4 + b;
        label2.textColor = [UIColor colorWithRed:202.00/255 green:187.00/255 blue:187.00/255 alpha:1];
        label2.font = [UIFont fontWithName:FONT size:25];
        if (b == 1) {
            label2.frame = CGRectMake(20 , 140 , 480, 60);
            label2.numberOfLines = 0;
        }
        [baseView addSubview:label2];
    }
    
    
    UILabel *sportLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 5, 200, 60)];
    sportLabel.text = @"运动区域情况";
    sportLabel.textColor = [UIColor redColor];
    sportLabel.font = [UIFont fontWithName:FONT size:30];
    [sportView addSubview:sportLabel];
    
    
    for (int c = 0; c < 3; c++) {
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(50 , 65 + 50*c, 450, 40)];
        label3.tag = 6 + c;
        // label3.backgroundColor = [UIColor redColor];
        label3.textColor = [UIColor colorWithRed:209.00/255 green:204.00/255 blue:202.00/255 alpha:1];
        label3.font = [UIFont fontWithName:FONT size:25];
        [sportView addSubview:label3];
    }
    
    
    UILabel *recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(800, 5, 200, 60)];
    recordLabel.text = @"最近运动记录";
    recordLabel.textColor = [UIColor orangeColor];
    recordLabel.font = [UIFont fontWithName:FONT size:30];
    [recordView addSubview:recordLabel];
    
    UIButton *recordbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    recordbutton.frame = CGRectMake(10, 550, 1004, 195);
    recordbutton.tag = 16;
    [recordbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    recordbutton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:recordbutton];
    
    
    for (int d = 0; d < 3; d++)
    {
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(50 + 300 *d , 60 , 300, 30)];
        label4.tag = 9 + d;
        label4.textColor = [UIColor colorWithRed:209.00/255 green:204.00/255 blue:202.00/255 alpha:1];
        label4.font = [UIFont fontWithName:FONT size:25];
        [recordView addSubview:label4];
    }
    for (int e = 0; e < 2; e++)
    {
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(650 , 105  , 300, 30)];
        label5.tag = 12 + e;
        
        label5.textColor = [UIColor colorWithRed:209.00/255 green:204.00/255 blue:202.00/255 alpha:1];
        label5.font = [UIFont fontWithName:FONT size:25];
        [recordView addSubview:label5];
        if (e == 0)
        {
            label5.frame = CGRectMake(50, 105, 600, 30);
        }
    }
    
    UILabel *biaoxianLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 145, 300, 30)];
    biaoxianLabel.tag = 14;
    biaoxianLabel.textColor = [UIColor colorWithRed:209.00/255 green:204.00/255 blue:202.00/255 alpha:1];
    biaoxianLabel.font = [UIFont fontWithName:FONT size:25];
    [recordView addSubview:biaoxianLabel];
    
    UILabel *activeLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 145, 300, 30)];
    activeLabel.tag = 15;
    activeLabel.textColor = [UIColor colorWithRed:209.00/255 green:204.00/255 blue:202.00/255 alpha:1];
    activeLabel.font = [UIFont fontWithName:FONT size:25];
    [recordView addSubview:activeLabel];
    
    UILabel *xiangqing = [[UILabel alloc] initWithFrame:CGRectMake(800, 145, 300, 30)];
    xiangqing.text = @"以往运动记录";
    xiangqing.tag = 15;
    xiangqing.textColor = [UIColor orangeColor];
    xiangqing.font = [UIFont fontWithName:FONT size:25];
    [recordView addSubview:xiangqing];
    
    UIButton *biaoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    biaoButton.frame = recordView.frame;
    [biaoButton addTarget:self action:@selector(biaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:biaoButton];
    
    
}
-(void)biaoButton:(UIButton *)button
{
    NSLog(@"点击了表按钮");
    XQViewController *xqVC = [XQViewController new];
    xqVC.order_id = _order_id;
    [self.navigationController pushViewController:xqVC animated:YES];
}
-(void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case 17:
        {
//            LookBodyTextVC *body = [LookBodyTextVC new];
//            body.order_id = _order_id;
//            [self.navigationController pushViewController:body animated:YES];
            
            bodyTextVC *botyVC = [bodyTextVC new];
            botyVC.order_id = self.order_id;
            botyVC.complete = YES;
            [self.navigationController pushViewController:botyVC animated:YES];
        }
            break;
        case 18:
        {
            questionnaireVC *jiankang = [questionnaireVC new];
            jiankang.order_id = _order_id;
            jiankang.isOver = @"over";
            [self.navigationController pushViewController:jiankang animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
