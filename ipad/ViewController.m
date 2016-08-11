//
//  ViewController.m
//  ipad
//
//  Created by mac on 15/3/14.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "ViewController.h"
#import "personView.h"
#import "searchView.h"
#import "practiceView.h"
#import "dingDanView.h"
#import "LoginViewController.h"
#import "newamendViewController.h"
#import "clientVC.h"
#import "dingdanComment.h"
#import "PracticeComment.h"
#import "ingamendViewController.h"
#import "TrainingViewController.h"
#import "KPIView.h"
#import "InteractiveView.h"
@interface ViewController ()
{
    int viewheight;
    int viewweight;
    UIView *mainView;
    UIImageView *mainImage;
    UILabel *titlelabel;
    UIButton *main_button;
    NSString *coachName;
    AVAudioPlayer           *_player;
    NSString                *_path;
    
}
@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.timeblock = ^(NSString *time)
        {
            ingamendViewController *ing = [ingamendViewController sharedViewControllerManager];
            ing.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 64, 500, 50)];
            ing.timeLabel.textColor = [UIColor whiteColor];
            ing.timeLabel.text = time;
            ing.timeLabel.font = [UIFont fontWithName:FONT size:30];
            [ing.view addSubview:ing.timeLabel];
        };
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isPush) {
        NSString *newurl = [NSString stringWithFormat:@"%@pad/?method=coach.order",BASEURL];
        [HttpTool postWithUrl:newurl params:nil contentType:CONTENTTYPE success:^(id responseObject) {

            if ([[[[responseObject objectForKey:@"data"] objectForKey:@"new_order"] objectForKey:@"status"] intValue] == 1) {
                if (self.idnew_order) {
                    newamendViewController *new = [newamendViewController new];
                    new.order_id = self.idnew_order;
                    [self.navigationController pushViewController:new animated:YES];
                }
            }
            else if ([[[[responseObject objectForKey:@"data"] objectForKey:@"new_order"] objectForKey:@"status"] intValue] == 0)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"订单已被处理" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"订单发生未知错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
        } fail:^(NSError *error) {
            NSLog(@"error %@",error);
        }];
    }
    
    
    //重写导航条
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIView *daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    titlelabel=[[UILabel alloc]init];
    titlelabel.text=@"个人信息";
    titlelabel.font=[UIFont fontWithName:FONT size:36];
    titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(875, 7, 100, 50);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:loginButton];
    
    
    
    viewheight = self.view.frame.size.height-64;
    viewweight = self.view.frame.size.width;
    
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(viewheight/4, 64, viewWidth-viewheight/4, viewHeight-64)];
    
  
    
    [self.view addSubview:mainView];
    
    
    
    personView *personview = [personView sharedViewControllerManager];
    
    [mainView addSubview:personview.view];
    
    NSArray *array = @[@"个人",@"搜索",@"订单",@"训练",@"培训",@"绩效",@"答疑"];
   //  NSArray *array = @[@"个人",@"搜索",@"订单",@"训练",@"培训",@"绩效"];
    
    //  NSArray *array = @[@"个人",@"搜索",@"订单",@"训练"];
    for (int i = 0; i < array.count; i++) {
        main_button       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        main_button.frame = CGRectMake(0,
                                       viewheight/array.count *i+64,
                                       viewheight/4,
                                       viewheight/array.count);
        main_button.backgroundColor = [UIColor blackColor];
        main_button.tag = 100*i+100;
        [main_button setTitle:array[i] forState:UIControlStateNormal];
        main_button.titleLabel.font = [UIFont fontWithName:FONT size:27];
        main_button.tintColor = [UIColor whiteColor];
        [main_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:main_button];
        if (i == 0) {
            main_button.backgroundColor = [UIColor orangeColor];
        }
        
        
    }
    
    
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.personal_info",BASEURL];
    
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"第一次进程序的res   %@",responseObject);
        
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            personview.nameLabel.text = [data objectForKey:@"username"];
            coachName =[data objectForKey:@"username"];
            personview.addressLabel.text =[data objectForKey:@"city"];
            personview.classLabel.text = [NSString stringWithFormat:@"%@节",[data objectForKey:@"class_times"]];
            personview.idLabel.text = [data objectForKey:@"id_card"];
            [personview.imageView setImageWithURL:[NSURL URLWithString:[data objectForKey:@"headimg"]]];
            [personview.yanImage setImageWithURL:[NSURL URLWithString:[data objectForKey:@"label"]]];
            if ([[data objectForKey:@"offline"] intValue] == 0) {
                NSLog(@"第一次进程序的绿点");
                personview.statusButton.backgroundColor = [UIColor greenColor];
                
            }
            else
            {
                personview.statusButton.backgroundColor = [UIColor orangeColor];
                
            }
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
    
    [mainView addSubview:personview.view];
    
    
    
}

-(void)buttonClick:(UIButton *)button
{
    UIButton *button1 = (UIButton *)[self.view viewWithTag:100];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:200];
    UIButton *button3 = (UIButton *)[self.view viewWithTag:300];
    UIButton *button4 = (UIButton *)[self.view viewWithTag:400];
    UIButton *button5 = (UIButton *)[self.view viewWithTag:500];
    UIButton *button6 = (UIButton *)[self.view viewWithTag:600];
    UIButton *button7 = (UIButton *)[self.view viewWithTag:700];
    
    //button.backgroundColor = [UIColor blackColor];
    switch (button.tag)
    {
        case 100:
        {
            
            button1.backgroundColor = [UIColor orangeColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor blackColor];
            
            
            titlelabel.text = @"个人信息";
            
            personView   *personview = [personView sharedViewControllerManager];
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.personal_info",BASEURL];
            
            [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                //  NSLog(@"res   %@",responseObject);
                
                if ([[responseObject objectForKey:@"rc"] intValue] == 0)
                {
                    NSDictionary *data = [responseObject objectForKey:@"data"];
                    personview.nameLabel.text = [data objectForKey:@"username"];
                    coachName =[data objectForKey:@"username"];
                    personview.addressLabel.text =[data objectForKey:@"city"];
                    personview.classLabel.text = [NSString stringWithFormat:@"%@节",[data objectForKey:@"class_times"]];
                    personview.idLabel.text = [data objectForKey:@"id_card"];
                    [personview.imageView setImageWithURL:[NSURL URLWithString:[data objectForKey:@"headimg"]]];
                    [personview.yanImage setImageWithURL:[NSURL URLWithString:[data objectForKey:@"label"]]];
                    if ([[data objectForKey:@"offline"] intValue] == 0) {
                        
                        personview.statusButton.backgroundColor = [UIColor greenColor];
                        
                    }
                    else
                    {
                        personview.statusButton.backgroundColor = [UIColor orangeColor];
                        
                    }
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
            
            [mainView addSubview:personview.view];
        }
            break;
        case 200:
        {
            NSLog(@"搜索");
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor orangeColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor blackColor];
            titlelabel.text = @"搜索引擎";
            
            searchView   *search     = [searchView sharedViewControllerManager];
            [mainView addSubview:search.view];
            
            
            search.daohangBlock = ^(NSString *order_id){
                clientVC *client = [[clientVC alloc] init];
                NSString *or = [client setString2:order_id];
                
                [self.navigationController pushViewController:client animated:YES];
            };
            
            
        }
            break;
        case 300:
        {
            NSLog(@"订单");
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor orangeColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor blackColor];
            titlelabel.text = @"我的订单";
            
            dingDanView  *dingDan    = [dingDanView sharedViewControllerManager];
            dingDan.coachName = coachName;
            
            [mainView addSubview:dingDan.view];
            
            
            
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.order",BASEURL];
            
            [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                //      NSLog(@"外面的订单   %@",responseObject);
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
                    //       NSLog(@"status   %@",dingDan.status);
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
            
            
            dingDan.daohangBlock1 = ^(NSString *order_id){
                clientVC *client = [[clientVC alloc] init];
                NSString *ordrer =  [client setString2:order_id];
                
                [self.navigationController pushViewController:client animated:YES];
            };
            dingDan.daohangBlock = ^(NSString *order_id){
                newamendViewController *newVC = [newamendViewController new];
                newVC.order_id = order_id;
                
                [self.navigationController pushViewController:newVC animated:YES];
            };
            dingDan.block = ^(NSString *order_id,NSString *name){
                ingamendViewController *ingVC = [ingamendViewController new];
                ingVC.order_id = order_id;
                ingVC.coachName = name;
                [self.navigationController pushViewController:ingVC animated:YES];
            };
            
            
            
            
        }
            break;
        case 400:
        {
            NSLog(@"训练");
            titlelabel.text = @"我的训练";
            
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor orangeColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor blackColor];
            
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.my_training",BASEURL];
            [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                
                
                if ([[responseObject objectForKey:@"rc"] intValue] == 0)
                {
                    
                    NSArray *dataArray = [responseObject objectForKey:@"data"];
                    
                    practiceView *practice1  = [practiceView sharedViewControllerManager];
                    
                    practice1.request  =[[NSMutableArray alloc] initWithCapacity:0];
                    practice1.planArray  =[[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *dict in dataArray)
                    {
                        PracticeComment *search = [[PracticeComment alloc] initWithDictionary:dict];
                        [practice1.request addObject:search];
                    }
                   
                    [mainView addSubview:practice1.view];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    
                    [alert show];
                }
            } fail:^(NSError *error) {
                NSLog(@"error  %@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
                
            }];
            
        }
            break;
        case 500: {
            NSLog(@"培训");
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor orangeColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor blackColor];
            
            titlelabel.text = @"我的培训";
            
            TrainingViewController *trainView = [TrainingViewController sharedViewControllerManager];
            [mainView addSubview:trainView.view];
        }
             break;
        case 600: {
            NSLog(@"绩效");
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor orangeColor];
            button7.backgroundColor = [UIColor blackColor];
            
            titlelabel.text = @"我的绩效";
            
            KPIView *kpi = [KPIView new];
            [mainView addSubview:kpi];
        }
            break;
        case 700: {
            NSLog(@"互动");
            button1.backgroundColor = [UIColor blackColor];
            button2.backgroundColor = [UIColor blackColor];
            button3.backgroundColor = [UIColor blackColor];
            button4.backgroundColor = [UIColor blackColor];
            button5.backgroundColor = [UIColor blackColor];
            button6.backgroundColor = [UIColor blackColor];
            button7.backgroundColor = [UIColor orangeColor];
            
            titlelabel.text = @"用户答疑";
            
            InteractiveView *interactive = [InteractiveView new];
            [mainView addSubview:interactive];
        }
            break;
        default:
            break;
            
            
            
            
            
    }
}
-(void)gotoLogin:(UIButton *)button
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static ViewController* viewController;
    
    dispatch_once(&onceToken, ^{
        viewController = [[ViewController alloc] init];
    });
    
    return viewController;
}

@end
