//
//  Yoga.m
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "Yoga.h"

@implementation Yoga
{
    NSDictionary *yogaDict;
    UIView *howLong;
    UIView *whatStyle;
}

-(instancetype)initWithFrame:(CGRect)frame yogaDict:(NSDictionary *)dict {
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.frame = frame;
        yogaDict = dict;
    
        [self createUIWithQuestionDict:[dict objectForKey:@"ques"]];
    }
 
    return self;
    
}
-(void)createUIWithQuestionDict:(NSDictionary *)quesDict
{
    UILabel * titleLabel = [HttpTool labelWithFrame:CGRectMake(0, 0, viewWidth, 30) title:[yogaDict objectForKey:@"name"]];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName: FONT size:30];
    [self addSubview:titleLabel];
    
    //是否接触过瑜伽
    UIView *touchYoga = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(titleLabel.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"34"];
    [self addSubview:touchYoga];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"34"] objectForKey:@"answer"] count] > 0) {
        self.touchYogaArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.touchYogaArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"34"] objectForKey:@"answer"][0], nil];
    }
    
    //习练多久
    howLong = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(touchYoga.frame) + 15, 200, 27) textFieldWidth:580 questionDict:quesDict numberWithKey:@"46"];
    
    
    //什么流派
    whatStyle = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(howLong.frame) + 15, 200, 27)  textFieldWidth:580 questionDict:quesDict numberWithKey:@"47"];
    
    //是否显示备注
    if ([(QCheckBox *)[self viewWithTag:340] checked]) {
        [self addSubview:howLong];
        [self addSubview:whatStyle];
    }
    //喜欢的瑜伽类型
    UIView *likeStyle = [HttpTool wenViewWithFrame:CGRectMake(50, CGRectGetMaxY(whatStyle.frame) + 15, 330, 27) textFieldWidth:450 questionDict:quesDict numberWithKey:@"35"];
    [self addSubview:likeStyle];
    
    //关节如何
    UIView *joint = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(likeStyle.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"36"];
    [self addSubview:joint];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"36"] objectForKey:@"answer"] count] > 0) {
        self.jointArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.jointArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"36"] objectForKey:@"answer"][0], nil];
    }
    
    //目的
    UIView *purpose = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(joint.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"37"];
    [self addSubview:purpose];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"37"] objectForKey:@"answer"] count] > 0) {
        self.purposeArray = [[NSMutableArray alloc] initWithCapacity:0];
    }else{
        self.purposeArray = [[[quesDict objectForKey:@"37"] objectForKey:@"answer"] mutableCopy];
    }
    
    //耐力
    UIView *endurance = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(purpose.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"38"];
    [self addSubview:endurance];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"38"] objectForKey:@"answer"] count] > 0) {
        self.enduranceArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.enduranceArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"38"] objectForKey:@"answer"][0], nil];
    }
    
    //对温度的适应力
    UIView *temperature = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(endurance.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"39"];
    [self addSubview:temperature];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"39"] objectForKey:@"answer"] count] > 0) {
        self.temperatureArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.temperatureArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"39"] objectForKey:@"answer"][0], nil];
    }
    
    //喜欢什么时候练
    UIView *whatTime = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(temperature.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"40"];
    [self addSubview:whatTime];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"40"] objectForKey:@"answer"] count] > 0) {
        self.whatTimeArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.whatTimeArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"40"] objectForKey:@"answer"][0], nil];
    }
    
    //每周练习次数
    UIView *times = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(whatTime.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"41"];
    [self addSubview:times];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"41"] objectForKey:@"answer"] count] > 0) {
        self.timesArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.timesArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"41"] objectForKey:@"answer"][0], nil];
    }
    
    //消化能力
    UIView *digestion = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(times.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"42"];
    [self addSubview:digestion];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"42"] objectForKey:@"answer"] count] > 0) {
        self.digestionArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.digestionArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"42"] objectForKey:@"answer"][0], nil];
    }
    
    //是否易被影响
    UIView *affect = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(digestion.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"43"];
    [self addSubview:affect];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"43"] objectForKey:@"answer"] count] > 0) {
        self.affectArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.affectArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"43"] objectForKey:@"answer"][0], nil];
    }
    
    //记忆力
    UIView *memory = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(affect.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"44"];
    [self addSubview:memory];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"44"] objectForKey:@"answer"] count] > 0) {
        self.memoryArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.memoryArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"44"] objectForKey:@"answer"][0], nil];
    }
    
    //身体循环怎么样
    UIView *circulation = [self xuanViewWithFrame:CGRectMake(50, CGRectGetMaxY(memory.frame) + 15, 800, 27) quesDict:quesDict numberWithKey:@"45"];
    [self addSubview:circulation];
    //选择答案数组取值
    if (![[[quesDict objectForKey:@"45"] objectForKey:@"answer"] count] > 0) {
        self.circulationArray = [[NSArray alloc] initWithObjects:@"0", nil];
    }else{
        self.circulationArray =[[NSArray alloc] initWithObjects:[[quesDict objectForKey:@"45"] objectForKey:@"answer"][0], nil];
    }
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetMaxY(circulation.frame) + 20;
    self.frame = newFrame;
    
}
-(void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    switch (checkbox.tag) {
        case 340:
            if (checked) {
                [self addSubview:howLong];
                [self addSubview:whatStyle];
                [(QCheckBox *)[self viewWithTag:341] setChecked:NO];
                self.touchYogaArray = [NSArray arrayWithObject:@"1"];
            } else {
                [howLong removeFromSuperview];
                [whatStyle removeFromSuperview];
                self.touchYogaArray = [NSArray arrayWithObject:@"0"];
            }
            
            break;
        case 341:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:340] setChecked:NO];
                [howLong removeFromSuperview];
                [whatStyle removeFromSuperview];
                self.touchYogaArray = [NSArray arrayWithObject:@"2"];
            }else self.touchYogaArray = [NSArray arrayWithObject:@"0"];
            break;
        case 360:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:361] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:362] setChecked:NO];
                self.jointArray = [NSArray arrayWithObject:@"1"];
            }else self.jointArray = [NSArray arrayWithObject:@"0"];
            break;
        case 361:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:360] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:362] setChecked:NO];
                self.jointArray = [NSArray arrayWithObject:@"2"];
            }else self.jointArray = [NSArray arrayWithObject:@"0"];
            break;
        case 362:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:361] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:360] setChecked:NO];
                self.jointArray = [NSArray arrayWithObject:@"3"];
            }else self.jointArray = [NSArray arrayWithObject:@"0"];
            break;
        case 370:
            checked ? [self.purposeArray addObject:@"1"] : [self.purposeArray removeObject:@"1"];
            break;
        case 371:
            checked ? [self.purposeArray addObject:@"2"] : [self.purposeArray removeObject:@"2"];
            break;
        case 372:
            checked ? [self.purposeArray addObject:@"3"] : [self.purposeArray removeObject:@"3"];
            break;
        case 373:
            checked ? [self.purposeArray addObject:@"4"] : [self.purposeArray removeObject:@"4"];
            break;
        case 374:
            checked ? [self.purposeArray addObject:@"5"] : [self.purposeArray removeObject:@"5"];
            break;
        case 375:
            checked ? [self.purposeArray addObject:@"6"] : [self.purposeArray removeObject:@"6"];
            break;
        case 376:
            checked ? [self.purposeArray addObject:@"7"] : [self.purposeArray removeObject:@"7"];
            break;
        case 380:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:381] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:382] setChecked:NO];
                self.enduranceArray = [NSArray arrayWithObject:@"1"];
            }else self.enduranceArray = [NSArray arrayWithObject:@"0"];
            break;
        case 381:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:380] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:382] setChecked:NO];
                self.enduranceArray = [NSArray arrayWithObject:@"2"];
            }else self.enduranceArray = [NSArray arrayWithObject:@"0"];
            break;
        case 382:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:381] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:380] setChecked:NO];
                  self.enduranceArray = [NSArray arrayWithObject:@"3"];
            }else self.enduranceArray = [NSArray arrayWithObject:@"0"];
            break;
        case 390:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:391] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:392] setChecked:NO];
                self.temperatureArray = [NSArray arrayWithObject:@"1"];
            }else self.temperatureArray = [NSArray arrayWithObject:@"0"];
            break;
        case 391:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:390] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:392] setChecked:NO];
                self.temperatureArray = [NSArray arrayWithObject:@"2"];
            }else self.temperatureArray = [NSArray arrayWithObject:@"0"];
            break;
        case 392:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:391] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:390] setChecked:NO];
                self.temperatureArray = [NSArray arrayWithObject:@"3"];
            }else self.temperatureArray = [NSArray arrayWithObject:@"0"];
            break;
        case 400:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:401] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:402] setChecked:NO];
                self.whatTimeArray = [NSArray arrayWithObject:@"1"];
            }else self.whatTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 401:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:400] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:402] setChecked:NO];
                self.whatTimeArray = [NSArray arrayWithObject:@"2"];
            }else self.whatTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 402:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:401] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:400] setChecked:NO];
                self.whatTimeArray = [NSArray arrayWithObject:@"3"];
            }else self.whatTimeArray = [NSArray arrayWithObject:@"0"];
            break;
        case 410:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:411] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:412] setChecked:NO];
                self.timesArray = [NSArray arrayWithObject:@"1"];
            }else self.timesArray = [NSArray arrayWithObject:@"0"];
            break;
        case 411:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:410] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:412] setChecked:NO];
                self.timesArray = [NSArray arrayWithObject:@"2"];
            }else self.timesArray = [NSArray arrayWithObject:@"0"];
            break;
        case 412:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:411] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:410] setChecked:NO];
                self.timesArray = [NSArray arrayWithObject:@"3"];
            }else self.timesArray = [NSArray arrayWithObject:@"0"];
            break;
        case 420:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:421] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:422] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:423] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:424] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:425] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"1"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 421:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:420] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:422] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:423] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:424] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:425] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"2"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 422:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:420] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:421] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:423] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:424] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:425] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"3"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 423:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:420] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:421] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:422] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:424] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:425] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"4"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 424:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:420] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:421] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:422] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:423] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:425] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"5"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 425:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:420] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:421] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:422] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:423] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:424] setChecked:NO];
                self.digestionArray = [NSArray arrayWithObject:@"6"];
            }else self.digestionArray = [NSArray arrayWithObject:@"0"];
            break;
        case 430:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:431] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:432] setChecked:NO];
                self.affectArray = [NSArray arrayWithObject:@"1"];
            }else self.affectArray = [NSArray arrayWithObject:@"0"];
            break;
        case 431:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:430] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:432] setChecked:NO];
                self.affectArray = [NSArray arrayWithObject:@"2"];
            }else self.affectArray = [NSArray arrayWithObject:@"0"];
            break;
        case 432:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:431] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:430] setChecked:NO];
                self.affectArray = [NSArray arrayWithObject:@"3"];
            }else self.affectArray = [NSArray arrayWithObject:@"0"];
            break;
        case 440:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:441] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:442] setChecked:NO];
                self.memoryArray = [NSArray arrayWithObject:@"1"];
            }else self.memoryArray = [NSArray arrayWithObject:@"0"];
            break;
        case 441:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:440] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:442] setChecked:NO];
                self.memoryArray = [NSArray arrayWithObject:@"2"];
            }else self.memoryArray = [NSArray arrayWithObject:@"0"];
            break;
        case 442:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:441] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:440] setChecked:NO];
                self.memoryArray = [NSArray arrayWithObject:@"3"];
            }else self.memoryArray = [NSArray arrayWithObject:@"0"];
            break;
        case 450:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:451] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:452] setChecked:NO];
                self.circulationArray = [NSArray arrayWithObject:@"1"];
            }else self.circulationArray = [NSArray arrayWithObject:@"0"];
            break;
        case 451:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:450] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:452] setChecked:NO];
                self.circulationArray = [NSArray arrayWithObject:@"2"];
            }else self.circulationArray = [NSArray arrayWithObject:@"0"];
            break;
        case 452:
            if (checked) {
                [(QCheckBox *)[self viewWithTag:451] setChecked:NO];
                [(QCheckBox *)[self viewWithTag:450] setChecked:NO];
                self.circulationArray = [NSArray arrayWithObject:@"3"];
            }else self.circulationArray = [NSArray arrayWithObject:@"0"];
            break;
            
            
            
        default:
            break;
    }
    NSLog(@"self.purposeArray %@",self.purposeArray);
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
        NSLog(@"key %@   answer %d  a  %d",key,answer,(a-999));
         //遍历多选题
        if ([[[quesDict objectForKey:key] objectForKey:@"answer"] count] > 1) {
             //answer = [[[quesDict objectForKey:key] objectForKey:@"answer"][0] intValue];
            for (NSString *answer in [[quesDict objectForKey:key] objectForKey:@"answer"]) {
                if ((a - 1000 + 1) == [answer intValue]) {
                    [check setChecked:YES];
                }
            }
        }else{
            if ((a - 1000 + 1) == answer) {
                [check setChecked:YES];
            }
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
