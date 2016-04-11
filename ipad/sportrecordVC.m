//
//  sportrecordVC.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "sportrecordVC.h"
#import "sportModel.h"
@implementation sportrecordVC
{
    UITextField  *datetextField;
    UITextField  *nametextField;
    UITextField  *contenttextField;
    UITextField  *HRtextField;
    UITextField  *timetextField;
    NSString     *expression;
    NSString     *enthusiasm;
    UILabel      *remarkLabel;
    UIScrollView *scrollView;
    BOOL         islength;
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
    titlelabel.text=@"运动记录表格";
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
    
    
    [self requestView];
    [self createView];
    
}
-(void)requestView
{
    UISegmentedControl* segmentedControl1 = (UISegmentedControl *)[self.view viewWithTag:5];
    UISegmentedControl* segmentedControl2 = (UISegmentedControl *)[self.view viewWithTag:10];
    
    NSString *url =[NSString stringWithFormat:@"%@pad/?method=coach.details&order_id=%@",BASEURL,self.order_id];
    NSLog(@"url  %@",url);
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res  %@",responseObject);
        //enthusiasm  热情
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSDictionary *recard = [data objectForKey:@"recard"];
        self.sportArray = [NSMutableArray array];
        for (NSDictionary *dict in [recard objectForKey:@"recard_remark"]) {
            sportModel *sport = [[sportModel alloc] initWithDictionary:dict];
            [self.sportArray addObject:sport];
        }
        [self createRemark];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[recard objectForKey:@"date"] intValue]];
        NSLog(@"1296035591  = %@",confromTimesp);
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        NSLog(@"confrom   %@",confromTimespStr);
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *hour=[dateFormatter stringFromDate:date];
        
        datetextField.text = [confromTimespStr isEqualToString:@"1970-01-01"] ? hour : confromTimespStr;
        if ([recard objectForKey:@"time"]) {
            timetextField.text = [NSString stringWithFormat:@"%@",[recard objectForKey:@"time"]];
        }
        
        if ([recard objectForKey:@"heart_rate"]) {
            HRtextField.text = [NSString stringWithFormat:@"%@",[recard objectForKey:@"heart_rate"]];
        }
        if ([recard objectForKey:@"coach"]) {
            nametextField.text = [recard objectForKey:@"coach"];
        }
        else
        {
            nametextField.text = self.coachName;
        }
        remarkLabel.text = [recard objectForKey:@"tips"];
        contenttextField.text = [recard objectForKey:@"content"];
        if ([recard objectForKey:@"expression"]) {
            segmentedControl1.selectedSegmentIndex = [[NSString stringWithFormat:@"%@",[recard objectForKey:@"expression"]] intValue];
        }
        if ([recard objectForKey:@"enthusiasm"]) {
            segmentedControl2.selectedSegmentIndex = [[NSString stringWithFormat:@"%@",[recard objectForKey:@"enthusiasm"]] intValue];
        }
        
        expression= [NSString stringWithFormat:@"%ld",(long)segmentedControl1.selectedSegmentIndex];
        enthusiasm = [NSString stringWithFormat:@"%ld",(long)segmentedControl2.selectedSegmentIndex];
        
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
}

-(void)createView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, viewWidth, viewHeight - 64)];
 
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    
    NSArray *array = @[@"日期：",@"时长：",@"教练员：",];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70 + 300*i, 10, 120, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:FONT size:30];
        label.text =array[i];
        [scrollView addSubview:label];
        
    }
    datetextField = [[UITextField alloc] initWithFrame:CGRectMake(145 , 10, 200, 50)];
    datetextField.borderStyle =UITextBorderStyleRoundedRect;
    datetextField.placeholder = @"YYYY-MM-DD";
    datetextField.textAlignment = 1;
    datetextField.delegate = self;
    datetextField.tag = 1;
    datetextField.keyboardType=UIKeyboardTypeNumberPad;
    datetextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    datetextField.font = [UIFont fontWithName:FONT size:28];
    [datetextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [datetextField setValue:[UIFont boldSystemFontOfSize:28] forKeyPath:@"_placeholderLabel.font"];
    [scrollView addSubview:datetextField];
    
    timetextField = [[UITextField alloc] initWithFrame:CGRectMake(460, 10, 200, 50)];
    timetextField.borderStyle =UITextBorderStyleRoundedRect;
    timetextField.textAlignment = 1;
    timetextField.delegate = self;
    timetextField.keyboardType=UIKeyboardTypeNumberPad;
    timetextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    timetextField.font = [UIFont fontWithName:FONT size:30];
    [timetextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [timetextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [scrollView addSubview:timetextField];
    
    nametextField = [[UITextField alloc] initWithFrame:CGRectMake(775 /* +315*i */, 10, 200, 50)];
    nametextField.borderStyle =UITextBorderStyleRoundedRect;
    nametextField.textAlignment = 1;
    nametextField.delegate = self;
    nametextField.keyboardType=UIKeyboardTypeDefault;
    nametextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nametextField.font = [UIFont fontWithName:FONT size:30];
    [nametextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [nametextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [scrollView addSubview:nametextField];
    
    NSArray *array1 = @[@"练习内容：",@"最高心率：",];
    for (int a = 0; a < 2; a++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70 + 400*a, CGRectGetMaxY(datetextField.frame) + 25, 150, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:FONT size:30];
        label.text =array1[a];
        [scrollView addSubview:label];
        
    }
    contenttextField = [[UITextField alloc] initWithFrame:CGRectMake(220 /* +315*i */, CGRectGetMaxY(datetextField.frame) + 25, 200, 50)];
    contenttextField.borderStyle =UITextBorderStyleRoundedRect;
    contenttextField.textAlignment = 1;
    contenttextField.delegate = self;
    contenttextField.keyboardType=UIKeyboardTypeDefault;
    contenttextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    contenttextField.font = [UIFont fontWithName:FONT size:30];
    [contenttextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [contenttextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [scrollView addSubview:contenttextField];
    
    
    HRtextField = [[UITextField alloc] initWithFrame:CGRectMake(640 /* +315*i */, CGRectGetMaxY(datetextField.frame) + 25, 200, 50)];
    HRtextField.borderStyle =UITextBorderStyleRoundedRect;
    HRtextField.textAlignment = 1;
    HRtextField.delegate = self;
    HRtextField.keyboardType=UIKeyboardTypeNumberPad;
    HRtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    HRtextField.font = [UIFont fontWithName:FONT size:30];
    [HRtextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [HRtextField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [scrollView addSubview:HRtextField];
    
    NSArray *array2 = @[@"运动表现:",@"会员热情度:",];
    NSArray *array5 = @[@"一般",@"良好",@"活跃"];
    
    for (int b = 0; b < 2; b++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70 + 400*b, CGRectGetMaxY(contenttextField.frame) + 25, 170, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:FONT size:30];
        label.text =array2[b];
        [scrollView addSubview:label];
        
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:array5];
        segmentControl.tag = 5 + 5*b;
        segmentControl.backgroundColor = [UIColor whiteColor];
        segmentControl.tintColor = [UIColor blackColor];
        segmentControl.layer.cornerRadius = 10;
        segmentControl.layer.masksToBounds = YES;
        segmentControl.frame  = CGRectMake(220 + 420*b, CGRectGetMaxY(contenttextField.frame) + 25, 200, 50);
        [segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:segmentControl];
        
    }
    
    
}
- (void)createRemark {
    
    for (int a = 0; a < self.sportArray.count; a++) {
        sportModel *sport = self.sportArray[a];
        UILabel *STLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(contenttextField.frame) + 75 + 15 + a * (50 + 165), viewWidth - 140, 50)];
        STLabel.text = sport.title;
        STLabel.textColor = [UIColor whiteColor];
        STLabel.font = [UIFont fontWithName:FONT size:23];
        [scrollView addSubview:STLabel];
        
        UITextView  *textView =[[UITextView alloc] initWithFrame:CGRectMake(80,CGRectGetMaxY(contenttextField.frame) + 140 + a * (150 + 50 + 15), 860,150)];
        textView.text = sport.content;
        textView.backgroundColor = [UIColor whiteColor];
       // textView.delegate = self;
        textView.layer.cornerRadius = 10;
        textView.layer.masksToBounds = YES;
        textView.tag = [sport.title_id intValue] * 1000;
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont fontWithName:FONT size:20];
        [scrollView addSubview:textView];
        
        if (a == self.sportArray.count - 1) {
            UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            saveButton.frame = CGRectMake(770, CGRectGetMaxY(textView.frame) + 25, 150, 56);
            [saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
            [saveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:saveButton];
            
             scrollView.contentSize = CGSizeMake(viewWidth, CGRectGetMaxY(saveButton.frame) + 256 + 150);
        }
    }
}
- (void)valueChanged:(UISegmentedControl* )sender
{
    NSLog(@"sender  %ld",(long)sender.selectedSegmentIndex);
    switch (sender.tag) {
        case 5:
        {
            expression= [NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
        }
            break;
        case 10:
        {
            enthusiasm= [NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 只要偏移量有改变  就会调用
    [self.view endEditing:YES];
}
-(void)buttonClick:(UIButton *)button
{
   
    BOOL ret3 = [sportrecordVC isValidate:datetextField.text];
    BOOL ret2 = [sportrecordVC isValitime:timetextField.text];
  //  UITextView *textView1 = (UITextView*)[scrollView viewWithTag:1000];
  //  UITextView *textView2 = (UITextView*)[scrollView viewWithTag:2000];
  //  UITextView *textView3 = (UITextView*)[scrollView viewWithTag:3000];
  //  UITextView *textView4 = (UITextView*)[scrollView viewWithTag:4000];
  //  UITextView *textView5 = (UITextView*)[scrollView viewWithTag:5000];
    
    
//    NSString *remarkString = [NSString stringWithFormat:@"%@%@%@%@%@",textView1.text,textView2.text,textView3.text,textView4.text,textView5.text];
//    NSLog(@"remark %@",remarkString);
    NSMutableArray *remarkArray = [NSMutableArray array];
//    
    if (!ret3||!ret2)
    {
        NSLog(@"This is a  not Tel");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"必填项未填或格式不对！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        
        [alert show];
        
    }
    else
    {
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.sport_record",BASEURL];
        
        for (sportModel *sport in self.sportArray) {
           
            UITextView *textView = (UITextView*)[scrollView viewWithTag:[sport.title_id intValue] * 1000];
            [remarkArray addObject:@{@"title_id":sport.title_id,@"content":textView.text}];
            NSLog(@"remarkArray %@",remarkArray);
            
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:datetextField.text];
        NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
        
        
        NSDictionary *dict = @{@"order_id":self.order_id,
                               @"date":timeSp,
                               @"coach":nametextField.text,
                               @"time":timetextField.text,
                               @"content":contenttextField.text,
                               @"heart_rate":HRtextField.text,
                               @"expression":expression,
                               @"enthusiasm":enthusiasm,
                               @"recard_remark":remarkArray};
       
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:CONTENTTYPE];
        //发送请求
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            if ([[responseObject objectForKey:@"rc"] intValue] == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
                
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];

            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接错误，正在排查中...." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }];
        
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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

+(BOOL)isValitime:(NSString *)time
{
    NSString *str = @"^0-9]|[0-9]+(.[0-9]{1})?$";
    BOOL rt = [self isValidateRegularExpression:time byExpression:str];
    return rt;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
