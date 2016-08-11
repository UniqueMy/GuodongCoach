//
//  addCheckView.m
//  ipad
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 Unique. All rights reserved.
//
#define KeyHeightMax 398
#import "addCheckView.h"
#import "showClassView.h"
#import "ContentModel.h"
#import "historyCheckView.h"
@interface addCheckView ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>

@end
@implementation addCheckView
{
    UIScrollView   *_scrollView;
    NSString       *coach_id;
   
    NSMutableArray *trainClassArray;
    UILabel        *passLabel;
    UIColor        *baseColor;
    UIFont         *baseFont;
    UITextField    *timeTF;
    UITextField    *personTF;
    UITextView     *remarkTV;
    UIButton       *saveButton;
    showClassView  *classView;
    NSString       *frame_id;
    NSString       *historyFrame_id;
    NSString       *resultNumber;
    UISegmentedControl  *trainResultSegment;
}
- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach
{
    self = [super initWithFrame:frame];
    if (self) {
        trainClassArray = [NSMutableArray array];
        trainClassArray = array;
        coach_id        = coach;
        [self createUI];
       
    }
    return self;
}



- (void)createUI {
    
    baseColor = [UIColor colorWithRed:158/255.0
                                green:127/255.0
                                 blue:180/255.0
                                alpha:1];
    
    baseFont = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    
    /******************************************************/
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 self.bounds.size.width,
                                                                 self.bounds.size.height)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
//    passLabel       = [UILabel new];
//    passLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:22];
//    passLabel.textAlignment = 1;
//    passLabel.frame     = CGRectMake(40, 30, 100, 25);
//    passLabel.textColor = [UIColor colorWithRed:193/255.0 green:0 blue:0 alpha:1];
//    passLabel.text      = @"未通过";
//    [_scrollView addSubview:passLabel];
    
    showClassView *showView = [[showClassView alloc] initWithFrame:CGRectMake(150, 40, 250, 31) trainClassArray:trainClassArray superClass:self tag:100];
    
    [_scrollView addSubview:showView];
    
    
    UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    historyButton.frame     = CGRectMake(CGRectGetMaxX(showView.frame) + 15,
                                         CGRectGetMinY(showView.frame),
                                         150,
                                         31);
    historyButton.backgroundColor = baseColor;
    [historyButton setTintColor:[UIColor whiteColor]];
    [historyButton addTarget:self action:@selector(historyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [historyButton setTitle:@"查看考核详情" forState:UIControlStateNormal];
    [_scrollView addSubview:historyButton];
    
    /******************************************************/
    UILabel * titleLabel     = [UILabel new];
    titleLabel.text          = @"+新增考核";
    titleLabel.textColor     = baseColor;
    titleLabel.frame         = CGRectMake(30, 100, 130, 30);
    titleLabel.font          = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    [_scrollView addSubview:titleLabel];
    
    
    NSArray *labelArray = @[@"考核时间:",@"考核大纲:",@"考核成绩:",@"监考人:",@"备    注:"];
    for (int a = 0; a < 5; a++) {
        UILabel *label  = [UILabel new];
        label.textColor = baseColor;
        label.frame     = CGRectMake(40, CGRectGetMaxY(titleLabel.frame) + 25 + a*50, 120, 20);
        label.font      = baseFont;
        label.tag       = (a + 1)*10;
        label.text      = labelArray[a];
        [_scrollView addSubview:label];
        
    }
    
    
    timeTF       = [UITextField new];
    timeTF.frame = CGRectMake(165,
                              CGRectGetMaxY(titleLabel.frame) + 20,
                              250, 30);
    timeTF.textColor    = baseColor;
    timeTF.tag          = 15;
    timeTF.delegate     = self;
    timeTF.keyboardType = UIKeyboardTypeNumberPad;
    timeTF.font         = baseFont;
    [_scrollView addSubview:timeTF];
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showButton.frame     = CGRectMake(CGRectGetMinX(timeTF.frame),
                                      CGRectGetMaxY(timeTF.frame) + 20,
                                      250,
                                      31);
    [showButton addTarget:self action:@selector(showButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:showButton];
    
    
    classView = [[showClassView alloc] initWithFrame:CGRectMake(CGRectGetMinX(timeTF.frame),
                                                                CGRectGetMaxY(timeTF.frame) + 20,
                                                                250,
                                                                31)
                                     trainClassArray:trainClassArray
                                          superClass:self
                                                 tag:200];
    
    NSArray *trainResultArray = @[@"优",@"良",@"中",@"差"];
    trainResultSegment           = [[UISegmentedControl alloc] initWithItems:trainResultArray];
    trainResultSegment.frame     = CGRectMake(CGRectGetMinX(timeTF.frame),
                                              CGRectGetMaxY(classView.frame) + 20,
                                              250,
                                              31.5);
    trainResultSegment.tintColor = [UIColor clearColor];
    [trainResultSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:trainResultSegment];
    
    UIButton *resultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resultButton.frame     = CGRectMake(CGRectGetMinX(timeTF.frame),
                                        CGRectGetMaxY(classView.frame) + 20,
                                        250,
                                        31);
    [resultButton addTarget:self action:@selector(resultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:resultButton];
    
   
    personTF       = [UITextField new];
    personTF.frame = CGRectMake(CGRectGetMinX(timeTF.frame),
                              CGRectGetMaxY(trainResultSegment.frame) + 20,
                              250, 30);
    personTF.textColor    = baseColor;
    personTF.delegate     = self;
    personTF.font         = baseFont;
    [_scrollView addSubview:personTF];
    
    remarkTV       = [UITextView new];
    remarkTV.frame = CGRectMake(CGRectGetMinX(timeTF.frame),
                                CGRectGetMaxY(personTF.frame) + 20,
                                410, 100);
    remarkTV.textColor = baseColor;
    remarkTV.delegate  = self;
    remarkTV.font      = baseFont;
    [_scrollView addSubview:remarkTV];
    
    
    
    /**********保存按钮**************/
    saveButton       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake((self.bounds.size.width - 150) / 2,
                                  self.bounds.size.height - 30 - 40,
                                  150,
                                  40);
    saveButton.titleLabel.font = [UIFont fontWithName:FONT size:22];
    
        saveButton.backgroundColor = [UIColor lightGrayColor];
        saveButton.userInteractionEnabled = NO;
   
    
    [saveButton setTintColor:[UIColor whiteColor]];
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_scrollView addSubview:saveButton];

    // 接收通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultFrame_id:) name:@"frame_id" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(historyFrame_id:) name:@"historyFrame_id" object:nil];
    
    ContentModel *model = trainClassArray[0];
    historyFrame_id     = model.sectionNumber;
   
    
}
#pragma mark - 接收frame_id
- (void)resultFrame_id:(NSNotification *)notification {
    
    frame_id = notification.userInfo[@"frame_id"];
    // 检查信息是否完整
    [self checkAllDataCompletion];
}
- (void)historyFrame_id:(NSNotification *)notification {
    
    historyFrame_id = notification.userInfo[@"frame_id"];
    
}


- (void)saveButtonClick:(UIButton *)button {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY - MM - dd"];
    NSDate *date1 = [dateFormatter dateFromString:timeTF.text];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[date1 timeIntervalSince1970]];
   
    NSLog(@"frame_id %@",frame_id);
    NSLog(@"resultNumber %@",resultNumber);
    
    NSString *url = [NSString stringWithFormat:@"%@/pad/?method=train.examine",BASEURL];
    
    NSDictionary *dataDict = @{@"framework_id":frame_id,
                               @"coach_id":coach_id,
                               @"result":resultNumber,
                               @"invigilation":personTF.text,
                               @"remark":remarkTV.text,
                               @"time":timeSp
                               };
    NSLog(@"dataDict %@",dataDict);
    [HttpTool postWithUrl:url params:dataDict contentType:CONTENTTYPE success:^(id responseObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    } fail:^(NSError *error) {}];
    
}

- (void)historyButtonClick:(UIButton *)button {
    NSLog(@"coach_id %@",coach_id);
    NSLog(@"historyFrame %@",historyFrame_id);
    
    
    historyCheckView *historyView = [[historyCheckView alloc] initWithFrame:CGRectMake(0,
                                                                                       0,
                                                                                       self.bounds.size.width,
                                                                                       self.bounds.size.height)
                                                                   coach_id:coach_id
                                                                   frame_id:historyFrame_id];
    [self addSubview:historyView];
}

- (void)showButtonClick:(UIButton *)button {
    [_scrollView addSubview:classView];
    /**
     *  默认
     */
    ContentModel *model = trainClassArray[0];
    frame_id            = model.sectionNumber;
    [button removeFromSuperview];
    
    
}

- (void)resultButtonClick:(UIButton *)button {
    
    trainResultSegment.tintColor = baseColor;
    trainResultSegment.selectedSegmentIndex = 0;
    resultNumber                = @"1"; //默认优
    [button removeFromSuperview];
}
#pragma mark - UISegmentedControl
-(void)segmentAction:(UISegmentedControl *)Seg {
    
    int Index = (int)Seg.selectedSegmentIndex;
    resultNumber = [NSString stringWithFormat:@"%d",Index + 1];
    // 检查信息是否完整
    [self checkAllDataCompletion];
}
#pragma mark - UITextFieldDelegate
// 输入框开始编辑时调用
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    if (textField.tag == 15) {
        NSString* date;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY - MM - dd"];
        date = [formatter stringFromDate:[NSDate date]];
        textField.text = date;
    }
    
    int lastTVHeight   = CGRectGetMaxY(textField.frame);
    int space          = 45 * 2; // 间隔
    int textViewHeight = 40;     // textView的高度
    int maxHeight      = lastTVHeight + space + textViewHeight;
   
    if (maxHeight > KeyHeightMax) {
        _scrollView.contentOffset = CGPointMake(0,maxHeight - KeyHeightMax);
    }

}
// 结束编辑时调用
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    textField.backgroundColor = [UIColor clearColor];
     _scrollView.contentOffset = CGPointMake(0, 0);
   
    // 检查信息是否完整
    [self checkAllDataCompletion];
}
#pragma mark - UITextViewDelegate
// 输入框开始编辑时调用
- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.backgroundColor = [UIColor colorWithRed:244/255.0
                                               green:244/255.0
                                                blue:244/255.0
                                               alpha:1];
    int lastTVHeight   = CGRectGetMaxY(textView.frame);
    int space          = 45 * 2; // 间隔
    int textViewHeight = 40;     // textView的高度
    int maxHeight      = lastTVHeight + space + textViewHeight;

    if (maxHeight > KeyHeightMax) {
        _scrollView.contentOffset = CGPointMake(0,maxHeight - KeyHeightMax);
    }

    
}
// 结束编辑时调用
- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.backgroundColor   = [UIColor clearColor];
     _scrollView.contentOffset = CGPointMake(0, 0);
    
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(410, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:20]} context:nil].size;
    CGRect textViewFrame      = textView.frame;
    textViewFrame.size.height = textSize.height + 15;
    textView.frame            = textViewFrame;
    
    int MaxHeight = self.bounds.size.height - 30 - 40;
    
    CGRect saveButtonFrame   = saveButton.frame;
    
    if (CGRectGetMaxY(remarkTV.frame) + 100 > MaxHeight) {
        saveButtonFrame.origin.y = CGRectGetMaxY(remarkTV.frame) + 100;
    } else {
        saveButtonFrame.origin.y = MaxHeight;
    }
    saveButton.frame = saveButtonFrame;
    
    if (CGRectGetMaxY(saveButton.frame) > self.bounds.size.height) {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, CGRectGetMaxY(saveButton.frame) + 100);
    } else {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }

}

- (void)checkAllDataCompletion {
   
    if (![coach_id isKindOfClass:[NSNull class]] && ![frame_id isKindOfClass:[NSNull class]] && ![timeTF.text isEqual:@""] && ![personTF.text isEqual:@""]) {
        NSLog(@"可以点击");
        saveButton.backgroundColor = baseColor;
        saveButton.userInteractionEnabled = YES;
    } else {
        NSLog(@"不可以点击");
        saveButton.backgroundColor = [UIColor lightGrayColor];
        saveButton.userInteractionEnabled = NO;
    }
}
@end
