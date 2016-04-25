//
//  bodyTextVC.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "bodyTextVC.h"
#import "histoyrText.h"
#import "UIImage+JW.h"
#import "SJAvatarBrowser.h"
#import "UIImagePickerUpdateViewController.h"
#import "PhotoManager.h"
@implementation bodyTextVC
{
    NSMutableData *imageData;//两个图片data合成一个data
    NSMutableArray *_imageDatas; // 存放要上传图片的data
    UIImageView *leftImage;
    UIImageView *rightImage;
    
    NSMutableArray *_phtotDatas;
    UIImageView *photoleftimage;
    UIImageView *photorightimage;
    
    NSString *where;
    NSString *photo;
    NSTimer *timer;
    UIView *phototView;
    UIButton *phototbuttonleft;
    UIButton *photobuttonright;
    int lastNumber;
    int  isopen;
    BOOL issave;
    UIScrollView *scrollView;
    NSDictionary *dictdict;
    UIAlertView *succAlert;
    NSTimer *uploadTimer;
    NSDictionary *nameDict;
    NSData *leftImageData;
    NSData *rightImageData;
    
    NSData *photoLeftData;
    NSData *photoRightData;
    
    NSString *tupian;
    NSString *shuju;
    UIView *saveView;
    UILabel * jingduLabel;
    
    UIActionSheet* changesheet;
    UIAlertView *changeAlert;
    UIAlertView *libraryAlertView;
    
}

#warning  上传成功应把图片和数据分开  数据和图片均上传成功在跳转（?） 图片上传进度
- (void)viewDidLoad {
    [super viewDidLoad];
    
    where = @"";
    // isopen = -1;
    imageData = [[NSMutableData alloc] init];
    NSLog(@"已经完成了吗 %d",self.complete);
    
    issave = NO;
    _imageDatas = [NSMutableArray array];
    _imageDatas = [[NSMutableArray alloc] initWithCapacity:0];
    _phtotDatas = [[NSMutableArray alloc] initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:27.00/255 green:27.00/255 blue:27.00/255 alpha:1];
    
   
    changeAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择获取方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"从图库选择",@"照相",nil];
    changeAlert.delegate = self;
    
    changesheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从图库选择", nil];
    
    nameDict = @{@"9001":@"头部中立位",@"9002":@"胸椎后凸",@"9003":@"头部侧倾",@"9004":@"头部侧旋",@"9005":@"肩部耸肩",@"9006":@"腰椎直线"};
    UIView *daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    // daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    
    saveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    saveView.center = self.view.center;
    saveView.layer.cornerRadius = 6;
    saveView.layer.masksToBounds = YES;
    saveView.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, saveView.bounds.size.width, 27)];
    textLabel.textColor = [UIColor blackColor];
    textLabel.textAlignment = 1;
    textLabel.font = [UIFont fontWithName:FONT size:20];
    textLabel.text = @"正在上传图片...";
    [saveView addSubview:textLabel];
    
    jingduLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame)+15, saveView.bounds.size.width, 20)];
    jingduLabel.textAlignment = 1;
    jingduLabel.textColor = [UIColor blackColor];
    jingduLabel.font = [UIFont fontWithName:FONT size:20];
    [saveView addSubview:jingduLabel];
    
    
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.text=@"身体测试表";
    titlelabel.font=[UIFont fontWithName:FONT size:36];
    titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    if (self.complete == YES) {
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }else{
        [backButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    }
    
    [backButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:backButton];
    
    
    UIButton *TDButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    TDButton.frame = CGRectMake(875, 7, 100, 50);
    [TDButton setBackgroundImage:[UIImage imageNamed:@"historytext"] forState:UIControlStateNormal];
    [TDButton addTarget:self action:@selector(gotohistory:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:TDButton];
    
    
    
    
    [self createView];
    [self requestView];
    
}
-(void)requestView
{
    
    NSString *pictureurl = [NSString stringWithFormat:@"%@pad/?method=coach.getbodyimg&order_id=%@&types=0",BASEURL,self.order_id];
    NSLog(@"URL  %@", pictureurl);
    [HttpTool postWithUrl:pictureurl params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res %@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        //缓存有取缓存 没有加载  逐步加载
        [leftImage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"before"]] placeholderImage:[UIImage imageNamed:@"body_jiahao"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        [rightImage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"after"]] placeholderImage:[UIImage imageNamed:@"body_jiahao"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
    }];
    
    NSLog(@"self.order_id  %@",self.order_id);
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.body_detail&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        NSDictionary  *data = [responseObject objectForKey:@"data"];
        
        NSLog(@"hahahahahres  %@",responseObject);
        
        if ([[data objectForKey:@"status"] intValue] == 0) {
            [(UITextField *)[self.view viewWithTag:2] setText:self.coachName];
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            [(UITextField *)[self.view viewWithTag:1] setText:[dateFormatter stringFromDate:date]];
            return ;
        }
        else{
            // 时间戳转时间的方法:
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"time"] intValue]];
            NSLog(@"1296035591  = %@",confromTimesp);
            NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
            NSLog(@"教练员  %@",[data objectForKey:@"coach"]);
            NSLog(@"confromTimespStr    %@",confromTimespStr);
            NSLog(@"胸围扩张 %@",[data objectForKey:@"bust_exp"]);
            [(UITextField *)[self.view viewWithTag:1] setText:confromTimespStr];
            [(UITextField *)[self.view viewWithTag:2] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"coach"]]];
            [(UITextField *)[self.view viewWithTag:3] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"waistline"]]];
            [(UITextField *)[self.view viewWithTag:4] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"hip"]]];
            [(UITextField *)[self.view viewWithTag:5] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"bust_relax"]]];
            [(UITextField *)[self.view viewWithTag:6] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"bust_exp"]]];
            [(UITextField *)[self.view viewWithTag:7] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"rtar"]]];
            [(UITextField *)[self.view viewWithTag:8] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"rtaqj"]]];
            [(UITextField *)[self.view viewWithTag:9] setText: [NSString stringWithFormat:@"%@",[data objectForKey:@"ltar"]]];
            [(UITextField *)[self.view viewWithTag:10] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"ltaqj"]]];
            [(UITextField *)[self.view viewWithTag:11] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"rham"]]];
            [(UITextField *)[self.view viewWithTag:12] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"lham"]]];
            [(UITextField *)[self.view viewWithTag:13] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"rcrus"]]];
            [(UITextField *)[self.view viewWithTag:14] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"lcrus"]]];
            [(UITextField *)[self.view viewWithTag:15] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"gstj"]]];
            [(UITextField *)[self.view viewWithTag:16] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"kjsy"]]];
            [(UITextField *)[self.view viewWithTag:17] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"jjxy"]]];
            [(UITextField *)[self.view viewWithTag:18] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"abdomen"]]];
            [(UITextField *)[self.view viewWithTag:19] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"fat_ham"]]];
            [(UITextField *)[self.view viewWithTag:20] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"total"]]];
            [(UITextField *)[self.view viewWithTag:21] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"fat"]]];
            [(UITextField *)[self.view viewWithTag:22] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"ytbl"]]];
            [(UITextField *)[self.view viewWithTag:23] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bmi"]]];
            [(UITextField *)[self.view viewWithTag:24] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"static_heart_rate"]]];
            [(UITextField *)[self.view viewWithTag:25] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"blood_pressure"]]];
            [(UITextField *)[self.view viewWithTag:26] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"target_heart_rate"]]];
            [(UITextField *)[self.view viewWithTag:27] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"ctzlw"]]];
            [(UITextField *)[self.view viewWithTag:28] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"ctqq"]]];
            [(UITextField *)[self.view viewWithTag:29] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cthy"]]];
            [(UITextField *)[self.view viewWithTag:30] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cjzzlw"]]];
            [(UITextField *)[self.view viewWithTag:31] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cjzgqq"]]];
            [(UITextField *)[self.view viewWithTag:32] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cjbzlw"]]];
            [(UITextField *)[self.view viewWithTag:33] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cjbqy"]]];
            [(UITextField *)[self.view viewWithTag:34] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cxzzlw"]]];
            [(UITextField *)[self.view viewWithTag:35] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cxzgh"]]];
            [(UITextField *)[self.view viewWithTag:36] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cyzzlw"]]];
            [(UITextField *)[self.view viewWithTag:37] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cyzgq"]]];
            [(UITextField *)[self.view viewWithTag:38] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cgpzlw"]]];
            [(UITextField *)[self.view viewWithTag:39] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cgpqq"]]];
            [(UITextField *)[self.view viewWithTag:40] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"cgphy"]]];
            [(UITextField *)[self.view viewWithTag:41] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"czbzlw"]]];
            [(UITextField *)[self.view viewWithTag:42] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"czbzpq"]]];
            [(UITextField *)[self.view viewWithTag:43] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"btzlw"]]];
            [(UITextField *)[self.view viewWithTag:44] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"btcq"]]];
            [(UITextField *)[self.view viewWithTag:45] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"btcx"]]];
            [(UITextField *)[self.view viewWithTag:46] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjbzlw"]]];
            [(UITextField *)[self.view viewWithTag:47] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjbsj"]]];
            [(UITextField *)[self.view viewWithTag:48] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjbtj"]]];
            [(UITextField *)[self.view viewWithTag:49] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjjgzlw"]]];
            [(UITextField *)[self.view viewWithTag:50] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjjgjdqy"]]];
            [(UITextField *)[self.view viewWithTag:51] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bjjgjdsh"]]];
            [(UITextField *)[self.view viewWithTag:52] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"byzzx"]]];
            [(UITextField *)[self.view viewWithTag:53] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"byzxz"]]];
            [(UITextField *)[self.view viewWithTag:54] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bgpzlw"]]];
            [(UITextField *)[self.view viewWithTag:55] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bgpcq"]]];
            [(UITextField *)[self.view viewWithTag:56] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bkgjzlw"]]];
            [(UITextField *)[self.view viewWithTag:57] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bkgjkls"]]];
            [(UITextField *)[self.view viewWithTag:58] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bkgjkwz"]]];
            [(UITextField *)[self.view viewWithTag:59] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bkgjkwx"]]];
            [(UITextField *)[self.view viewWithTag:60] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bkgjknx"]]];
            [(UITextField *)[self.view viewWithTag:61] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bxgjzlw"]]];
            [(UITextField *)[self.view viewWithTag:62] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bxgjxw"]]];
            [(UITextField *)[self.view viewWithTag:63] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bxgjxn"]]];
            [(UITextField *)[self.view viewWithTag:64] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bzbzlw"]]];
            [(UITextField *)[self.view viewWithTag:65] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"bzbbpz"]]];
            [(UITextView  *)[self.view viewWithTag:66] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"remark"]]];
            [(UITextField *)[self.view viewWithTag:67] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"height"]]];
            [(UITextField *)[self.view viewWithTag:68] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"weight"]]];
            [(UITextField *)[self.view viewWithTag:69] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"push_ups"]]];
            [(UITextField *)[self.view viewWithTag:70] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"sit_ups"]]];
            [(UITextField *)[self.view viewWithTag:71] setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"flexible"]]];
            
            //            //服务器数据反了  我这里先反着设置 来对应
            //            [leftImage setImageWithURL:[NSURL URLWithString:[data objectForKey:@"side_img"]] placeholderImage:[UIImage imageNamed:@"body_jiahao"]];
            //            [rightImage setImageWithURL:[NSURL URLWithString:[data objectForKey:@"front_img"]] placeholderImage:[UIImage imageNamed:@"body_jiahao"]];
        }
        
        
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
}
-(void)createView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 1024, 684)];
    scrollView.delegate = self;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    scrollView.contentSize = CGSizeMake(1024*2, 4800);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = NO;
    //  scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:scrollView];
    
    UIImageView *duizhaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1024,0, 1024, 4800)];
    duizhaoImageView.image = [UIImage imageNamed:@"duizhao"];
    //  duizhaoImageView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:duizhaoImageView];
    
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 3550)];
    backImage.image = [UIImage imageNamed:@"textbackground"];
    backImage.userInteractionEnabled = YES;
    [scrollView addSubview:backImage];
    
    
    
    for (int a = 0; a < 2; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(190+a*360,35,200,50)];
        textField.borderStyle =UITextBorderStyleNone;
        textField.keyboardType=UIKeyboardTypeDefault;
        if (a == 0)
        {
            textField.placeholder = @"xxxx-xx-xx";
            textField.keyboardType=UIKeyboardTypeNumberPad;
        }
        textField.textAlignment = 1;
        textField.delegate = self;
        textField.tag = 1+a;
        textField.textColor = [UIColor whiteColor];
        //  textField.backgroundColor = [UIColor redColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
    }
    
    for (int a = 0; a < 2; a++) {
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(190+a*360,107,200,50)];
        textField.borderStyle =UITextBorderStyleNone;
        textField.keyboardType=UIKeyboardTypeDefault;
        //  textField.backgroundColor = [UIColor greenColor];
        textField.textAlignment = 1;
        textField.delegate = self;
        textField.tag = 67+a;
        textField.textColor = [UIColor whiteColor];
        // textField.backgroundColor = [UIColor redColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
        
        NSArray *array = @[@"CM",@"KG"];
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(330 + a*360, 107, 200, 50)];
        label.textColor = [UIColor whiteColor];
        label.text      = array[a];
        label.font      = [UIFont fontWithName:@"Arial" size:30];
        [scrollView addSubview:label];
    }
    
    
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(208,238,190,62)];
    textField.borderStyle =UITextBorderStyleNone;
    //  textField.backgroundColor = [UIColor redColor];
    textField.textAlignment = 1;
    textField.tag = 3;
    textField.delegate = self;
    textField.textColor = [UIColor whiteColor];
    textField.keyboardType=UIKeyboardTypeNumberPad;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont fontWithName:FONT size:30];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    if (self.complete == YES) {
        textField.userInteractionEnabled = NO;
    }
    [scrollView addSubview:textField];
    
    for (int a= 0; a < 11; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(208,302+a*56,190,55)];
        textField.borderStyle =UITextBorderStyleNone;
        //   textField.backgroundColor = [UIColor greenColor];
        textField.textAlignment = 1;
        textField.tag = 4+a;
        textField.delegate = self;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeNumberPad;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
        
    }
    
    for (int a = 0; a < 2; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(205,980+a*56,170,55)];
        textField.borderStyle =UITextBorderStyleNone;
        //   textField.backgroundColor = [UIColor greenColor];
        textField.textAlignment = 1;
        textField.tag = 69+a;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeNumberPad;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
    }
    UITextField *textField70 = [[UITextField alloc] initWithFrame:CGRectMake(735,980,170,55)];
    textField70.borderStyle =UITextBorderStyleNone;
    //   textField70.backgroundColor = [UIColor greenColor];
    textField70.textAlignment = 1;
    textField70.tag = 71;
    textField70.textColor = [UIColor whiteColor];
    textField70.keyboardType=UIKeyboardTypeNumberPad;
    textField70.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField70.font = [UIFont fontWithName:FONT size:30];
    [textField70 setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField70 setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    if (self.complete == YES) {
        textField70.userInteractionEnabled = NO;
    }
    [scrollView addSubview:textField70];
    
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(735,238,190,62)];
    textField1.borderStyle =UITextBorderStyleNone;
    //  textField1.backgroundColor = [UIColor orangeColor];
    textField1.textAlignment = 1;
    textField.delegate = self;
    textField1.tag = 15;
    textField1.textColor = [UIColor whiteColor];
    textField1.keyboardType=UIKeyboardTypeNumberPad;
    textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField1.font = [UIFont fontWithName:FONT size:30];
    [textField1 setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField1 setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    if (self.complete == YES) {
        textField1.userInteractionEnabled = NO;
    }
    [scrollView addSubview:textField1];
    
    for (int a= 0; a < 11; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(735,302+a*56,190,55)];
        textField.borderStyle =UITextBorderStyleNone;
        //    textField.backgroundColor = [UIColor greenColor];
        textField.textAlignment = 1;
        textField.delegate = self;
        textField.tag = 16+a;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeNumberPad;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
        
    }
    
    for (int a = 0; a < 16; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(600,1205+a*54,350,53.5)];
        textField.borderStyle =UITextBorderStyleNone;
        //  textField.backgroundColor = [UIColor redColor];
        textField.textAlignment = 1;
        
        textField.tag = 27+a;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
        
    }
    
    UIButton *cthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cthButton.tag = 9001;
    [cthButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [cthButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    cthButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 1205, 55, 55);
    [scrollView addSubview:cthButton];
    
    UIButton *cxzButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cxzButton.tag = 9002;
    [cxzButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [cxzButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    cxzButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 1634, 55, 55);
    [scrollView addSubview:cxzButton];
    
    UIButton *btcqButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btcqButton.tag = 9003;
    [btcqButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [btcqButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    btcqButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 2123, 55, 55);
    [scrollView addSubview:btcqButton];
    
    
    UIButton *btcxButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btcxButton.tag = 9004;
    [btcxButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [btcxButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    btcxButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 2178, 55, 55);
    [scrollView addSubview:btcxButton];
    
    
    UIButton *bjsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bjsButton.tag = 9005;
    [bjsButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [bjsButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    bjsButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 2288, 55, 55);
    [scrollView addSubview:bjsButton];
    
    
    UIButton *byzButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    byzButton.tag = 9006;
    [byzButton setBackgroundImage:[UIImage imageNamed:@"body_jiahaoquan"] forState:UIControlStateNormal];
    [byzButton addTarget:self action:@selector(setphotoButton:) forControlEvents:UIControlEventTouchUpInside];
    byzButton.frame = CGRectMake(scrollView.bounds.size.width - 58-20, 2562, 55, 55);
    [scrollView addSubview:byzButton];
    
    
    
    for (int a = 0; a < 23; a++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(600,2071+a*54.5,350,54)];
        textField.borderStyle =UITextBorderStyleNone;
        // textField.backgroundColor = [UIColor greenColor];
        textField.textAlignment = 1;
        
        textField.tag = 43+a;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont fontWithName:FONT size:30];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
        if (self.complete == YES) {
            textField.userInteractionEnabled = NO;
        }
        [scrollView addSubview:textField];
        
    }
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(120, 3377, 875, 120)];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor whiteColor];
    textView.tag = 66;
    textView.font = [UIFont fontWithName:FONT size:30];
    if (self.complete == YES) {
        textView.userInteractionEnabled = NO;
    }
    [scrollView addSubview:textView];
    // 2592/5.0625
    
    
    
    phototView = [[UIView alloc] init];
    phototView.userInteractionEnabled = YES;
    phototView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:phototView];
    
    
    photoleftimage = [[UIImageView alloc] init];
    photoleftimage.frame = CGRectMake(0, 0, 270, 270*(2592/1936));
    photoleftimage.userInteractionEnabled = YES;
    photoleftimage.tag = 444;
    photoleftimage.image = [UIImage imageNamed:@"body_jiahao"];
    photoleftimage.contentMode = UIViewContentModeScaleAspectFill;
    photoleftimage.clipsToBounds = YES; // 切边
    
    //添加长按手势
    UILongPressGestureRecognizer *tapLeftDouble  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
    [photoleftimage addGestureRecognizer:tapLeftDouble];
    if (self.complete == NO) {
        //添加点击手势
        UITapGestureRecognizer *tapleft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
        [photoleftimage addGestureRecognizer:tapleft];
        
    }
    
    
    
    
    photorightimage = [[UIImageView alloc] init];
    photorightimage.frame = CGRectMake(CGRectGetMaxX(photoleftimage.frame)+10, 0, 270, 270*(2592/1936));
    // 设置图片内容模式
    photorightimage.tag = 555;
    photorightimage.userInteractionEnabled = YES;
    photorightimage.image = [UIImage imageNamed:@"body_jiahao"];
    photorightimage.contentMode = UIViewContentModeScaleAspectFill;
    photorightimage.clipsToBounds = YES; // 切边
    
    
    //添加长按手势
    UILongPressGestureRecognizer *pinchright  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
    [photorightimage addGestureRecognizer:pinchright];
    //添加点击手势
    if (self.complete == NO) {
        
        UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
        [photorightimage addGestureRecognizer:tapright];
    }
    
    
    
    leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(backImage.frame),1936/3.8566,2592/3.8566)];
    leftImage.backgroundColor = [UIColor clearColor];
    // 设置图片内容模式
    leftImage.userInteractionEnabled = YES;
    leftImage.image = [UIImage imageNamed:@"body_jiahao"];
    leftImage.contentMode = UIViewContentModeScaleAspectFill;
    leftImage.clipsToBounds = YES; // 切边
    [scrollView addSubview:leftImage];
    
    UIButton *leftphoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftphoto.tag = 132;
    leftphoto.frame = CGRectMake(0,0,leftImage.bounds.size.width,leftImage.bounds.size.height);
    [leftphoto addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    if (self.complete == YES) {
        leftphoto.userInteractionEnabled = NO;
    }
    [leftImage addSubview:leftphoto];
    
    
    
    rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImage.frame), CGRectGetMaxY(backImage.frame), 1936/3.8566,2592/3.8566 )];
    rightImage.image = [UIImage imageNamed:@"body_jiahao"];
    rightImage.userInteractionEnabled = YES;
    rightImage.backgroundColor = [UIColor clearColor];
    // 设置图片内容模式
    rightImage.contentMode = UIViewContentModeScaleAspectFill;
    rightImage.clipsToBounds = YES; // 切边
    [scrollView addSubview:rightImage];
    
    UIButton *rightphoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightphoto.tag = 145;
    if (self.complete == YES) {
        rightphoto.userInteractionEnabled = NO;
    }
    rightphoto.frame = CGRectMake(0,0,rightImage.bounds.size.width,rightImage.bounds.size.height);
    [rightphoto addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [rightImage addSubview:rightphoto];
    
}
-(void)setphotoButton:(UIButton *)button
{
    NSLog(@"button.tag  %ld",(long)button.tag);
    
    
    if (isopen == button.tag) {
        
        isopen = -1;
        [phototView removeFromSuperview];
        if (_phtotDatas.count != 0) {
            
            // 30s超时设置
            [self checkOverTime];
            // 图片上传
            NSString *imgeurl = [NSString stringWithFormat:@"%@pad/?method=coach.upbodyimg&order_id=%@&types=%ld",BASEURL,self.order_id,(long)button.tag];
            [self uploadImageWithURL:imgeurl BeforeData:photoLeftData AfterData:photoRightData type:NO];
            
        }
        
    } else {
        if (_phtotDatas.count != 0) {
            lastNumber = isopen;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@的照片没有保存,是否保存",[nameDict objectForKey:[NSString stringWithFormat:@"%d",isopen]]] delegate:self cancelButtonTitle:@"不用" otherButtonTitles:@"好的",nil];
            alert.tag = 999;
            [alert show];
            
        }
        photoleftimage.image =[UIImage imageNamed:@"body_jiahao"];
        photorightimage.image = [UIImage imageNamed:@"body_jiahao"];
        phototView.frame = CGRectMake(450, CGRectGetMaxY(button.frame), 550, 270*(2592/1936));
        phototView.tag = button.tag/10;
        [scrollView addSubview:phototView];
        [phototView addSubview:photoleftimage];
        [phototView addSubview:photorightimage];
        
        CABasicAnimation  *basic1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        basic1.fromValue = [NSNumber numberWithFloat:0];
        basic1.byValue = [NSNumber numberWithFloat:M_PI *2];
        basic1.repeatCount = 1000;
        basic1.duration = 2;
        basic1.removedOnCompletion = NO;
        basic1.fillMode = kCAFillModeForwards;
        [photoleftimage.layer addAnimation:basic1 forKey:@"basic1"];
        
        CABasicAnimation  *basic2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        basic2.fromValue = [NSNumber numberWithFloat:0];
        basic2.byValue = [NSNumber numberWithFloat:M_PI *2];
        basic2.repeatCount = 1000;
        basic2.duration = 2;
        basic2.removedOnCompletion = NO;
        basic2.fillMode = kCAFillModeForwards;
        [photorightimage.layer addAnimation:basic2 forKey:@"basic2"];
        
        
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.getbodyimg&order_id=%@&types=%ld",BASEURL,self.order_id,(long)button.tag];
        
        [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
            //    NSLog(@"900res %@",responseObject);
            [photoleftimage.layer  removeAllAnimations];
            [photorightimage.layer removeAllAnimations];
            if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
                
                
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                if (dict.count > 0) {
                
                    [photoleftimage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"before"]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        NSLog(@"评估图片左  imageURL %@  error %@",imageURL,error);
                    }];
                    
                    [photorightimage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"after"]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        NSLog(@"评估图片you  imageURL %@  error %@",imageURL,error);
                    }];
                }
                else
                {
                    NSLog(@"没有数据");
                    photoleftimage.image =[UIImage imageNamed:@"body_jiahao"];
                    photorightimage.image = [UIImage imageNamed:@"body_jiahao"];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有数据" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    
                    [alert show];
                }
            }
        } fail:^(NSError *error) {
            NSLog(@"error  %@",error);
        }];
        
        isopen = (int)button.tag;
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView.tag %ld",(long)alertView.tag);
    
    if (alertView.tag == 999) {
        
        if (buttonIndex == 0) {
            [_phtotDatas removeAllObjects];
        } else {   // 30s超时设置
            [self checkOverTime];

            // 图片上传
            NSString *imgeurl = [NSString stringWithFormat:@"%@pad/?method=coach.upbodyimg&order_id=%@&types=%d",BASEURL,self.order_id,lastNumber];
            [self uploadImageWithURL:imgeurl BeforeData:photoLeftData AfterData:photoRightData type:NO];
        }
    } else {
        if (buttonIndex == 0) return;
        
        // 1.设置照片源
        if (buttonIndex == 2) {
            // 拍照
            [self imagePickerForCamera];
            
        } else {
            // 从照片库选择
            
            [[PhotoManager getInstance] setShuping];
            [self imagePickerForLibrary];
        }
        
        switch (alertView.tag) {
            case 444:
                photo = @"left";
                break;
            case 555:
                photo = @"right";
                break;
            case 132:
                where = @"left";
                break;
            case 145:
                where = @"right";
                break;
                
            default:
                break;
        }
    }
}
- (void)imagePickerForCamera {
    
    _imagePickerController          = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
- (void)imagePickerForLibrary {
    
    _imagePickerController          = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
    
}

-(void)timerFired
{
    [succAlert dismissWithClickedButtonIndex:0 animated:NO];
}
-(void)tapPhoto:(UIGestureRecognizer *)gesture
{
    photo = @"";
    where = @"";
    
    changeAlert.tag = gesture.view.tag;;
    [changeAlert show];
}
-(void)photo:(UIButton *)button
{
    photo = @"";
    where = @"";
    
    changeAlert.tag = button.tag;;
    [changeAlert show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"协议方法");
    if ([where isEqualToString:@"left"]) {
        
        leftImage.image=info[UIImagePickerControllerOriginalImage];
        leftImageData = UIImageJPEGRepresentation(leftImage.image, .7);
        // 封装字典
        NSDictionary *dict = @{@"before":leftImageData};
        [_imageDatas addObject:dict];
    }
    else if([where isEqualToString:@"right"])
    {
        
        rightImage.image=info[UIImagePickerControllerOriginalImage];
        rightImageData = UIImageJPEGRepresentation(rightImage.image, .7);
        NSDictionary *dict = @{@"after":rightImageData};
        
        [_imageDatas addObject:dict];
        
    }
    else if ([photo isEqualToString:@"left"]) // 六个部位左
    {
        [photoleftimage setImage:info[UIImagePickerControllerOriginalImage]];
        photoLeftData = UIImageJPEGRepresentation(photoleftimage.image, .7);
        // 封装字典
        
        NSDictionary *dict = @{@"before": photoLeftData};
        
        
        [_phtotDatas addObject:dict];
        
    }
    else // 六个部位右
    {
        
        [photorightimage setImage:info[UIImagePickerControllerOriginalImage]];
        
        photoRightData = UIImageJPEGRepresentation(photorightimage.image, .7);
        
        // 封装字典
        NSString *key = @"after";
        NSDictionary *dict = @{key: photoRightData};
        [_phtotDatas addObject:dict];
    }
    /**
     *  保存到相册
     */
    
    int type = picker.sourceType;
    if (type == 1) {
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage],
                                       self,
                                       nil,
                                       nil);
        
    }
    NSLog(@"_phototdata  %lu",(unsigned long)_phtotDatas.count);
    NSLog(@"_image  %lu",(unsigned long)_imageDatas.count);
    [[PhotoManager getInstance] setHengping];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[PhotoManager getInstance] setHengping];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    NSLog(@"取消");
}

-(void)saveButton:(UIButton *)button
{
    NSLog(@"保存 %ld",(long)button.tag);
    
    
    BOOL ret = [bodyTextVC isValidate:[(UITextField *)[self.view viewWithTag:1] text]];
    if (!ret)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"时间的格式为YYYY-MM-DD" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }else{
        if ([(UITextField *)[self.view viewWithTag:2] text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"教练员的名字必填" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
        }else{
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:[(UITextField *)[self.view viewWithTag:1] text]];
            NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
            NSLog(@"timeSp:%@",timeSp);
            NSLog(@"text2  %@",[(UITextField *)[self.view viewWithTag:2] text]);
            NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.bodytest",BASEURL];
            NSDictionary *dict = @{@"time":timeSp,
                                   @"coach":     [(UITextField *)[self.view viewWithTag:2] text],
                                   @"waistline": [(UITextField *)[self.view viewWithTag:3] text],
                                   @"hip":       [(UITextField *)[self.view viewWithTag:4] text],
                                   @"bust_relax":[(UITextField *)[self.view viewWithTag:5] text],
                                   @"bust_exp":  [(UITextField *)[self.view viewWithTag:6] text],
                                   @"rtar" :     [(UITextField *)[self.view viewWithTag:7] text],
                                   @"rtaqj":     [(UITextField *)[self.view viewWithTag:8] text],
                                   @"ltar" :     [(UITextField *)[self.view viewWithTag:9] text],
                                   @"ltaqj":     [(UITextField *)[self.view viewWithTag:10] text],
                                   @"rham" :     [(UITextField *)[self.view viewWithTag:11] text],
                                   @"lham" :     [(UITextField *)[self.view viewWithTag:12] text],
                                   @"rcrus":     [(UITextField *)[self.view viewWithTag:13] text],
                                   @"lcrus":     [(UITextField *)[self.view viewWithTag:14] text],
                                   @"gstj":      [(UITextField *)[self.view viewWithTag:15] text],
                                   @"kjsy":      [(UITextField *)[self.view viewWithTag:16] text],
                                   @"jjxy":      [(UITextField *)[self.view viewWithTag:17] text],
                                   @"abdomen":   [(UITextField *)[self.view viewWithTag:18] text],
                                   @"fat_ham":   [(UITextField *)[self.view viewWithTag:19] text],
                                   @"total":     [(UITextField *)[self.view viewWithTag:20] text],
                                   @"fat":       [(UITextField *)[self.view viewWithTag:21] text],
                                   @"ytbl":      [(UITextField *)[self.view viewWithTag:22] text],
                                   @"bmi":       [(UITextField *)[self.view viewWithTag:23] text],
                                   @"static_heart_rate":[(UITextField *)[self.view viewWithTag:24] text],
                                   @"blood_pressure":   [(UITextField *)[self.view viewWithTag:25] text],
                                   @"target_heart_rate":[(UITextField *)[self.view viewWithTag:26] text],
                                   @"ctzlw":     [(UITextField *)[self.view viewWithTag:27] text],
                                   @"ctqq":      [(UITextField *)[self.view viewWithTag:28] text],
                                   @"cthy":      [(UITextField *)[self.view viewWithTag:29] text],
                                   @"cjzzlw":    [(UITextField *)[self.view viewWithTag:30] text],
                                   @"cjzgqq":    [(UITextField *)[self.view viewWithTag:31] text],
                                   @"cjbzlw":    [(UITextField *)[self.view viewWithTag:32] text],
                                   @"cjbqy":     [(UITextField *)[self.view viewWithTag:33] text],
                                   @"cxzzlw":    [(UITextField *)[self.view viewWithTag:34] text],
                                   @"cxzgh":     [(UITextField *)[self.view viewWithTag:35] text],
                                   @"cyzzlw":    [(UITextField *)[self.view viewWithTag:36] text],
                                   @"cyzgq":     [(UITextField *)[self.view viewWithTag:37] text],
                                   @"cgpzlw":    [(UITextField *)[self.view viewWithTag:38] text],
                                   @"cgpqq":     [(UITextField *)[self.view viewWithTag:39] text],
                                   @"cgphy":     [(UITextField *)[self.view viewWithTag:40] text],
                                   @"czbzlw":    [(UITextField *)[self.view viewWithTag:41] text],
                                   @"czbzpq":    [(UITextField *)[self.view viewWithTag:42] text],
                                   @"btzlw":     [(UITextField *)[self.view viewWithTag:43] text],
                                   @"btcq":      [(UITextField *)[self.view viewWithTag:44] text],
                                   @"btcx":      [(UITextField *)[self.view viewWithTag:45] text],
                                   @"bjbzlw":    [(UITextField *)[self.view viewWithTag:46] text],
                                   @"bjbsj":     [(UITextField *)[self.view viewWithTag:47] text],
                                   @"bjbtj":     [(UITextField *)[self.view viewWithTag:48] text],
                                   @"bjjgzlw":   [(UITextField *)[self.view viewWithTag:49] text],
                                   @"bjjgjdqy":  [(UITextField *)[self.view viewWithTag:50] text],
                                   @"bjjgjdsh":  [(UITextField *)[self.view viewWithTag:51] text],
                                   @"byzzx":     [(UITextField *)[self.view viewWithTag:52] text],
                                   @"byzxz":     [(UITextField *)[self.view viewWithTag:53] text],
                                   @"bgpzlw":    [(UITextField *)[self.view viewWithTag:54] text],
                                   @"bgpcq":     [(UITextField *)[self.view viewWithTag:55] text],
                                   @"bkgjzlw":   [(UITextField *)[self.view viewWithTag:56] text],
                                   @"bkgjkls":   [(UITextField *)[self.view viewWithTag:57] text],
                                   @"bkgjkwz":   [(UITextField *)[self.view viewWithTag:58] text],
                                   @"bkgjkwx":   [(UITextField *)[self.view viewWithTag:59] text],
                                   @"bkgjknx":   [(UITextField *)[self.view viewWithTag:60] text],
                                   @"bxgjzlw":   [(UITextField *)[self.view viewWithTag:61] text],
                                   @"bxgjxw":    [(UITextField *)[self.view viewWithTag:62] text],
                                   @"bxgjxn":    [(UITextField *)[self.view viewWithTag:63] text],
                                   @"bzbzlw":    [(UITextField *)[self.view viewWithTag:64] text],
                                   @"bzbbpz":    [(UITextField *)[self.view viewWithTag:65] text],
                                   @"remark":    [(UITextView  *)[self.view viewWithTag:66] text],
                                   @"height":    [(UITextField *)[self.view viewWithTag:67] text],
                                   @"weight":    [(UITextField *)[self.view viewWithTag:68] text],
                                   @"push_ups":  [(UITextField *)[self.view viewWithTag:69] text],
                                   @"sit_ups":   [(UITextField *)[self.view viewWithTag:70] text],
                                   @"flexible":  [(UITextField *)[self.view viewWithTag:71] text],
                                   @"order_id":self.order_id
                                   };
            
            // 30s超时设置
            
            [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
               
                
                if ([[responseObject objectForKey:@"rc"] intValue]== 0) {
                    
                    if ([where isEqualToString:@"left"]||[where isEqualToString:@"right"]) {
                        // 30s超时设置
                        [self checkOverTime];
                       
                        NSString *imgeurl = [NSString stringWithFormat:@"%@pad/?method=coach.upbodyimg&order_id=%@&types=%ld",BASEURL,self.order_id,(long)button.tag];
                        [self uploadImageWithURL:imgeurl BeforeData:leftImageData AfterData:rightImageData type:YES];
                        
                    
                    } else {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    
                    [alert show];
                }
            } fail:^(NSError *error) {
                NSLog(@"error  %@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }];
        }
    }
    
}
-(void)gotohistory:(UIButton *)button
{
    histoyrText *history = [histoyrText new];
    history.order_id = self.order_id;
    [self.navigationController pushViewController:history animated:YES];
}
-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *textField3 =  (UITextField *)[self.view viewWithTag:3];
    UITextField *textField4 =  (UITextField *)[self.view viewWithTag:4];
    UITextField *textField15 = (UITextField *)[self.view viewWithTag:15];
    UITextField *textField16 = (UITextField *)[self.view viewWithTag:16];
    UITextField *textField17 = (UITextField *)[self.view viewWithTag:17];
    UITextField *textField18 = (UITextField *)[self.view viewWithTag:18];
    UITextField *textField19 = (UITextField *)[self.view viewWithTag:19];
    UITextField *textField20 = (UITextField *)[self.view viewWithTag:20];
    UITextField *textField22 = (UITextField *)[self.view viewWithTag:22];
    UITextField *textField23 = (UITextField *)[self.view viewWithTag:23];
    UITextField *textField67 = (UITextField *)[self.view viewWithTag:67];
    UITextField *textField68 = (UITextField *)[self.view viewWithTag:68];
    if (textField.tag == 1) {
        BOOL ret = [bodyTextVC isValidate:textField.text];
        
        if (!ret)
        {
            NSLog(@"This is a  not Tel");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"时间的格式为YYYY-MM-DD" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            
            [alert show];
        }
    }
    if (textField.tag ==2 ) {
        if (textField.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"教练员的名字必填" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            
            [alert show];
        }
    }
    
    if (textField15.text.length !=0 && textField16.text.length !=0 && textField17.text.length !=0 && textField18.text.length !=0 && textField19.text.length !=0 ) {
        
        textField20.text = [NSString stringWithFormat:@"%d",[textField15.text intValue] + [textField16.text intValue] + [textField17.text intValue] + [textField18.text intValue] + [textField19.text intValue]];
    }
    if (textField67.text.length !=0 && textField68.text.length !=0) {
        float height = [textField67.text floatValue] /100;
        float weight = [textField68.text floatValue] ;
        float
        pingfang = height * height;
        float BMI = weight / pingfang;
        textField23.text = [NSString stringWithFormat:@"%.2f",BMI];
    }
    
    if (textField3.text.length !=0 && textField4.text.length !=0) {
        float yao = [textField3.text floatValue] ;
        float tun = [textField4.text floatValue] ;
        float bili = yao / tun;
        textField22.text = [NSString stringWithFormat:@"%.2f",bili];
        
       // NSLog(@"yao  %f   tun  %f   bili  %f   textField  %@",yao,tun,bili,textField22.text);
    }
}
-(void)magnifyImage:(UIGestureRecognizer *)gesture
{
    NSLog(@"长按手势");
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (gesture.view.tag == 444)
        {
            [SJAvatarBrowser showImage:photoleftimage];
        }
        else
        {
            [SJAvatarBrowser showImage:photorightimage];
        }
    }
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


// 超时设置
- (void)checkOverTime {
    
    uploadTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(overTimeRemoveAlert) userInfo:nil repeats:YES];
}
- (void)overTimeRemoveAlert {
    
    NSLog(@"超时了");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传超时，请重新上传" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alert show];
    //移除定时器
    [self removeTimer];
}
//移除定时器
- (void)removeTimer {
    
    [uploadTimer invalidate];
}


#pragma mark - 图片上传的请求
- (void)uploadImageWithURL:(NSString *)url BeforeData:(NSData *)beforeData AfterData:(NSData *)afterData type:(BOOL)type{
    UIView *sixImageView         = [UIView new];
    sixImageView.backgroundColor = [UIColor whiteColor];
    sixImageView.center          = self.view.center;
    sixImageView.bounds          = CGRectMake(0, 0, 200, 100);
    sixImageView.layer.cornerRadius  = 5;
    sixImageView.layer.masksToBounds = YES;
    [self.view addSubview:sixImageView];
    
    UILabel *title  = [UILabel new];
    title.textColor = [UIColor blackColor];
    title.font      = [UIFont fontWithName:FONT size:18];
    title.text      = @"正在上传";
    title.frame     = CGRectMake(0, 10, 200, 25);
    title.textAlignment = 1;
    [sixImageView addSubview:title];
    
    
    UILabel *sixLabel  = [UILabel new];
    sixLabel.textColor = [UIColor blackColor];
    sixLabel.font      = [UIFont fontWithName:FONT size:16];
    sixLabel.frame     = CGRectMake(0, CGRectGetMaxY(title.frame) + 10, 200, 20);
   
    sixLabel.textAlignment = 1;
    [sixImageView addSubview:sixLabel];
    
  
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url
                                                                   parameters:nil
                                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                        
                                                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                        // 设置时间格式
                                                        formatter.dateFormat = @"yyyyMMddHHmmss";
                                                        NSString *str = [formatter stringFromDate:[NSDate date]];
                                                        //按时间给传的文件命名
                                                        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", str];
                                                        
                                                        if (beforeData) {
                                                            [formData appendPartWithFileData:beforeData name:@"before" fileName:imageName mimeType:@"jpg"];//传图片 imageData 图片所在的data
                                                        }
                                                        
                                                        if (afterData) {
                                                             [formData appendPartWithFileData:afterData name:@"after" fileName:imageName mimeType:@"jpg"];
                                                        }
                                                       
                                                        
                                                        
                                                    }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSLog(@"Success %@", responseObject);
                                         
                                         [sixImageView removeFromSuperview];
                                         [self removeTimer];
                                         
                                         if (type) {
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Failure %@", error.description);
                                     }];
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
       
        sixLabel.text = [NSString stringWithFormat:@"%.1fKB/%.1fKB",totalBytesWritten/1024.0,totalBytesExpectedToWrite/1024.0];
         NSLog(@"%@",sixLabel.text);
        
    }];
    [operation start];

}

@end
