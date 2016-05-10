//
//  TrainingViewController.m
//  ipad
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "TrainingViewController.h"
#import "Content.h"
#import "Record.h"
#import "Check.h"
#import "ContentModel.h"
#import "Content_Row_Model.h"

@interface TrainingViewController ()
{
    CGFloat lineLeftWidth;
    UILabel *line;
    
    UIImageView *sanjiaoImageView;
    Content *contentView;
    Record  *recordView;
    Check   *checkView;
    
    UILabel *coachLabel;
    UILabel *checkCoachLabel;
    NSMutableArray *content_sctionArray;
}


@end

@implementation TrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  配置self.view的属性
     */
    self.view.frame           = CGRectMake(0,
                                           0,
                                           viewWidth-(viewHeight - 64) / 4,
                                           viewHeight-64);
    self.view.backgroundColor = [UIColor whiteColor];
    
    lineLeftWidth = (viewHeight - 64) / 4;
    [self createUI];
    
}

- (void)createUI {
    self.requestArray = [NSArray array];
    self.requestArray = @[@"培训内容",@"培训记录",@"考核记录"];
    
    // 分割线
    line = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftWidth,
                                                              0,
                                                              1,
                                                              viewHeight - 64)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    UIColor *colorA = [UIColor colorWithRed:237/255.0
                                      green:144/255.0
                                       blue:147/255.0
                                      alpha:1];
    UIColor *colorB = [UIColor colorWithRed:112/255.0
                                      green:199/255.0
                                       blue:243/255.0
                                      alpha:1];
    UIColor *colorC = [UIColor colorWithRed:158/255.0
                                      green:127/255.0
                                       blue:180/255.0
                                      alpha:1];
    
    NSArray *colorArray = @[colorA,colorB,colorC];
    
    
    
    for (int a = 0; a < self.requestArray.count; a++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame     = CGRectMake(0, a*80, lineLeftWidth, 80);
        button.tag       = a + 1;
        button.backgroundColor = colorArray[a];
        button.titleLabel.font = [UIFont fontWithName:FONT size:22];
        [button setTintColor:[UIColor whiteColor]];
        [button setTitle:self.requestArray[a] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // 小三角
        sanjiaoImageView       = [[UIImageView alloc] init];
        sanjiaoImageView.image = [UIImage imageNamed:@"sanjiao"];
        
        [self.view addSubview:sanjiaoImageView];
        
        if (a == 1) {
            coachLabel               = [UILabel new];
            coachLabel.textColor     = [UIColor whiteColor];
            coachLabel.textAlignment = 1;
            coachLabel.font          = [UIFont fontWithName:FONT size:16];
            coachLabel.frame         = CGRectMake(0, 60, lineLeftWidth, 20);
            //coachLabel.text          = @"所有教练";
            [button addSubview:coachLabel];
        }
        if (a == 2) {
            checkCoachLabel               = [UILabel new];
            checkCoachLabel.textColor     = [UIColor whiteColor];
            checkCoachLabel.textAlignment = 1;
            checkCoachLabel.font          = [UIFont fontWithName:FONT size:16];
            checkCoachLabel.frame         = CGRectMake(0, 60, lineLeftWidth, 20);
            //coachLabel.text          = @"所有教练";
            [button addSubview:checkCoachLabel];
        }
    }
    
    /**
     *  设置三角的初始位置
     */
    sanjiaoImageView.frame = CGRectMake(lineLeftWidth - 18.2,
                                        39.2 / 2,
                                        19.2,
                                        39.2);
    /**
     *  初始化三个View
     */
    
    CGFloat view_Width        = self.view.bounds.size.width - lineLeftWidth;
    CGRect viewFrame          = CGRectMake(CGRectGetMaxX(line.frame),
                                           0,
                                           view_Width,
                                           self.view.bounds.size.height);
    contentView = [[Content alloc] initWithFrame:viewFrame ];
    [self.view addSubview:contentView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultCoachName:) name:@"coachName" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCoachName:) name:@"checkCoachName" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trainClass:) name:@"trainClass" object:nil];
  
  
}

#pragma mark - 按钮点击事件
- (void)buttonClick:(UIButton *)button {
    
    /**
     *  改变三角的位置
     */
    int sanjiaoHeight      = CGRectGetMinY(button.frame) + 39.2 / 2;
    sanjiaoImageView.frame = CGRectMake(lineLeftWidth - 18.2,sanjiaoHeight, 19.2, 39.2);
    
    //添加视图前移除所有视图
    [contentView removeFromSuperview];
    [recordView  removeFromSuperview];
    [checkView   removeFromSuperview];
    
    CGFloat view_Width        = self.view.bounds.size.width - lineLeftWidth;
    CGRect viewFrame          = CGRectMake(CGRectGetMaxX(line.frame),
                                           0,
                                           view_Width,
                                           self.view.bounds.size.height);
    
    switch (button.tag) {
        case 1: {
            // 内容
            
            contentView = [[Content alloc] initWithFrame:viewFrame];
            [self.view addSubview:contentView];
        }
            
            
            
            break;
        case 2: {
            // 记录
            sanjiaoImageView.frame = CGRectMake(lineLeftWidth ,sanjiaoHeight, 19.2, 39.2);
            CGFloat originY = (button.tag - 1) * 80;
            recordView = [[Record alloc] initWithFrame:viewFrame AllCoachOrigin_Y:originY trainClassArray:content_sctionArray];
            [self.view addSubview:recordView];
            
            
        }
            
            break;
        case 3: {
            // 考核
            sanjiaoImageView.frame = CGRectMake(lineLeftWidth ,sanjiaoHeight, 19.2, 39.2);
            CGFloat originY = (button.tag - 1) * 80;
            checkView = [[Check alloc] initWithFrame:viewFrame AllCoachOrigin_Y:originY trainClassArray:content_sctionArray];
            [self.view addSubview:checkView];
        }
            
            break;
            
        default:
            break;
    }
    
}
- (void)trainClass:(NSNotification *)notification {
    content_sctionArray = [NSMutableArray array];
    content_sctionArray = notification.userInfo[@"trainClass"];
}
#pragma mark - 接收通知 显示教练名字
- (void)resultCoachName:(NSNotification *)notification {
    
   coachLabel.text = [notification.userInfo objectForKey:@"coachName"];
}
- (void)checkCoachName:(NSNotification *)notification {
    
    checkCoachLabel.text = [notification.userInfo objectForKey:@"coachName"];
}
#pragma mark - 单例
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static TrainingViewController* trainView;
    
    dispatch_once(&onceToken, ^{
        trainView = [[TrainingViewController alloc] init];
    });
    
    return trainView;
}


@end
