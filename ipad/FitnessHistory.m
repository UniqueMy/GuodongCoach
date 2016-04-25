//
//  FitnessHistory.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "FitnessHistory.h"

@implementation FitnessHistory
{
    NSDictionary *fitnessDict;
    UIView *remark;
}
-(instancetype)initWithFrame:(CGRect)frame fitnessDict:(NSDictionary *)dict {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        fitnessDict = dict;
        [self createUIWithQuestionDict:[dict objectForKey:@"ques"]];
    }
    
    return self;
    
}
-(void)createUIWithQuestionDict:(NSDictionary *)quesDict
{
    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, 0, viewWidth, 30) title:[fitnessDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //1-2年内是否训练
    UIView *professionalSport = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame) + 20, 600, 27) quesDict:quesDict numberWithKey:@"25"];
    [self addSubview:professionalSport];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"25"] objectForKey:@"answer"] count] > 0)) {
        self.professionalSportArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.professionalSportArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"25"] objectForKey:@"answer"][0], nil];
    }
    //备注
    remark = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(professionalSport.frame) + 15, 80, 27) textFieldWidth:700 questionDict:quesDict numberWithKey:@"49"];
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:250] checked]) {
        [self addSubview:remark];
    }
    
    //每周运动几次
    UIView *sportNumber = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(remark.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"26"];
    [self addSubview:sportNumber];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"26"] objectForKey:@"answer"] count] > 0)) {
        self.sportNumberArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.sportNumberArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"26"] objectForKey:@"answer"][0], nil];
    }
    
    //每次运动时间
    UIView *sportTime = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(sportNumber.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"27"];
    [self addSubview:sportTime];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"23"] objectForKey:@"answer"] count] > 0)) {
        self.sportTimeArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.sportTimeArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"23"] objectForKey:@"answer"][0], nil];
    }
    
    //什么时候锻炼
    UIView *whenSport = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(sportTime.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"28"];
    [self addSubview:whenSport];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"28"] objectForKey:@"answer"] count] > 0)) {
        self.whenSportArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.whenSportArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"28"] objectForKey:@"answer"][0], nil];
    }
    
    //什么类型
    UIView *whatStyle = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(whenSport.frame) + 15, 380, 27) textFieldWidth:400 questionDict:quesDict numberWithKey:@"29"];
        [self addSubview:whatStyle];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(whatStyle.frame) + 20;
    self.frame = newFrame;

    
}
-(void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    switch (checkbox.tag) {
        case 250:
            if (checked) {
                [self addSubview:remark];
                [(QCheckBox *)[self viewWithTag:251] setChecked:NO];
                   self.professionalSportArray = [NSArray arrayWithObject:@"1"];
            }else {
                self.professionalSportArray = [NSArray arrayWithObject:@"0"];
                [remark removeFromSuperview];
            }
            break;
        case 251:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:250] setChecked:NO];
                [remark removeFromSuperview];
                  self.professionalSportArray = [NSArray arrayWithObject:@"2"];
            }else self.professionalSportArray = [NSArray arrayWithObject:@"0"];
            break;
        case 260:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:261] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:262] setChecked:NO];
                  self.sportNumberArray = [NSArray arrayWithObject:@"1"];
            }else self.sportNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 261:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:260] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:262] setChecked:NO];
                  self.sportNumberArray = [NSArray arrayWithObject:@"2"];
            }else self.sportNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 262:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:261] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:260] setChecked:NO];
                self.sportNumberArray = [NSArray arrayWithObject:@"3"];
            }else self.sportNumberArray = [NSArray arrayWithObject:@"0"];
            break;
        case 270:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:271] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:272] setChecked:NO];
                self.sportTimeArray = [NSArray arrayWithObject:@"1"];
            }else self.sportTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 271:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:270] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:272] setChecked:NO];
                self.sportTimeArray = [NSArray arrayWithObject:@"2"];
            }else self.sportTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 272:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:271] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:270] setChecked:NO];
                self.sportTimeArray = [NSArray arrayWithObject:@"3"];
            }else self.sportTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 280:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:281] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:282] setChecked:NO];
                self.whenSportArray = [NSArray arrayWithObject:@"1"];
            }else self.whenSportArray = [NSArray arrayWithObject:@"0"];
            break;
        case 281:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:280] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:282] setChecked:NO];
                self.whenSportArray = [NSArray arrayWithObject:@"2"];
            }else self.whenSportArray = [NSArray arrayWithObject:@"0"];
            break;
        case 282:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:281] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:280] setChecked:NO];
                self.whenSportArray = [NSArray arrayWithObject:@"3"];
            }else self.whenSportArray = [NSArray arrayWithObject:@"0"];
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
     //   NSLog(@"key %@  奇数 answer %d  a  %d",key,answer,(a-999));
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
