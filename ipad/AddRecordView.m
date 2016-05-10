//
//  AddRecordView.m
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#define KeyHeightMax 398
#import "ContentModel.h"
#import "Content_Row_Model.h"
#import "AddRecordView.h"
#import "chooseClassView.h"
#import "HistoryTrainView.h"
@interface AddRecordView ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UITextField *trainPersonTF;
    UILabel     *studentFeedback;
    UITextView  *studentFeedbackTV;
    UILabel             *trainResult;
    UISegmentedControl  *trainResultSegment;
    NSMutableArray      *trainClassArray;
    UILabel     *completeCondition;
    UITextView  *completeConditionTV;
    UILabel     *remark;
    UITextView  *remarkTV;
    UIButton    *saveButton;
    NSString    *content_id;
    NSString    *coach_id;
    NSString    *resultNumber;
    
}
@end

@implementation AddRecordView
- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach
{
    self = [super initWithFrame:frame];
    if (self) {
        
        trainClassArray = [NSMutableArray array];
        trainClassArray = array;
        coach_id = coach;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 self.bounds.size.width,
                                                                 self.bounds.size.height)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    
    UIColor *baseColor = [UIColor colorWithRed:112/255.0
                                         green:199/255.0
                                          blue:243/255.0
                                         alpha:1];
    
    
    UILabel *trainClass  = [UILabel new];
    trainClass.frame     = CGRectMake(20, 30, 100, 20);
    trainClass.textColor = baseColor;
    trainClass.text          = @"培训课程";
    trainClass.font          = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:trainClass];
    
    
    
    chooseClassView *chooseView = [[chooseClassView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(trainClass.frame) + 20, trainClass.frame.origin.y - 5, 360, 30) superView:self trainClassArray:trainClassArray];
    chooseView.backgroundColor = [UIColor colorWithRed:112/255.0
                                           green:199/255.0
                                            blue:243/255.0
                                           alpha:1];
    [_scrollView addSubview:chooseView];
    
    
    UIButton *checkHistoryRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkHistoryRecord.frame     = CGRectMake(CGRectGetMaxX(chooseView.frame) + 20,
                                              trainClass.frame.origin.y - 5,
                                              120,
                                              30);
    checkHistoryRecord.backgroundColor = baseColor;
    [checkHistoryRecord setTintColor:[UIColor whiteColor]];
    [checkHistoryRecord setTitle:@"查看以往记录" forState:UIControlStateNormal];
    [checkHistoryRecord addTarget:self action:@selector(checkHistory:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:checkHistoryRecord];
    
    /*********培训人**********/
    UILabel *trainPerson  = [UILabel new];
    trainPerson.frame     = CGRectMake(20, CGRectGetMaxY(trainClass.frame) + 40, 100, 20);
    trainPerson.textColor = baseColor;
    trainPerson.text          = @"培训人:";
    trainPerson.font          = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:trainPerson];
    
    trainPersonTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(trainPerson.frame) + 23,CGRectGetMinY(trainPerson.frame)  - 5,300,30)];
    trainPersonTF.textColor    = baseColor;
    trainPersonTF.font         = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    trainPersonTF.delegate     = self;
    [_scrollView addSubview:trainPersonTF];
    
    /*********学员反馈**********/
    studentFeedback  = [UILabel new];
    studentFeedback.frame     = CGRectMake(20,
                                           CGRectGetMaxY(trainPerson.frame) + 30,
                                           100,
                                           20);
    studentFeedback.textColor = baseColor;
    studentFeedback.text      = @"学员反馈:";
    studentFeedback.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:studentFeedback];
    
    studentFeedbackTV           = [UITextView new];
    // - 5 为了字体对齐
    studentFeedbackTV.frame     = CGRectMake(CGRectGetMinX(trainPersonTF.frame) - 5,
                                             CGRectGetMinY(studentFeedback.frame) - 10,
                                             450,
                                             40);
    studentFeedbackTV.textColor = baseColor;
    studentFeedbackTV.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    studentFeedbackTV.delegate  = self;
    [_scrollView addSubview:studentFeedbackTV];
    
    /*********培训结果**********/
    trainResult           = [UILabel new];
    trainResult.frame     = CGRectMake(20,
                                       CGRectGetMaxY(studentFeedbackTV.frame) + 30,
                                       100,
                                       20);
    
    trainResult.textColor = baseColor;
    trainResult.text      = @"培训结果:";
    trainResult.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:trainResult];
    
    NSArray *trainResultArray = @[@"优",@"良",@"中",@"差"];
    trainResultSegment           = [[UISegmentedControl alloc] initWithItems:trainResultArray];
    trainResultSegment.frame     = CGRectMake(CGRectGetMinX(studentFeedbackTV.frame),
                                              CGRectGetMinY(trainResult.frame) - 5,
                                              200,
                                              30);
    trainResultSegment.tintColor = [UIColor clearColor];
    [trainResultSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:trainResultSegment];
    UIButton *trainResultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    trainResultButton.frame     = CGRectMake(CGRectGetMinX(studentFeedbackTV.frame),
                                             CGRectGetMinY(trainResult.frame) - 5,
                                             200,
                                             30);
    [trainResultButton addTarget:self action:@selector(setTrainResult:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:trainResultButton];
    
   
    
    /*********当日培训完成情况**********/
    completeCondition       = [UILabel new];
    completeCondition.frame = CGRectMake(20,
                                         CGRectGetMaxY(trainResultButton.frame) + 30,
                                         100,
                                         45);
    completeCondition.numberOfLines = 2;
    completeCondition.textColor = baseColor;
    completeCondition.text      = @"当日培训完成情况:";
    completeCondition.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:completeCondition];
    
    completeConditionTV           = [UITextView new];
    completeConditionTV.frame     = CGRectMake(CGRectGetMinX(trainResultButton.frame),
                                               CGRectGetMinY(completeCondition.frame),
                                               450,
                                               40);
    completeConditionTV.textColor = baseColor;
    completeConditionTV.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    completeConditionTV.delegate  = self;
    [_scrollView addSubview:completeConditionTV];
    
    /*********备注**********/
    remark       = [UILabel new];
    remark.frame = CGRectMake(20,
                              CGRectGetMaxY(completeConditionTV.frame) + 40,
                              100,
                              20);
    remark.textColor = baseColor;
    remark.text      = @"备注:";
    remark.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [_scrollView addSubview:remark];
    
    remarkTV           = [UITextView new];
    remarkTV.frame     = CGRectMake(CGRectGetMinX(completeConditionTV.frame),
                                    CGRectGetMinY(remark.frame) - 10,
                                    450,
                                    40);
    remarkTV.textColor = baseColor;
    remarkTV.font      = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    remarkTV.delegate  = self;
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
    [saveButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_scrollView addSubview:saveButton];
    
    // 接收通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultContent_id:) name:@"content_id" object:nil];
    
    
    /**
     *  默认  
     *
     *  培训课程为大纲一 Day.1
     *  培训结果为优
     */
    ContentModel *model         = trainClassArray[0];
    Content_Row_Model *rowModel = model.rowArray[0];
    content_id   = rowModel.row_number;
    resultNumber = @"1";
    
}

#pragma mark - 接收content_id
- (void)resultContent_id:(NSNotification *)notification {
    
    content_id = notification.userInfo[@"content_id"];
}

#pragma mark - 保存所有数据
- (void)saveButton:(UIButton *)button {
    
    NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    
    NSDictionary *dataDict = @{@"content_id":content_id,
                               @"coach_id":coach_id,
                               @"training_coach":trainPersonTF.text,
                               @"feedback":studentFeedbackTV.text,
                               @"result":resultNumber,
                               @"progress":completeConditionTV.text,
                               @"remark":remarkTV.text,
                               @"time":time
                               };
    NSString *url = [NSString stringWithFormat:@"%@/pad/?method=train.recard",BASEURL];
    [HttpTool postWithUrl:url params:dataDict contentType:CONTENTTYPE success:^(id responseObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    } fail:^(NSError *error) {}];
}
- (void)checkHistory:(UIButton *)button {
    NSLog(@"点击了查看历史记录");
   
    HistoryTrainView *history = [[HistoryTrainView alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   self.bounds.size.width,
                                                                                   self.bounds.size.height)
                                                        trainClassArray:trainClassArray coach_id:coach_id];
//    [UIView animateWithDuration:.5 animations:^{
//        CGRect rect    = history.frame;
//        rect.origin.x -= self.bounds.size.width;
//        
//        history.frame = rect;
//    }];
   
    [self addSubview:history];
    
}

#pragma mark - 培训结果点击事件
- (void)setTrainResult:(UIButton *)button {
    NSLog(@"点击了按钮");
    trainResultSegment.tintColor = [UIColor colorWithRed:112/255.0
                                                   green:199/255.0
                                                    blue:243/255.0
                                                   alpha:1];
    [button removeFromSuperview];
    
    // 检查信息是否完整
    [self checkAllDataCompletion];
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
    
}
// 结束编辑时调用
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    textField.backgroundColor = [UIColor clearColor];
    
    // 检查信息是否完整
    [self checkAllDataCompletion];
}
#pragma mark - UITextViewDelegate
// 输入框开始编辑时调用
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    textView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
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
    
    textView.backgroundColor = [UIColor clearColor];
    /**
     *  根据字数重新布局范围
     */
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(450, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:20]} context:nil].size;
    CGRect textViewFrame      = textView.frame;
    textViewFrame.size.height = textSize.height + 15;
    textView.frame            = textViewFrame;
    
    // 重新布局textView的范围
    [self setTextViewFrameWithHeight:textViewFrame.size.height];
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    // 检查信息是否完整
    [self checkAllDataCompletion];
}
// 重新布局textView的范围
- (void)setTextViewFrameWithHeight:(CGFloat )height {
    
    trainResult.frame     = CGRectMake(20,
                                       CGRectGetMaxY(studentFeedbackTV.frame) + 30,
                                       100,
                                       20);
    
    CGRect trainResultTVFrame   = trainResultSegment.frame;
    trainResultTVFrame.origin.y = CGRectGetMinY(trainResult.frame) - 5,
    trainResultSegment.frame         = trainResultTVFrame;
    
    
    completeCondition.frame = CGRectMake(20,
                                         CGRectGetMaxY(trainResultSegment.frame) + 30,
                                         100,
                                         45);
    CGRect completeConditionTVFrame   = completeConditionTV.frame;
    completeConditionTVFrame.origin.y = CGRectGetMinY(completeCondition.frame) - 10,
    completeConditionTV.frame         = completeConditionTVFrame;
    
    
    remark.frame = CGRectMake(20,
                              CGRectGetMaxY(completeConditionTV.frame) + 40,
                              100,
                              20);
    CGRect remarkTVFrame   = remarkTV.frame;
    remarkTVFrame.origin.y = CGRectGetMinY(remark.frame) - 10,
    remarkTV.frame         = remarkTVFrame;
    
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
    NSLog(@"coach_id %@ content_id %@ trainPersonTF %@ studentFeedbackTV %@ resultNumber %@ completeConditionTV %@ ",coach_id,content_id,trainPersonTF.text,studentFeedbackTV.text,resultNumber,completeConditionTV.text);
    
    if (![coach_id isKindOfClass:[NSNull class]] && ![content_id isKindOfClass:[NSNull class]] && ![trainPersonTF.text isEqual:@""] && ![studentFeedbackTV.text isEqualToString:@""] && ![resultNumber isEqualToString:@""] && ![completeConditionTV.text isEqualToString:@""] ) {
        NSLog(@"可以点击");
        saveButton.backgroundColor = [UIColor colorWithRed:112/255.0
                                                     green:199/255.0
                                                      blue:243/255.0
                                                     alpha:1];
        saveButton.userInteractionEnabled = YES;
    } else {
        NSLog(@"不可以点击");
        saveButton.backgroundColor = [UIColor lightGrayColor];
        saveButton.userInteractionEnabled = NO;
    }
}

@end
