//
//  Food.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "Food.h"

@implementation Food
{
    NSDictionary *foodDict;
    UIView *remark;
}
-(instancetype)initWithFrame:(CGRect)frame foodDict:(NSDictionary *)dict {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        foodDict = dict;
        [self createUIWithQuestionDict:[dict objectForKey:@"ques"]];
    }
    
    return self;
    
}
-(void)createUIWithQuestionDict:(NSDictionary *)quesDict
{
    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, 0, viewWidth, 30) title:[foodDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //早餐
    UIView *breakfast = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame) + 20, 240, 27) textFieldWidth:540 questionDict:quesDict numberWithKey:@"17"];
    [self addSubview:breakfast];
    
    //午餐
    UIView *lunch = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(breakfast.frame) + 15, 240, 27) textFieldWidth:540 questionDict:quesDict numberWithKey:@"18"];
    [self addSubview:lunch];
    
    //晚餐
    UIView *dinner = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(lunch.frame) + 15, 240, 27) textFieldWidth:540 questionDict:quesDict numberWithKey:@"19"];
    [self addSubview:dinner];
    
    //食物分析
    UIView *foodAnalyze = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(dinner.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"20"];
    [self addSubview:foodAnalyze];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"20"] objectForKey:@"answer"] count] > 0)) {
       self.foodAnalyzeArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.foodAnalyzeArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"20"] objectForKey:@"answer"][0], nil];
    }
     NSLog(@"食物分析 %@",self.foodAnalyzeArray);
    
    //饮食规律
    UIView *lawFood = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(foodAnalyze.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"21"];
    [self addSubview:lawFood];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"21"] objectForKey:@"answer"] count] > 0)) {
        self.lawFoodArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.lawFoodArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"21"] objectForKey:@"answer"][0], nil];
    }
    
    //喜欢吃的零食
    UIView *loveFood = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(lawFood.frame) + 15, 380, 27) textFieldWidth:400 questionDict:quesDict numberWithKey:@"22"];
    [self addSubview:loveFood];
    
    //是否服用运动补剂
    UIView *sportTonic = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(loveFood.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"23"];
    [self addSubview:sportTonic];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"23"] objectForKey:@"answer"] count] > 0)) {
        self.sportTonicArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.sportTonicArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"23"] objectForKey:@"answer"][0], nil];
    }
    
    //备注
    remark = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(sportTonic.frame) + 15, 80, 27) textFieldWidth:700 questionDict:quesDict numberWithKey:@"50"];
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:230] checked]) {
        [self addSubview:remark];
    }
    
    //饮食计划
    UIView *foodPlan = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(remark.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"24"];
    [self addSubview:foodPlan];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"24"] objectForKey:@"answer"] count] > 0)) {
        self.foodPlanArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.foodPlanArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"24"] objectForKey:@"answer"][0], nil];
    }
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(foodPlan.frame) + 20;
    self.frame = newFrame;
    
}
-(void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    switch (checkbox.tag) {
        case 200:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:201] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:202] setChecked:NO];
                  self.foodAnalyzeArray = [NSArray arrayWithObject:@"1"];
            }else self.foodAnalyzeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 201:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:200] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:202] setChecked:NO];
                  self.foodAnalyzeArray = [NSArray arrayWithObject:@"2"];
            }else self.foodAnalyzeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 202:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:201] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:200] setChecked:NO];
                  self.foodAnalyzeArray = [NSArray arrayWithObject:@"3"];
            }else self.foodAnalyzeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 210:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:211] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:212] setChecked:NO];
                  self.lawFoodArray = [NSArray arrayWithObject:@"1"];
            }else self.lawFoodArray = [NSArray arrayWithObject:@"0"];
            break;
        case 211:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:210] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:212] setChecked:NO];
                  self.lawFoodArray = [NSArray arrayWithObject:@"2"];
            }else self.lawFoodArray = [NSArray arrayWithObject:@"0"];
            break;
        case 212:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:211] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:210] setChecked:NO];
                  self.lawFoodArray = [NSArray arrayWithObject:@"3"];
            }else self.lawFoodArray = [NSArray arrayWithObject:@"0"];
            break;
        case 230:
            if (checked) {
                [self addSubview:remark];
                [(QCheckBox *)[self viewWithTag:231] setChecked:NO];
                self.sportTonicArray = [NSArray arrayWithObject:@"1"];
            }
            else{
                [remark removeFromSuperview];
                self.sportTonicArray = [NSArray arrayWithObject:@"0"];
            }
            break;
        case 231:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:230] setChecked:NO];
                [remark removeFromSuperview];
                  self.sportTonicArray = [NSArray arrayWithObject:@"2"];
            }else self.sportTonicArray = [NSArray arrayWithObject:@"0"];
            break;
        case 240:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:241] setChecked:NO];
                  self.foodPlanArray = [NSArray arrayWithObject:@"1"];
            }else self.foodPlanArray = [NSArray arrayWithObject:@"0"];
            break;
        case 241:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:240] setChecked:NO];
                 self.foodPlanArray = [NSArray arrayWithObject:@"2"];
            }else self.foodPlanArray = [NSArray arrayWithObject:@"0"];
            break;
        default:
            break;
    }
}
//健康问卷选择题的设置方法(HttpTool 不进协议方法)
/*
 复选按钮tag计算方法
 数组题序后拼接A(0).B(1).C(2).D(3)
 题序:12  选项:A B C
 Tag:120  121  122
 */
-(UIView *)xuanViewWithFrame:(CGRect)frame quesDict:(NSDictionary *)quesDict numberWithKey:(NSString *)key
{
    NSMutableArray *options = [[NSMutableArray alloc] initWithCapacity:0];
    
   
    //取出装有问题的数组
    options =  [HttpTool xuanQuestionNameWithDict:[quesDict objectForKey:key]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + ((options.count/2) + options.count %2)*43)];
    view.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    label.textColor = [UIColor whiteColor];
    label.text = [HttpTool wenQuestionNameWithDict:quesDict key:key];
    label.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:label];
    
    int buttonNumber = [key intValue];
    int answer = 0;
    if ([[[quesDict objectForKey:key] objectForKey:@"answer"] count] > 0) {
        answer = [[[quesDict objectForKey:key] objectForKey:@"answer"][0] intValue];
    }
    
   // NSLog(@"答案 %d",answer);
    for (int a = 1000; a < 1000 + options.count; a++) {
        
        
        QCheckBox *check = [[QCheckBox alloc] initWithDelegate:self];
        check.tag = [[NSString stringWithFormat:@"%d%d",buttonNumber,(a - 1000)] intValue];
        [check setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [check setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [check.titleLabel setFont:[UIFont fontWithName:FONT size:27]];
        [check setTitle:options[a - 1000] forState:UIControlStateNormal];
      //  NSLog(@"key %@  奇数 answer %d  a  %d",key,answer,(a-999));
        if ((a - 1000 + 1) == answer) {
            [check setChecked:YES];
        }
        [view addSubview:check];
        if (a %2 == 0) {
            check.frame = CGRectMake(0, (CGRectGetMaxY(label.frame)+15) + ((a-1000)/2)*42, frame.size.width/2, 27);
            
        }
        if (a %2 == 1) {
            check.frame = CGRectMake(frame.size.width/2, (CGRectGetMaxY(label.frame)+15) + ((a-1000)/2)*42, frame.size.width/2, 27);
            
        }
    }
    return view;
}

@end
