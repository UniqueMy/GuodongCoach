//
//  questionnaireVC.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "questionnaireVC.h"
#import "Base.h"
#import "Live.h"
#import "Food.h"
#import "FitnessHistory.h"
#import "HealthStatus.h"
#import "Yoga.h"
@implementation questionnaireVC
{
    
    Base *base;
    Live *live;
    Food *food;
    Yoga *yoga;
    NSDictionary *baseDict;
    NSDictionary *liveDict;
    NSDictionary *foodDict;
    NSDictionary *fitnessDict;
    NSDictionary *healthDict;
    NSDictionary *yogaDict;
    FitnessHistory *fitness;
    HealthStatus *health;
    NSMutableArray *allAnswerArray;
    UIScrollView *scrollView;
    UIButton *saveButton;
    NSString *wendaAnswer;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allAnswerArray = [[NSMutableArray alloc] initWithCapacity:0];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 1024, 684)];
    scrollView.delegate = self;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    scrollView.contentSize = CGSizeMake(1024, 5000);
    [self.view addSubview:scrollView];

    
    self.view.backgroundColor = [UIColor colorWithRed:27.00/255 green:27.00/255 blue:27.00/255 alpha:1];
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=questions.questions&que_type=2&order_id=%@",BASEURL,self.order_id];
    NSLog(@"9999999  %@",url);
   
    
    /*
     健康问卷取值与传值
     按题序取值
     按id传值
     */
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        //NSLog(@"res  %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0)
        {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            
            NSDictionary *all_ques = [data objectForKey:@"all_ques"];
            baseDict = [all_ques objectForKey:@"1"];
            base = [[Base alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 800) baseDict:baseDict title:[data objectForKey:@"introduce"]];
            [scrollView addSubview:base];
            
            liveDict = [all_ques objectForKey:@"2"];
            live = [[Live alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(base.frame), viewWidth, 800) liveDict:liveDict];
            [scrollView addSubview:live];
            
            foodDict = [all_ques objectForKey:@"3"];
            food = [[Food alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(live.frame), viewWidth, 800) foodDict:foodDict];
            [scrollView addSubview:food];
            
            fitnessDict = [all_ques objectForKey:@"4"];
            fitness = [[FitnessHistory alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(food.frame), viewWidth, 800) fitnessDict:fitnessDict];
            [scrollView addSubview:fitness];
            
            healthDict = [all_ques objectForKey:@"5"];
            health = [[HealthStatus alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fitness.frame), viewWidth, 800) healthDict:healthDict];
            [scrollView addSubview:health];
            
            yogaDict = [all_ques objectForKey:@"6"];
            yoga = [[Yoga alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(health.frame), viewWidth, 800) yogaDict:yogaDict];
            [scrollView addSubview:yoga];
            
            saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            saveButton.frame = CGRectMake(800, CGRectGetMaxY(yoga.frame) + 20, 150, 60);
            [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
            
            if ([self.isOver isEqualToString:@"over"]) {
                base.userInteractionEnabled = NO;
                live.userInteractionEnabled = NO;
                food.userInteractionEnabled = NO;
                fitness.userInteractionEnabled = NO;
                health.userInteractionEnabled = NO;
                yoga.userInteractionEnabled = NO;
                
            }
            if (![self.isOver isEqualToString:@"over"]) {
                [scrollView addSubview:saveButton];
            }
            
        }
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    UIView *daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.text=@"果动健身";
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
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"address" object:nil];
    
}
-(void)saveButtonClick:(UIButton *)button
{
   
    //前7个基础问题答案
    for (int a = 1; a < 8; a++) {
        [self addWenAnswerFromView:base Number:[NSString stringWithFormat:@"%d",a] dict:baseDict];
    }
    //体重是否变化答案
    // NSLog(@"weight %@",base.weightCheck);
    [self addXuanAnswerFromView:base Number:@"8" xuanArray:base.weightCheck dict:baseDict];
    
    //变化多少
    [self addWenAnswerFromView:base Number:@"9" dict:baseDict];
    //睡眠状态
    [self addXuanAnswerFromView:live Number:@"10" xuanArray:live.smokeArray dict:liveDict];
    //经常熬夜备注
    [self addWenAnswerFromView:live Number:@"51" dict:liveDict];
    //吸烟
    [self addXuanAnswerFromView:live Number:@"11" xuanArray:live.sleepStatusArray dict:liveDict];
    //吸多少
    [self addXuanAnswerFromView:live Number:@"12" xuanArray:live.smokeNumberArray dict:liveDict];
    //喝酒
    [self addXuanAnswerFromView:live Number:@"13" xuanArray:live.drinkArray dict:liveDict];
    //喝多少
    [self addXuanAnswerFromView:live Number:@"14" xuanArray:live.drinkNumberArray dict:liveDict];
    //工作性质
    [self addWenAnswerFromView:live Number:@"15" dict:liveDict];
    //工作压力
    [self addWenAnswerFromView:live Number:@"16" dict:liveDict];
    //早中晚三餐
    for (int a = 17; a < 20; a++) {
        [self addWenAnswerFromView:food Number:[NSString stringWithFormat:@"%d",a] dict:foodDict];
    }
    //食物分析
    NSLog(@"上传食物分析 %@",food.foodAnalyzeArray);
    
    [self addXuanAnswerFromView:food    Number:@"20" xuanArray:food.foodAnalyzeArray dict:foodDict];
    //饮食规律
    [self addXuanAnswerFromView:food    Number:@"21" xuanArray:food.lawFoodArray dict:foodDict];
    //喜欢吃的零食
    [self addWenAnswerFromView:food     Number:@"22" dict:foodDict];
    //运动补剂
    [self addXuanAnswerFromView:food    Number:@"23" xuanArray:food.sportTonicArray dict:foodDict];
    //什么补剂
    [self addWenAnswerFromView:food     Number:@"50" dict:foodDict];
    //饮食计划
    [self addXuanAnswerFromView:food    Number:@"24" xuanArray:food.foodPlanArray dict:foodDict];
    //1-2年专业训练
    [self addXuanAnswerFromView:fitness Number:@"25" xuanArray:fitness.professionalSportArray dict:fitnessDict];
    //训练备注
    [self addWenAnswerFromView:fitness  Number:@"49" dict:fitnessDict];
    //每周运动几次
    [self addXuanAnswerFromView:fitness Number:@"26" xuanArray:fitness.sportNumberArray dict:fitnessDict];
    //运动时间
    [self addXuanAnswerFromView:fitness Number:@"27" xuanArray:fitness.sportTimeArray dict:fitnessDict];
    //什么时候运动
    [self addXuanAnswerFromView:fitness Number:@"28" xuanArray:fitness.whenSportArray dict:fitnessDict];
    //什么类型运动
    [self addWenAnswerFromView:fitness  Number:@"29" dict:fitnessDict];
    //肩颈状况
    [self addWenAnswerFromView:health   Number:@"30" dict:healthDict];
    //韧带肌肉状况
    [self addWenAnswerFromView:health   Number:@"31" dict:healthDict];
    //疾病
    NSLog(@"疾病 %@",health.diseaseArray);
    [self addXuanAnswerFromView:health  Number:@"32" xuanArray:health.diseaseArray dict:healthDict];
    //其他疾病备注
    [self addWenAnswerFromView:health   Number:@"48" dict:healthDict];
    //过敏史
    [self addWenAnswerFromView:health   Number:@"33" dict:healthDict];
    //是否接触过瑜伽
    [self addXuanAnswerFromView:yoga    Number:@"34" xuanArray:yoga.touchYogaArray dict:yogaDict];
    //习练多久
    [self addWenAnswerFromView:yoga     Number:@"46" dict:yogaDict];
    //什么流派
    [self addWenAnswerFromView:yoga     Number:@"47" dict:yogaDict];
    //喜欢的瑜伽方式
    [self addWenAnswerFromView:yoga     Number:@"35" dict:yogaDict];
    //关节
    [self addXuanAnswerFromView:yoga    Number:@"36" xuanArray:yoga.jointArray dict:yogaDict];
    //练习瑜伽目的
    [self addXuanAnswerFromView:yoga    Number:@"37" xuanArray:yoga.purposeArray dict:yogaDict];
    //耐力
    [self addXuanAnswerFromView:yoga    Number:@"38" xuanArray:yoga.enduranceArray dict:yogaDict];
    //温度
    [self addXuanAnswerFromView:yoga    Number:@"39" xuanArray:yoga.temperatureArray dict:yogaDict];
    //喜欢什么时候练瑜伽
    [self addXuanAnswerFromView:yoga    Number:@"40" xuanArray:yoga.whatTimeArray dict:yogaDict];
    //每周练习瑜伽次数
    [self addXuanAnswerFromView:yoga    Number:@"41" xuanArray:yoga.timesArray dict:yogaDict];
    //消化能力
    [self addXuanAnswerFromView:yoga    Number:@"42" xuanArray:yoga.digestionArray dict:yogaDict];
    //是否易被影响
    [self addXuanAnswerFromView:yoga    Number:@"43" xuanArray:yoga.affectArray dict:yogaDict];
    //记忆力
    [self addXuanAnswerFromView:yoga    Number:@"44" xuanArray:yoga.memoryArray dict:yogaDict];
    //身体循环
    [self addXuanAnswerFromView:yoga    Number:@"45" xuanArray:yoga.circulationArray dict:yogaDict];
    //检查姓名
    if ([[(UITextField *)[base viewWithTag:1] text] isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"姓名是必填项！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    //检查性别
    if ([[(UITextField *)[base viewWithTag:2] text] isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"性别是必填项！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    //检查号码
    BOOL ret4 = [questionnaireVC isValidateTelNumber:[(UITextField *)[base viewWithTag:4] text]];
    if (!ret4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"电话号码是必填项" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    //检查生日
    BOOL ret3 = [questionnaireVC isValidate:[(UITextField *)[base viewWithTag:3] text]];
    if (!ret3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"生日的格式为YYYY-MM-DD" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"正在上传" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    
    [alert show];
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=questions.save_questions&order_id=%@&que_type=2",BASEURL,self.order_id];
    //    NSLog(@"irl   %@",url);
    //    NSLog(@"order_id  %@",self.order_id);
    //传入的参数
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:CONTENTTYPE];
    //发送请求
    [manager POST:url parameters:allAnswerArray success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  NSLog(@"JSON: %@", responseObject);
        //  [all_array removeAllObjects];
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
            
            [alert setMessage:@"保存成功"];
           
            [alert dismissWithClickedButtonIndex:0 animated:NO];
           [NSThread sleepForTimeInterval:2.0f];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
    [allAnswerArray removeAllObjects];
    
}
//添加问答题答案到参数数组中
-(void)addWenAnswerFromView:(UIView *)view Number:(NSString *)number dict:(NSDictionary *)messageDict
{
    
   // NSLog(@"messageDict %@",messageDict);
    
    NSString * issue_id = [[[messageDict objectForKey:@"ques"] objectForKey:number] objectForKey:@"id"];
    if (!(UITextField *)[view viewWithTag:[number intValue]] ) {
        wendaAnswer = @"";
    }else{
        if ([number isEqual:@"3"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:[(UITextField *)[base viewWithTag:3] text]];
            wendaAnswer = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
        }else{
            wendaAnswer = [(UITextField *)[view viewWithTag:[number intValue]] text];
        }
    }
   // NSLog(@"answer %@  id  %@",wendaAnswer,issue_id);
    
    NSDictionary *dict = @{@"answer":[NSArray arrayWithObject:wendaAnswer],@"issue_id":issue_id,@"issue_type":@"2"};
    NSLog(@"dict %@",dict);
    [allAnswerArray addObject:dict];
}
//添加选择题答案到参数数组中
-(void)addXuanAnswerFromView:(UIView *)view Number:(NSString *)number xuanArray:(NSArray *)array dict:(NSDictionary *)messageDict
{
    
    NSString *issue_id = [[[messageDict objectForKey:@"ques"] objectForKey:number] objectForKey:@"id"];
     NSLog(@"answer %@  id  %@",array,issue_id);
    
    NSDictionary *dict = @{@"answer":array,@"issue_id":issue_id,@"issue_type":@"1"};
    [allAnswerArray addObject:dict];
}
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//是否是有效的正则表达式
+(BOOL)isValidateRegularExpression:(NSString *)strDestination byExpression:(NSString *)strExpression
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:strDestination];
}

+(BOOL)isValidate:(NSString *)date
{
    NSString *str = @"(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)";
    BOOL rt = [self isValidateRegularExpression:date byExpression:str];
    return rt;
    
}
//验证电话号码
+(BOOL)isValidateTelNumber:(NSString *)number
{
    NSString *strRegex = @"[0-9]{11,11}";
    
    BOOL rt = [self isValidateRegularExpression:number byExpression:strRegex];
    
    return rt;
}

@end
