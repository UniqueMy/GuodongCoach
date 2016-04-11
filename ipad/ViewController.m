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
        __block ViewController *view = self;
        self.block = ^{
            NSString *playPath = [[NSBundle mainBundle] pathForResource:@"Music" ofType:@"mp3"];
            
            
            view->_player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:playPath] error:nil];
            view->_player.delegate = view;
            view->_player.volume = 1.0;
            [view->_player play];
            NSLog(@"调用block");
        };
        
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
-(void)layoutSubviews{
    NSLog(@"重写layout方法");
    UIDeviceOrientation interfaceOrientation = (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        [self setVerticalFrame];
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        [self setHorizontalFrame];
    }
}
-(void)setVerticalFrame
{
    NSLog(@"竖屏");
}

-(void)setHorizontalFrame
{
    NSLog(@"横屏");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self layoutSubviews];
    if (self.isPush) {
        NSString *newurl = [NSString stringWithFormat:@"%@pad/?method=coach.order",BASEURL];
        [HttpTool postWithUrl:newurl params:nil contentType:CONTENTTYPE success:^(id responseObject) {
            NSLog(@"订单res  %@",responseObject);
            if ([[[[responseObject objectForKey:@"data"] objectForKey:@"new_order"] objectForKey:@"status"] intValue] == 1) {
                if (self.idnew_order) {
                    newamendViewController *new = [newamendViewController new];
                    new.order_id = self.idnew_order;
                    [self.navigationController pushViewController:new animated:YES];
                }
            }
            else if ([[[[responseObject objectForKey:@"data"] objectForKey:@"new_order"] objectForKey:@"status"] intValue] == 0)
            {
                NSLog(@"WHY  WHY ");
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
    
    NSArray *array = @[@"个人信息",@"搜索引擎",@"我的订单",@"我的训练",];
    for (int i = 0; i < 4; i++) {
        main_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        main_button.frame = CGRectMake(0,viewheight/4 *i+64,viewheight/4,viewheight/4);
        main_button.backgroundColor = [UIColor blackColor];
        main_button.tag = 10*i+10;
        [main_button setTitle:array[i] forState:UIControlStateNormal];
        main_button.titleLabel.font = [UIFont fontWithName:FONT size:30];
        main_button.tintColor = [UIColor whiteColor];
        [main_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:main_button];
    }
    
    mainImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainbutton1"]];
    mainImage.frame =CGRectMake(0,64,viewheight/4,viewheight/4);
    [self.view addSubview:mainImage];
    
    
    
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
    
    
    
   
    
    switch (button.tag)
    {
        case 10:
        {
            
            mainImage.frame = button.frame;
            titlelabel.text = @"个人信息";
            mainImage.image = [UIImage imageNamed:@"mainbutton1"];
           personView   *personview = [personView sharedViewControllerManager];
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.personal_info",BASEURL];
            NSLog(@"URL   %@",url);
            [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                NSLog(@"res   %@",responseObject);
                
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
                        NSLog(@"第一次点击按钮的绿点");
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
            // [self.navigationController pushViewController:personview animated:YES];
        }
            break;
        case 20:
        {
            NSLog(@"搜索");
            titlelabel.text = @"搜索引擎";
            mainImage.frame = button.frame;
            mainImage.image = [UIImage imageNamed:@"mainbutton2"];
           searchView   *search     = [searchView sharedViewControllerManager];
            [mainView addSubview:search.view];
            
            
            search.daohangBlock = ^(NSString *order_id){
                clientVC *client = [[clientVC alloc] init];
                NSString *or = [client setString2:order_id];
                NSLog(@"order_id  %@",or);
                [self.navigationController pushViewController:client animated:YES];
            };
            
            
        }
            break;
        case 30:
        {
            NSLog(@"订单");
            titlelabel.text = @"我的订单";
            mainImage.frame = button.frame;
            mainImage.image = [UIImage imageNamed:@"mainbutton3"];
           dingDanView  *dingDan    = [dingDanView sharedViewControllerManager];
            dingDan.coachName = coachName;
            //   [self.navigationController pushViewController:dingDan animated:YES];
            [mainView addSubview:dingDan.view];
            
            
           // dingDanView *dingDan = [dingDanView sharedViewControllerManager];
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

            
            dingDan.daohangBlock1 = ^(NSString *order_id){
                clientVC *client = [[clientVC alloc] init];
                NSString *ordrer =  [client setString2:order_id];
                NSLog(@"order_id   %@",ordrer);
                [self.navigationController pushViewController:client animated:YES];
            };
            dingDan.daohangBlock = ^(NSString *order_id){
                newamendViewController *newVC = [newamendViewController new];
                newVC.order_id = order_id;
                NSLog(@"new.order_id  %@",newVC.order_id);
                [self.navigationController pushViewController:newVC animated:YES];
            };
            dingDan.block = ^(NSString *order_id,NSString *name){
                ingamendViewController *ingVC = [ingamendViewController new];
                ingVC.order_id = order_id;
                ingVC.coachName = name;
                NSLog(@"coachName  %@",name);
                
                NSLog(@"new.order_id  %@",ingVC.order_id);
                [self.navigationController pushViewController:ingVC animated:YES];
            };
            
            
            
            break;
        }
            
        case 40:
        {
            NSLog(@"训练");
            titlelabel.text = @"我的训练";
            mainImage.frame = button.frame;
            mainImage.image = [UIImage imageNamed:@"mainbutton4"];
          
            
            
            
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
                    NSLog(@"practice.request %@",practice1.request);
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
