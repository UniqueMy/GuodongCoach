//
//  ingamendViewController.m
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "ingamendViewController.h"
#import "sportrecordVC.h"
#import "sportAreaVC.h"
#import "bodyTextVC.h"
#import "questionnaireVC.h"
#import "ViewController.h"
#import "dingDanView.h"
#import "dingdanComment.h"
#import "AppDelegate.h"
@implementation ingamendViewController
{
    BOOL ziliaoisopen;
    BOOL yundongisopen;
    BOOL doorisopen;
    BOOL startisopen;
    BOOL overisopen;
    UIView *ziliaoView,*yundongView;
    UIImageView *backImage;
    UIImageView *uploadImage;
    UIButton *uploadButton;
    
    
    
    //int secondsCountDown ;//60秒倒计时
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
    titlelabel.text=@"接单进行中";
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
    
    UIButton *TDButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    TDButton.frame = CGRectMake(875, 7, 100, 50);
    [TDButton setBackgroundImage:[UIImage imageNamed:@"tuidan"] forState:UIControlStateNormal];
    [TDButton addTarget:self action:@selector(gotoTD:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:TDButton];
    
    
  
  
    
//    
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.frame = CGRectMake(0, 100, 50, 50);
//        button.backgroundColor = [UIColor redColor];
//        [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//    
    
    
    
    [self createView];
    
    
    
    
    
}
//-(void)button
//{
//    __block int timeout=5; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND ,INT16_MIN);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            //  dispatch_release(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"time  %@",_timer);
//                ViewController *view = [ViewController sharedViewControllerManager];
//                view.block();
//                //设置界面的按钮显示 根据自己需求设置
//                //    。。。。。。。。
//            });
//        }else{
//            int minutes = timeout / 60;
//            int seconds = timeout % 60;
//            self.strTime = [NSString stringWithFormat:@"距离下课还有%d分%.2d秒",minutes, seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"srt  %@", self.strTime);
//                //设置界面的按钮显示 根据自己需求设置
//            //    _timeLabel.text =  self.strTime;
//                ViewController *view = [ViewController sharedViewControllerManager];
//                view.timeblock(self.strTime);
//                NSLog(@"strTime  %@", self.strTime);
//                //   。。。。。。。。time = strmtime;   int   mint = timeout;
//            });
//            timeout--;
//
//        }
//    });
//    dispatch_resume(_timer);
//
//}
-(void)createView
{
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.button",BASEURL];
    NSDictionary *dict = @{@"order_id":self.order_id};
    [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject)
     {
         NSLog(@"res  %@",responseObject);
         if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
             NSDictionary *data = [responseObject objectForKey:@"data"];
             doorisopen = [[NSString stringWithFormat:@"%@",[data objectForKey:@"isdoor"]] intValue] ;
             startisopen = [[NSString stringWithFormat:@"%@",[data objectForKey:@"isstart"]] intValue] ;
             overisopen = [[NSString stringWithFormat:@"%@",[data objectForKey:@"isstop"]] intValue] ;
             UIButton *button3 = (UIButton *)[self.view viewWithTag:3];
             UIButton *button6 = (UIButton *)[self.view viewWithTag:6];
             UIButton *button9 = (UIButton *)[self.view viewWithTag:9];
             
             NSLog(@"doorisopen  %d  start  %d   over  %d",doorisopen,startisopen,overisopen);
             if (doorisopen == YES ) {
                 
                 [button3 setBackgroundImage:[UIImage imageNamed:@"jiedan0"] forState:UIControlStateNormal];
             }
             if (startisopen == YES) {
                 [button6 setBackgroundImage:[UIImage imageNamed:@"jiedan1"] forState:UIControlStateNormal];
             }
             if (overisopen == YES ) {
                 [button9 setBackgroundImage:[UIImage imageNamed:@"jiedan2"] forState:UIControlStateNormal];
             }
             
             if (doorisopen == YES&&startisopen == YES&&overisopen == YES)
             {
                 uploadImage.image = [UIImage imageNamed:@"uploadred"];
                 [backImage addSubview:uploadButton];
             }
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
             
             [alert show];
             
         }
     }
                     fail:^(NSError *error) {
                         NSLog(@"error  %@",error);
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                         
                         [alert show];
                     }];
    
    NSArray *array  = @[@"教练出门",@"开始上课",@"下课签到",];
    
    backImage = [[UIImageView alloc] initWithFrame:CGRectMake(180, 550, 700, 100)];
    //   backImage.image = [UIImage imageNamed:@"xiantiao"];
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    
    uploadButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    uploadButton.frame = CGRectMake(260, 60, 180, 60);
    uploadButton.tag = 1000;
    [uploadButton addTarget:self action:@selector(uploadButton:) forControlEvents:UIControlEventTouchUpInside];
    
    uploadImage = [[UIImageView alloc] initWithFrame:uploadButton.frame];
    uploadImage.image = [UIImage imageNamed:@"uploadgry"];
    uploadImage.userInteractionEnabled = YES;
    [backImage addSubview:uploadImage];
    
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(150+300*i, 150, 180, 180);
        button.tag = 3 + 3*i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jiedangry%d",i]] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(180+ 300*i, 360, 180, 30)];
        label.textColor = [UIColor whiteColor];
        label.text = array[i];
        label.font = [UIFont fontWithName:FONT size:30];
        [self.view addSubview:label];
        
        
    }
    
    for (int a = 0; a < 2; a++) {
        UIButton *ziliaoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ziliaoButton.frame = CGRectMake(295+300*a, 450, 180, 60);
        ziliaoButton.tag = 4 + 4*a;
        //  ziliaoButton.backgroundColor = [UIColor redColor];
        [ziliaoButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [ziliaoButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"ziliao%d",a]] forState:UIControlStateNormal];
        
        [self.view addSubview:ziliaoButton];
    }
    
    ziliaoView = [[UIView alloc] initWithFrame:CGRectMake(295, 330, 180, 120)];
    UIImageView *textImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 120)];
    textImage.image = [UIImage imageNamed:@"text"];
    textImage.userInteractionEnabled = YES;
    [ziliaoView addSubview:textImage];
    
    for (int c = 0;c < 2; c++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //   button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(0, 61*c, 180, 60);
        button.tag = 7+7*c;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [ziliaoView addSubview:button];
        
    }
    
    yundongView = [[UIView alloc] initWithFrame:CGRectMake(595, 330, 180, 120)];
    UIImageView *yundongImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 120)];
    yundongImage.image = [UIImage imageNamed:@"yundong"];
    yundongImage.userInteractionEnabled = YES;
    [yundongView addSubview:yundongImage];
    
    for (int c = 0;c < 2; c++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //   button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(0, 61*c, 180, 60);
        button.tag = 10+10*c;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [yundongView addSubview:button];
        
    }
    
}
-(void)uploadButton:(UIButton *)button
{
    NSLog(@"进来了");
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.upload&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res   %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"成功上传资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alert.tag = 400;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [alert show];
        }
    } fail:^(NSError *error)
     {
         NSLog(@"error  %@",error);
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接错误，正在排查中...." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
         
         [alert show];
     }];
    
}
-(void)buttonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case 3:
        {
            if (!doorisopen)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"教练，您准备好出门了么？" delegate:self cancelButtonTitle:@"再等等" otherButtonTitles:@"是的", nil];
                alert.tag = 100;
                [alert show];
                
            }
            
            
        }
            break;
        case 6:
        {
            if (doorisopen)
            {
                if (!startisopen)
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"教练，您准备好上课了么？" delegate:self cancelButtonTitle:@"再等等" otherButtonTitles:@"是的", nil];
                    alert.tag = 200;
                    [alert show];
                    
                }
                
                
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"教练你出门了么？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
            break;
        case 9:
        {
            if (startisopen) {
                if (!overisopen) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"教练，您的课程结束了么？" delegate:self cancelButtonTitle:@"再等等" otherButtonTitles:@"是的", nil];
                    alert.tag = 300;
                    [alert show];
                    
                }
                
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"教练你上课了么？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
            
        }
            break;
            
        case 4:
        {
            if (ziliaoisopen)
            {
                [button setBackgroundImage:[UIImage imageNamed:@"ziliao0"] forState:UIControlStateNormal];
                [ziliaoView removeFromSuperview];
                ziliaoisopen = NO;
            }
            else
            {
                [button setBackgroundImage:[UIImage imageNamed:@"ziliaoxia"] forState:UIControlStateNormal];
                [self.view addSubview:ziliaoView];
                ziliaoisopen = YES;
            }
        }
            break;
        case 8:
        {
            if (yundongisopen)
            {
                [button setBackgroundImage:[UIImage imageNamed:@"ziliao1"] forState:UIControlStateNormal];
                [yundongView removeFromSuperview];
                yundongisopen = NO;
            }
            else
            {
                [button setBackgroundImage:[UIImage imageNamed:@"yundongxia"] forState:UIControlStateNormal];
                [self.view addSubview:yundongView];
                yundongisopen = YES;
            }
            
            //
        }
            break;
        case 20:
        {
            sportrecordVC *sport = [sportrecordVC new];
            sport.order_id = self.order_id;
            sport.coachName = self.coachName;
            [self.navigationController pushViewController:sport animated:YES];
        }
            break;
            
        case 10:
        {
            sportAreaVC *sport = [sportAreaVC new];
            sport.order_id = self.order_id;
            [self.navigationController pushViewController:sport animated:YES];
        }
            break;
        case 7:
        {
            NSLog(@"点击了身体测试");
            bodyTextVC *botyVC = [bodyTextVC new];
            botyVC.order_id = self.order_id;
            botyVC.complete = NO;
            botyVC.coachName = self.coachName;
            [self.navigationController pushViewController:botyVC animated:YES];
        }
            break;
        case 14:
        {
            NSLog(@"点击了健康问卷");
            questionnaireVC *quest = [questionnaireVC new];
            quest.order_id = self.order_id;
            [self.navigationController pushViewController:quest animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)gotoTD:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退单么?" delegate:self cancelButtonTitle:@"不退单" otherButtonTitles:@"确认退单", nil];
    alert.tag = 600;
    [alert show];
    
    
}
//点击事件的绑定方法   （记得声明协议）
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    switch (alertView.tag) {
        case 100:
        {
            if (buttonIndex ==1) {
                UIButton *button  =(UIButton *)[self.view viewWithTag:3];
                if ((UIButton *)[self.view viewWithTag:3])
                {
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.coach_out&order_id=%@",BASEURL,self.order_id];
                    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                        NSLog(@"res   %@",responseObject);
                        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                            [button setBackgroundImage:[UIImage imageNamed:@"jiedan0"] forState:UIControlStateNormal];
                            doorisopen = YES;
                        }
                    } fail:^(NSError *error) {
                        NSLog(@"error  %@",error);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        
                        [alert show];
                    }];
                }
                
            }
            
        }
            break;
        case 200:
        {
            if (buttonIndex == 1) {
                UIButton *button  =(UIButton *)[self.view viewWithTag:6];
                if ((UIButton *)[self.view viewWithTag:6])
                {
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.course_start&order_id=%@",BASEURL,self.order_id];
                    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                        NSLog(@"res   %@",responseObject);
                        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                            [button setBackgroundImage:[UIImage imageNamed:@"jiedan1"] forState:UIControlStateNormal];
                            startisopen = YES;
//                            __block int timeout=3600; //倒计时时间
//                            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND ,INT16_MIN);
//                            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//                            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//                            dispatch_source_set_event_handler(_timer, ^{
//                                if(timeout<=0){ //倒计时结束，关闭
//                                    dispatch_source_cancel(_timer);
//                                    //  dispatch_release(_timer);
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        NSLog(@"time  %@",_timer);
//                                        ViewController *view = [ViewController sharedViewControllerManager];
//                                        view.block();
//                                        //设置界面的按钮显示 根据自己需求设置
//                                        //    。。。。。。。。
//                                    });
//                                }else{
//                                    int minutes = timeout / 60;
//                                    int seconds = timeout % 60;
//                                    self.strTime = [NSString stringWithFormat:@"距离下课还有%d分%.2d秒",minutes, seconds];
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        NSLog(@"srt  %@", self.strTime);
//                                        //设置界面的按钮显示 根据自己需求设置
//                                        _timeLabel.text =  self.strTime;
//                                        NSLog(@"strTime  %@", self.strTime);
//                                        //   。。。。。。。。time = strmtime;   int   mint = timeout;
//                                    });
//                                    timeout--;
//                                    
//                                }
//                            });
//                            dispatch_resume(_timer);
                            
                            
                        }
                        
                    } fail:^(NSError *error) {
                        NSLog(@"error  %@",error);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        
                        [alert show];
                    }];
                    
                }
                
            }
            
        }
            break;
        case 300:
        {
            if (buttonIndex == 1) {
                UIButton *button  =(UIButton *)[self.view viewWithTag:9];
                if ((UIButton *)[self.view viewWithTag:9])
                {
                    
                    uploadImage.image = [UIImage imageNamed:@"uploadred"];
                    [backImage addSubview:uploadButton];
                    
                    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.course_stop&order_id=%@",BASEURL,self.order_id];
                    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                        NSLog(@"res   %@",responseObject);
                        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                            [button setBackgroundImage:[UIImage imageNamed:@"jiedan2"] forState:UIControlStateNormal];
                            overisopen = YES;
                        }
                    } fail:^(NSError *error) {
                        NSLog(@"error  %@",error);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        
                        [alert show];
                    }];
                }
            }
            
            
        }
            break;
        case 400:
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
            [self.navigationController pushViewController:[ViewController new] animated:YES];
            
        }
            break;
        case 600:
        {
            if (buttonIndex == 1) {
                NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.refused_order&order_id=%@",BASEURL,self.order_id];
                [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
                    NSLog(@"res   %@",responseObject);
                    if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
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
        }
            break;
            
        default:
            break;
    }
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
}
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static ingamendViewController* viewController;
    
    dispatch_once(&onceToken, ^{
        viewController = [[ingamendViewController alloc] init];
    });
    
    return viewController;
}

@end
