//
//  practiceView.m
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "practiceView.h"
#import "dingdanCell.h"
#import "newamendViewController.h"
#import "AppDelegate.h"
#import "PlanComment.h"
#import "PracticeComment.h"
#import "PlanButton.h"
#import "contentComment.h"
@implementation practiceView

{
    int viewheight;
    int viewweight;
    PlanButton *Planbutton;
   
    UIScrollView *levelSCView;
    UIScrollView *contentView;
    UIImageView *sanjiaoImageView ;
    UIImageView *sanjiaoImageView1 ;
    UIScrollView *scrollView;
    UIScrollView *planScrollView;
    CGSize stringSize;
}
- (id)init
{
    self = [super init];
    if (self) {
       // viewheight = self.view.frame.size.height-64;
       // viewweight = self.view.frame.size.width;
        self.view.frame =CGRectMake(0, 0, viewWidth-viewheight/4, viewHeight - 64 - 20);
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
  
    self.view.backgroundColor =[UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
   
    self.view.userInteractionEnabled = YES;
    
   
    NSLog(@"self.request %@",self.request);
    
    planScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(390, 0, 458, viewHeight - 64 - 20)];
    planScrollView.backgroundColor = [UIColor clearColor];
    planScrollView.showsVerticalScrollIndicator = NO;
   
    [self.view addSubview:planScrollView];
    
    
   
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 360,viewHeight - 64 - 20)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.my_training",BASEURL];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
       
        
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            
            
            self.request  =[[NSMutableArray alloc] initWithCapacity:0];
            self.planArray  =[[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in dataArray)
            {
                PracticeComment *search = [[PracticeComment alloc] initWithDictionary:dict];
                [self.request addObject:search];
            }
            
            
            for (int i = 0; i < self.request.count; i++)
            {
                
                PracticeComment *practice = [self.request objectAtIndex:i];
                self.forbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.forbutton.tag = 1 +i;
                self.forbutton.frame = CGRectMake(20, 0+85*i, 360, 80);
                [self.forbutton setTitle:practice.train_type forState:UIControlStateNormal];
                [self.forbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"wuque%d",i+1]] forState:UIControlStateNormal];
               
               
                self.forbutton.tintColor = [UIColor whiteColor];
                [self.forbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                self.forbutton.titleLabel.font = [UIFont fontWithName:FONT size:30];
                
                sanjiaoImageView = [[UIImageView alloc] init];
                sanjiaoImageView.image = [UIImage imageNamed:@"xiaosanjiao"];
               
                
                if (i > 5) {
                    [self.forbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"wuque%d",i-5]] forState:UIControlStateNormal];
                }
                scrollView.contentSize = CGSizeMake(360, (self.request.count + 1) * self.forbutton.frame.size.height);
                [scrollView addSubview:self.forbutton];
                [scrollView addSubview:sanjiaoImageView];
            }
            
            UIButton *button = (UIButton *)[self.view viewWithTag:1];
            sanjiaoImageView.frame = CGRectMake(320, CGRectGetMinY(button.frame)-(self.request.count*70), 20, 20);
           
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
}
-(void)buttonClick:(UIButton *)button
{
   NSLog(@"点击了按钮111");
    sanjiaoImageView.frame = CGRectMake(340, CGRectGetMinY(button.frame)+30  , 20, 20);
    
    PracticeComment *practice = [self.request objectAtIndex:button.tag-1];
    [self.planArray removeAllObjects];
    [planScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSDictionary *dict in practice.plan)
    {
        PlanComment *plan = [[PlanComment alloc] initWithDictionary:dict];
        [self.planArray addObject:plan];
    }
    
    for (int i = 0; i < self.planArray.count; i++) {
        PlanComment *practice = [self.planArray objectAtIndex:i];
        Planbutton = [PlanButton buttonWithType:UIButtonTypeRoundedRect];
        [Planbutton setTitle:practice.plan_name forState:UIControlStateNormal];
        Planbutton.frame = CGRectMake(0, 0+85*i, planScrollView.bounds.size.width, 80);
        [Planbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"wuque%d",i+1]] forState:UIControlStateNormal];
        Planbutton.ID = practice.ID;
        [Planbutton addTarget:self action:@selector(PlanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        Planbutton.tintColor = [UIColor whiteColor];
        Planbutton.titleLabel.font = [UIFont fontWithName:FONT size:30];
        if (i > 5) {
            [Planbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"wuque%d",i-5]] forState:UIControlStateNormal];
        }
         planScrollView.contentSize = CGSizeMake(458, (self.planArray.count + 1) * Planbutton.frame.size.height);
        [planScrollView addSubview:Planbutton];
    }

    
}
-(void)PlanButtonClick:(PlanButton *)button
{
    NSLog(@"点击了按钮222");
    [scrollView removeFromSuperview];
    [planScrollView removeFromSuperview];
    contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 370, viewHeight-64)];
    contentView.backgroundColor =[UIColor clearColor];
    contentView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:contentView];
    
    
    levelSCView = [[UIScrollView alloc] initWithFrame:CGRectMake(390, 0, 458, viewHeight-64)];
    levelSCView.backgroundColor = [UIColor grayColor];
    levelSCView.showsVerticalScrollIndicator = NO;
    
 
    __block practiceView *practiceView = self;
    self.block = ^(int height){
         practiceView->levelSCView.contentSize = CGSizeMake(458, height+100);
    };
    [self.view addSubview:levelSCView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(750, 0, 100, 40);
    [self.view addSubview:backButton];
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.training&plan_id=%@",BASEURL,button.ID];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res  %@",responseObject);
        
         NSArray *dataArray = [responseObject objectForKey:@"data"];
        self.contentArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dict in dataArray) {
            contentComment *content = [[contentComment alloc] initWithDictionary:dict];
            [self.contentArray addObject:content];
        }
        
        for (int a = 0; a < self.contentArray.count; a++) {
            contentComment *content = [self.contentArray objectAtIndex:a];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
           
            CGSize textSize = [content.level_name boundingRectWithSize:CGSizeMake(360, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:27]} context:nil].size;
            button.frame = CGRectMake(20, 0+85*a, 360, 80);
            if (textSize.height > 80) {
                button.frame = CGRectMake(20, 0+85*a, 360, textSize.height);
            }
            [button setTitle:content.level_name forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"wuque%d",a%6 + 1]] forState:UIControlStateNormal];
            button.tag = a+100;
            button.titleLabel.numberOfLines = 0;
            [button addTarget:self action:@selector(contentButton:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont fontWithName:FONT size:27];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          
            sanjiaoImageView1 = [[UIImageView alloc] init];
            sanjiaoImageView1.image = [UIImage imageNamed:@"xiaosanjiao"];
            [contentView addSubview:button];
            [contentView addSubview:sanjiaoImageView1];
            
            contentView.contentSize = CGSizeMake(360, (self.contentArray.count + 1) * button.frame.size.height);
            NSLog(@"conteng高度 %f",(self.contentArray.count + 1) * button.frame.size.height);
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    
}
-(void)contentButton:(UIButton *)button
{
   NSLog(@"点击了按钮333");
    sanjiaoImageView1.frame = CGRectMake(350, CGRectGetMinY(button.frame)+30 , 20, 20);
    
    [levelSCView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    contentComment *content = [self.contentArray objectAtIndex:button.tag-100];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = content.content;
   
     stringSize =  [content.content boundingRectWithSize:CGSizeMake(456, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
  
    self.block(stringSize.height);
    contentLabel.frame = CGRectMake(2, 40, 458, stringSize.height);
    contentLabel.font = [UIFont fontWithName:FONT size:24];
    [levelSCView addSubview:contentLabel];
    
}
-(void)backButton
{
    [contentView removeFromSuperview];
    [levelSCView removeFromSuperview];
    [self.view addSubview:scrollView];
    [self.view addSubview:planScrollView];
}

+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static practiceView* practice;
    
    dispatch_once(&onceToken, ^{
        practice = [[practiceView alloc] init];
    });
    
    return practice;
}

@end
