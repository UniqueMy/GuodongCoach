//
//  newamendViewController.m
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "newamendViewController.h"
#import "dingDanView.h"
#import "ingamendViewController.h"
#import "dingdanComment.h"
@implementation newamendViewController
{
    UILabel *name;
    UILabel *sex;
    UILabel *number;
    UILabel *classname;
    UILabel *address;
    UILabel *date;
    UILabel *classnumber;
    UILabel *classStyle;
    UILabel *personNumber;
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
    titlelabel.text=@"新的订单";
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
    
}
-(void)createView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 850, 250)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.neworder",BASEURL];
    NSDictionary *dict = @{@"order_id":self.order_id};
    [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res   %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            
            NSDictionary *data = [responseObject objectForKey:@"data"];
            name.text = [data objectForKey:@"name"];
        
                if ([[data objectForKey:@"gender"] intValue] == 1) {
                    sex.text = @"男";
                }else
                {
                    sex.text = @"女";
                }

            
            
            number.text = [NSString stringWithFormat:@"电话：%@",[data objectForKey:@"number"]];
            
            classname.text = [NSString stringWithFormat:@"约课类型：%@",[data objectForKey:@"course"]];
            
            address.text = [NSString stringWithFormat:@"住址：%@",[data objectForKey:@"place"]];
            // 时间戳转时间的方法:
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"MM月dd日 HH时"];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"pre_time"] intValue]];
            NSLog(@"1296035591  = %@",confromTimesp);
            NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
            date.text = [NSString stringWithFormat:@"约课时间(日期)：%@",confromTimespStr];
            classnumber.text = [NSString stringWithFormat:@"上课次数：%@次",[data objectForKey:@"class_number"]];
            classStyle.text = [NSString stringWithFormat:@"类型：%@",[data objectForKey:@"order_type"]];
            personNumber.text = [NSString stringWithFormat:@"人数：%@",[data objectForKey:@"course_number"]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
            
        }
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 120, 20)];
    name.textColor = [UIColor whiteColor];
   
    name.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:name];
    
    sex = [[UILabel alloc] initWithFrame:CGRectMake(180, 40, 50, 20)];
    sex.textColor = [UIColor whiteColor];
    
    sex.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:sex];
    
    number = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 270, 20)];
    number.textColor = [UIColor whiteColor];
   
    number.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:number];
    
    classname = [[UILabel alloc] initWithFrame:CGRectMake(540, 40, 350, 20)];
    classname.textColor = [UIColor whiteColor];

    classname.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:classname];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 600, 20)];
    address.textColor = [UIColor whiteColor];
    
    address.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:address];
    
    date = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 500, 20)];
    date.textColor = [UIColor whiteColor];
    date.font = [UIFont fontWithName:FONT size: 27];
    [view addSubview:date];
    
    
    classnumber = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 220, 20)];
    classnumber.textColor = [UIColor whiteColor];
    classnumber.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:classnumber];
    
    classStyle = [[UILabel alloc] initWithFrame:CGRectMake(300, 200, 250, 20)];
    classStyle.textColor = [UIColor whiteColor];
    classStyle.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:classStyle];
    
    personNumber = [[UILabel alloc] initWithFrame:CGRectMake(550, 200, 250, 20)];
    personNumber.textColor = [UIColor whiteColor];
    personNumber.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:personNumber];
    
    UIButton *accrectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    accrectButton.frame = CGRectMake(200, 450, 160, 70);
    [accrectButton setBackgroundImage:[UIImage imageNamed:@"accrect"] forState:UIControlStateNormal];
    [accrectButton addTarget:self action:@selector(accrectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accrectButton];
    
    UIButton *refuseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    refuseButton.frame = CGRectMake(680, 450, 160, 70);
    [refuseButton setBackgroundImage:[UIImage imageNamed:@"refuse"] forState:UIControlStateNormal];
    [refuseButton addTarget:self action:@selector(refuseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refuseButton];
    
    
    
}
-(void)accrectClick:(UIButton *)button
{
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.accept_order&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res   %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
            ingamendViewController *ingVC = [ingamendViewController new];
            ingVC.order_id = self.order_id;
            [self.navigationController pushViewController:ingVC animated:YES];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }];
    
    
    
}
-(void)refuseButton:(UIButton *)button
{
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.refused_order&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res   %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
          //  dingDanView *dingdan = [dingDanView sharedViewControllerManager];
          //  [dingdan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
            dingDanView *dingdan = [dingDanView sharedViewControllerManager];
            [dingdan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
            dingDanView *dingDan = [dingDanView sharedViewControllerManager];
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.order",BASEURL];
            
            [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                NSLog(@"外面的订单   %@",responseObject);
                if ([[responseObject objectForKey:@"rc"] intValue] == 0)
                {
                    NSDictionary *data = [responseObject objectForKey:@"data"];
                    NSArray *order = [data objectForKey:@"order"];
                    
                    dingDan.request = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *dict in order) {
                        dingdanComment *dingdanCom = [[dingdanComment alloc] initWithDictionary:dict];
                        [dingDan.request addObject:dingdanCom];
                        [dingDan.tableView reloadData];
                    }
                    
                    NSDictionary *new_order = [data objectForKey:@"new_order"];
                    dingDan.orderArray = [new_order objectForKey:@"orders"];
                    dingDan.status = [new_order objectForKey:@"status"];
                    if ([dingDan.status intValue] == 1) {
                        [dingDan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"youdingdan"] forState:UIControlStateNormal];
                    }
                    if ([dingDan.status intValue] == 0)
                    {
                        [dingDan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
                    }
                    NSLog(@"status   %@",dingDan.status);
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
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }];
    
    
    
    
}
-(void)goback:(UIButton *)button
{
    dingDanView *dingdan = [dingDanView sharedViewControllerManager];
    [dingdan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
    dingDanView *dingDan = [dingDanView sharedViewControllerManager];
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.order",BASEURL];
    
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"外面的订单   %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSArray *order = [data objectForKey:@"order"];
            
            dingDan.request = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in order) {
                dingdanComment *dingdanCom = [[dingdanComment alloc] initWithDictionary:dict];
                [dingDan.request addObject:dingdanCom];
                [dingDan.tableView reloadData];
            }
            
            NSDictionary *new_order = [data objectForKey:@"new_order"];
            dingDan.orderArray = [new_order objectForKey:@"orders"];
            dingDan.status = [new_order objectForKey:@"status"];
            if ([dingDan.status intValue] == 1) {
                [dingDan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"youdingdan"] forState:UIControlStateNormal];
            }
            if ([dingDan.status intValue] == 0)
            {
                [dingDan.dingdanButton setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
            }
            NSLog(@"status   %@",dingDan.status);
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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
