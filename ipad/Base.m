//
//  Base.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "Base.h"
#import "QuesModel.h"
#import "questionnaireVC.h"
//用户的基本信息数据
@implementation Base
{
    NSDictionary *baseDict;
    //  NSDictionary *quesDict;
    NSString *titleString;
    UIView *changeNumber;
    UIView *weightChange;
    UITextField *name;
}
-(instancetype)initWithFrame:(CGRect)frame baseDict:(NSDictionary *)dict title:(NSString *)title {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        NSLog(@"base %@",dict);
        baseDict = dict;
        titleString = title;
        [self createUIwithQuesttionDict:[dict objectForKey:@"ques"]];
       
        
    }
    return self;
}
-(void)createUIwithQuesttionDict:(NSDictionary *)questiongDict
{
    UILabel *topTitleLabel = [HttpTool labelWithFrame:CGRectMake(13, 5, viewWidth - 26, 80) title:titleString];
    topTitleLabel.numberOfLines = 0;
    topTitleLabel.font = [UIFont fontWithName: FONT size:32];
    [self addSubview:topTitleLabel];
    
    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, CGRectGetMaxY(topTitleLabel.frame)+20, viewWidth, 30) title:[baseDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //名字、性别
    for (int a = 1; a < 3; a++) {
        UIView *view = [HttpTool wenViewWithFrame:CGRectMake(140+(a-1)*390, CGRectGetMaxY(titleLabel.frame)+20, 80, 30) textFieldWidth:250 questionDict:questiongDict numberWithKey:[NSString stringWithFormat:@"%d",a]];
        [self addSubview:view];
    }
    //生日、电话
    for (int a = 3; a < 5; a++) {
        
        UILabel *label = [HttpTool labelWithFrame:CGRectMake(140+(a-3)*390, CGRectGetMaxY(titleLabel.frame)+20 + 45, 80, 30) title:[HttpTool wenQuestionNameWithDict:questiongDict key:[NSString stringWithFormat:@"%d",a]]];
        [self addSubview:label];
        
        UIImageView *underLine = [HttpTool underLineWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(label.frame), 250, .5)];
        [self addSubview:underLine];
        
        UITextField *textField = [HttpTool textFieldWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), underLine.bounds.size.width, label.bounds.size.height) tag:a];
        if (a == 3) {
            if (![[[questiongDict objectForKey:[NSString stringWithFormat:@"%d",a]] objectForKey:@"answer"] count] > 0) {
                textField.text = @"";
            }else{
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YYYY-MM-dd"];
                NSString *time = [[questiongDict objectForKey:[NSString stringWithFormat:@"%d",a]] objectForKey:@"answer"][0];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
                NSLog(@"生日");
                textField.text = [formatter stringFromDate:confromTimesp];
            }
           
        }else{
            if (![[[questiongDict objectForKey:[NSString stringWithFormat:@"%d",a]] objectForKey:@"answer"] count] > 0) {
                textField.text = @"";
            }else{
            textField.text = [[questiongDict objectForKey:[NSString stringWithFormat:@"%d",a]] objectForKey:@"answer"][0];
            }
        }
        [self addSubview:textField];
    }
    //运动目标
    UIView *sportPurpose = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame)+20 +45+45, 200, 30) textFieldWidth:610 questionDict:questiongDict numberWithKey:@"5"];
    [self addSubview:sportPurpose];
    //多少时间增加减少多少
    for (int a = 6; a < 8; a++) {
        UIView *view = [HttpTool wenViewWithFrame:CGRectMake(50+(a-6)*405, CGRectGetMaxY(sportPurpose.frame)+15, 150, 30) textFieldWidth:255 questionDict:questiongDict numberWithKey:[NSString stringWithFormat:@"%d",a]];
        [self addSubview:view];
    }
    //体重大幅度变化
    weightChange = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(sportPurpose.frame)+15 + 45, 500, 27) quesDict:questiongDict numberWithKey:@"8"];
    [self addSubview:weightChange];
    
   
    //体重有大幅度变化，变化了多少
    changeNumber = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(weightChange.frame) + 15, 200, 27) textFieldWidth:610 questionDict:questiongDict numberWithKey:@"9"];
    if ([(QCheckBox *)[self viewWithTag:80] checked]) {
        [self addSubview:changeNumber];
    }

    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(changeNumber.frame) + 20;
    self.frame = newFrame;
}
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    if (checkbox.tag == 80){
        if (checked) {
            [self addSubview:changeNumber];
            [(QCheckBox *)[self viewWithTag:81] setChecked:NO];
            self.weightCheck = [NSArray arrayWithObject:@"1"];
            
        }
        else{
            [changeNumber removeFromSuperview];
            self.weightCheck = [NSArray arrayWithObject:@"0"];
        }
    }
    if (checkbox.tag == 81){
        if (checked) {
            [(QCheckBox *)[self viewWithTag:80] setChecked:NO];
            [changeNumber removeFromSuperview];
            self.weightCheck = [NSArray arrayWithObject:@"2"];
        }
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
    
//    //选择答案数组取值
//    if (![[[quesDict objectForKey:key] objectForKey:@"answer"] count] > 0) {
//        NSLog(@"初始化数组");
//        answerArray = [[NSArray alloc] initWithObjects:@"0", nil];
//    }else{
//        NSLog(@"数组取值");
//        answerArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:key] objectForKey:@"answer"][0], nil];
//    }
//    NSLog(@"self.weight %@",self.weightCheck);
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
        self.weightCheck =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:key] objectForKey:@"answer"][0], nil];
    }else{
         self.weightCheck = [NSArray arrayWithObject:@"0"];
    }
    //  NSLog(@"答案 %d",answer);
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