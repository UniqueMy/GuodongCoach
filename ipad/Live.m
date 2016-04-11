//
//  Live.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "Live.h"

@implementation Live
{
    NSDictionary *liveDict;
    UIView *remark;
    UIView *smokeNumber;
    UIView *drinkNumber;
}
-(instancetype)initWithFrame:(CGRect)frame liveDict:(NSDictionary *)dict {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        liveDict = dict;
         NSLog(@"live %@",dict);
        [self createUIWithQuestionDict:[dict objectForKey:@"ques"]];

    }
    return self;
}
-(void)createUIWithQuestionDict:(NSDictionary *)questionDict
{
    

    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, 0, viewWidth, 30) title:[liveDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //睡眠状况
    UIView *sleepStatus = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame) + 20, 800, 27) quesDict:questionDict numberWithKey:@"11"];
    [self addSubview:sleepStatus];
    //选择答案数组取值
    if (![[[questionDict objectForKey:@"11"] objectForKey:@"answer"] count] > 0) {
        self.sleepStatusArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.sleepStatusArray =[[NSArray alloc] initWithObjects:[[questionDict objectForKey:@"11"] objectForKey:@"answer"][0], nil];
    }
    //备注
    remark = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(sleepStatus.frame) + 15, 80, 27) textFieldWidth:700 questionDict:questionDict numberWithKey:@"51"];
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:113] checked]) {
        [self addSubview:remark];
    }
    //是否吸烟
    UIView *smoke = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(remark.frame) + 15, 500, 27) quesDict:questionDict numberWithKey:@"10"];
    [self addSubview:smoke];
    //选择答案数组取值
    if (![[[questionDict objectForKey:@"10"] objectForKey:@"answer"] count] > 0) {
        self.smokeArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.smokeArray =[[NSArray alloc] initWithObjects:[[questionDict objectForKey:@"10"] objectForKey:@"answer"][0], nil];
    }
    //吸烟数量
    smokeNumber = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(smoke.frame) + 15, 500, 27) quesDict:questionDict numberWithKey:@"12"];
    //选择答案数组取值
    if (![[[questionDict objectForKey:@"12"] objectForKey:@"answer"] count] > 0) {
        self.smokeNumberArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.smokeNumberArray =[[NSArray alloc] initWithObjects:[[questionDict objectForKey:@"12"] objectForKey:@"answer"][0], nil];
    }
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:100] checked]) {
        [self addSubview:smokeNumber];
    }
    //是否饮酒
    UIView *drink = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(smokeNumber.frame) + 15, 500, 27) quesDict:questionDict numberWithKey:@"13"];
    [self addSubview:drink];
    //选择答案数组取值
    if (![[[questionDict objectForKey:@"13"] objectForKey:@"answer"] count] > 0) {
        self.drinkArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.drinkArray =[[NSArray alloc] initWithObjects:[[questionDict objectForKey:@"13"] objectForKey:@"answer"][0], nil];
    }
    //饮酒数量
    drinkNumber = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(drink.frame) + 15, 500, 27) quesDict:questionDict numberWithKey:@"14"];
    //选择答案数组取值
    if (![[[questionDict objectForKey:@"14"] objectForKey:@"answer"] count] > 0) {
        self.drinkNumberArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.drinkNumberArray =[[NSArray alloc] initWithObjects:[[questionDict objectForKey:@"14"] objectForKey:@"answer"][0], nil];
    }
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:130] checked]) {
        [self addSubview:drinkNumber];
    }
    //工作性质
    UIView *workStyle = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(drinkNumber.frame) + 15, 180, 27) textFieldWidth:600 questionDict:questionDict numberWithKey:@"15"];
    [self addSubview:workStyle];
    
    //工作压力
    UIView *workPressure = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(workStyle.frame) + 15, 180, 27) textFieldWidth:600 questionDict:questionDict numberWithKey:@"16"];
    [self addSubview:workPressure];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(workPressure.frame) + 20;
    self.frame = newFrame;
}
-(void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    switch (checkbox.tag) {
        case 100:
            if (checked) {
                [self addSubview:smokeNumber];
                [(QCheckBox *)[self viewWithTag:101] setChecked:NO];
                self.smokeArray = [NSArray arrayWithObject:@"1"];
            }else{
                [smokeNumber removeFromSuperview];
                self.smokeArray = [NSArray arrayWithObject:@"0"];
            }
            break;
        case 101:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:100] setChecked:NO];
                [smokeNumber removeFromSuperview];
                  self.smokeArray = [NSArray arrayWithObject:@"2"];
            }else self.smokeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 110:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:111] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:112] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:113] setChecked:NO];
                [remark removeFromSuperview];
                  self.sleepStatusArray = [NSArray arrayWithObject:@"1"];
            }else self.sleepStatusArray = [NSArray arrayWithObject:@"0"];
            break;
        case 111:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:110] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:112] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:113] setChecked:NO];
                [remark removeFromSuperview];
                  self.sleepStatusArray = [NSArray arrayWithObject:@"2"];
            }else self.sleepStatusArray = [NSArray arrayWithObject:@"0"];
            break;
        case 112:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:111] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:110] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:113] setChecked:NO];
                [remark removeFromSuperview];
                  self.sleepStatusArray = [NSArray arrayWithObject:@"3"];
            }else self.sleepStatusArray = [NSArray arrayWithObject:@"0"];
            break;
        case 113:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:111] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:112] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:110] setChecked:NO];
                [self addSubview:remark];
                  self.sleepStatusArray = [NSArray arrayWithObject:@"4"];
            }else{
                  [remark removeFromSuperview];
                  self.sleepStatusArray = [NSArray arrayWithObject:@"4"];
            }
            break;
        case 120:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:121] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:122] setChecked:NO];
                  self.smokeNumberArray = [NSArray arrayWithObject:@"1"];
            }else self.smokeNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 121:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:120] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:122] setChecked:NO];
                  self.smokeNumberArray = [NSArray arrayWithObject:@"2"];
            }else self.smokeNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 122:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:121] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:120] setChecked:NO];
                  self.smokeNumberArray = [NSArray arrayWithObject:@"3"];
            }else self.smokeNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 130:
            if (checked) {
                [self addSubview:drinkNumber];
                [(QCheckBox *)[self viewWithTag:131] setChecked:NO];
                self.drinkArray = [NSArray arrayWithObject:@"1"];
            }
            else{
                [drinkNumber removeFromSuperview];
                self.drinkArray = [NSArray arrayWithObject:@"0"];
            }
            break;
        case 131:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:130] setChecked:NO];
                [drinkNumber removeFromSuperview];
                  self.drinkArray = [NSArray arrayWithObject:@"2"];
            }else self.drinkArray = [NSArray arrayWithObject:@"0"];
            break;
        case 140:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:141] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:142] setChecked:NO];
                  self.drinkNumberArray = [NSArray arrayWithObject:@"1"];
            }else self.drinkNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 141:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:140] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:142] setChecked:NO];
                  self.drinkNumberArray = [NSArray arrayWithObject:@"2"];
            }else self.drinkNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 142:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:141] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:140] setChecked:NO];
                  self.drinkNumberArray = [NSArray arrayWithObject:@"3"];
            }else self.drinkNumberArray = [NSArray arrayWithObject:@"0"];
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
    //  NSLog(@"答案 %d",answer);
    for (int a = 1000; a < 1000 + options.count; a++) {
        
        
        QCheckBox *check = [[QCheckBox alloc] initWithDelegate:self];
        check.tag = [[NSString stringWithFormat:@"%d%d",buttonNumber,(a - 1000)] intValue];
        [check setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [check setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [check.titleLabel setFont:[UIFont fontWithName:FONT size:27]];
        [check setTitle:options[a - 1000] forState:UIControlStateNormal];
        // NSLog(@"key %@  奇数 answer %d  a  %d",key,answer,(a-999));
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
