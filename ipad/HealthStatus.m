//
//  HealthStatus.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "HealthStatus.h"

@implementation HealthStatus
{
    NSDictionary *healthDict;
    UIView *remark;
}
-(instancetype)initWithFrame:(CGRect)frame healthDict:(NSDictionary *)dict {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        healthDict = dict;
        [self createUIWithQuestionDict:[dict objectForKey:@"ques"]];
    }
    
    return self;
    
}
-(void)createUIWithQuestionDict:(NSDictionary *)quesDict
{
    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, 0, viewWidth, 30) title:[healthDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //肩颈的状况
    UIView *Shoulder = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame) + 20, 280, 27) textFieldWidth:500 questionDict:quesDict numberWithKey:@"30"];
    [self addSubview:Shoulder];
    
    //韧带肌肉的状况
    UIView *muscle = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(Shoulder.frame) + 15, 280, 27) textFieldWidth:500 questionDict:quesDict numberWithKey:@"31"];
    [self addSubview:muscle];
    
    //疾病
    UIView *disease = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(muscle.frame) + 15, 600, 27) quesDict:quesDict numberWithKey:@"32"];
    [self addSubview:disease];
    //选择答案数组取值
    if (!([[[quesDict objectForKey:@"32"] objectForKey:@"answer"] count] > 0)) {
        self.diseaseArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.diseaseArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"32"] objectForKey:@"answer"][0], nil];
    }
    
    //备注
    remark = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(disease.frame) + 15, 280, 27) textFieldWidth:500 questionDict:quesDict numberWithKey:@"48"];
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:326] checked]) {
        [self addSubview:remark];
    }
    //过敏史
    UIView *allergy = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(remark.frame) + 15, 280, 27) textFieldWidth:500 questionDict:quesDict numberWithKey:@"33"];
    [self addSubview:allergy];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(allergy.frame) + 20;
    self.frame = newFrame;
    
}
-(void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    switch (checkbox.tag) {
        case 326:
            if (checked) {
                [self addSubview:remark];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                self.diseaseArray = [NSArray arrayWithObject:@"7"];
                
            }else{
                self.diseaseArray = [NSArray arrayWithObject:@"0"];
                [remark removeFromSuperview];
            }
            break;
        case 320:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"1"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 321:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"2"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 322:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"3"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 323:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"4"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 324:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"5"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 325:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:327] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"6"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
        case 327:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:326] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:321] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:322] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:323] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:324] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:325] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:320] setChecked:NO];
                [remark removeFromSuperview];
                  self.diseaseArray = [NSArray arrayWithObject:@"8"];
            }else self.diseaseArray = [NSArray arrayWithObject:@"0"];
            break;
            
        default:
            break;
    }
    NSLog(@"self.diseaseArray %@",self.diseaseArray);
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
