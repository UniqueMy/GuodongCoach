//
//  HistoryTableViewCell.m
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell{
    UILabel *showTrainClass;
    UILabel *trainPerson,      *showTrainPerson;
    UILabel *coachName,        *showCoachName;
    UILabel *studentFeedback,  *showStudentFeedback;
    
    UILabel *trainResult,      *showtrainResult;
    UILabel *completeCondition,*showCompleteCondition;
    UILabel *remark,           *showRemark;
    UILabel *line;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIColor *baseColor = [UIColor colorWithRed:112/255.0
                                             green:199/255.0
                                              blue:243/255.0
                                             alpha:1];
        UIFont *font       = [UIFont fontWithName:@"Arial-BoldMT" size:19];
        
        
        UILabel *trainClass  = [UILabel new];
        trainClass.frame     = CGRectMake(0, 0, 100, 20);
        trainClass.textColor = baseColor;
        trainClass.text          = @"培训课程:";
        trainClass.font          = font;
        [self addSubview:trainClass];
        
        showTrainClass       = [UILabel new];
        showTrainClass.frame = CGRectMake(CGRectGetMaxX(trainClass.frame) + 23,
                                           CGRectGetMinY(trainClass.frame),
                                           300,
                                           20);
        showTrainClass.textColor = baseColor;
        showTrainClass.text      =  @"【大纲一】.Day.1";
        showTrainClass.font      = font;
        [self addSubview:showTrainClass];
        
        trainPerson  = [UILabel new];
        trainPerson.frame     = CGRectMake(0,
                                           CGRectGetMaxY(trainClass.frame) + 30, 100, 20);
        trainPerson.textColor = baseColor;
        trainPerson.text          = @"培训人:";
        trainPerson.font          = font;
        [self addSubview:trainPerson];
        
        showTrainPerson       = [UILabel new];
        showTrainPerson.frame = CGRectMake(CGRectGetMaxX(trainPerson.frame) + 23,
                                           CGRectGetMinY(trainPerson.frame),
                                           300,
                                           20);
        showTrainPerson.textColor = baseColor;
        showTrainPerson.text      = @"LiYin";
        showTrainPerson.font      = font;
        [self addSubview:showTrainPerson];
        
        
        coachName           = [UILabel new];
        coachName.frame     = CGRectMake(0,
                                         CGRectGetMaxY(trainPerson.frame) + 30,
                                         100,
                                         20);
        coachName.textColor = baseColor;
        coachName.text          = @"教练:";
        coachName.font          = font;
        [self addSubview:coachName];
        
        
        showCoachName       = [UILabel new];
        showCoachName.frame = CGRectMake(CGRectGetMaxX(coachName.frame) + 23,
                                         CGRectGetMinY(coachName.frame),
                                         300,
                                         20);
        showCoachName.textColor = baseColor;
        showCoachName.font      = font;
        showCoachName.text      = @"教练";
        [self addSubview:showCoachName];
        
        studentFeedback  = [UILabel new];
        studentFeedback.frame     = CGRectMake(0,
                                               CGRectGetMaxY(coachName.frame) + 30,
                                               100,
                                               20);
        studentFeedback.textColor = baseColor;
        studentFeedback.text      = @"学员反馈:";
        studentFeedback.font      = font;
        [self addSubview:studentFeedback];
        
        
        showStudentFeedback = [UILabel new];
        showStudentFeedback.frame     = CGRectMake(CGRectGetMinX(showCoachName.frame),
                                                 CGRectGetMinY(studentFeedback.frame),
                                                 450,
                                                 20);
        showStudentFeedback.textColor = baseColor;
        showStudentFeedback.font      = font;
        showStudentFeedback.numberOfLines = 0;
        showStudentFeedback.text      = @"学员反馈";
        [self addSubview:showStudentFeedback];
        
        
        trainResult           = [UILabel new];
        trainResult.frame     = CGRectMake(0,
                                           CGRectGetMaxY(showStudentFeedback.frame) + 30,
                                           100,
                                           20);
        trainResult.textColor = baseColor;
        trainResult.text      = @"培训结果:";
        trainResult.font      = font;
        [self addSubview:trainResult];
        
        
        showtrainResult = [UILabel new];
        showtrainResult.frame = CGRectMake(CGRectGetMinX(showStudentFeedback.frame),
                                           CGRectGetMinY(trainResult.frame),
                                           200,
                                           20);
        showtrainResult.textColor = baseColor;
        showtrainResult.font      = font;
        showtrainResult.text      = @"培训结果";
        showtrainResult.numberOfLines = 0;
        [self addSubview:showtrainResult];
        
        completeCondition       = [UILabel new];
        completeCondition.frame = CGRectMake(0,
                                             CGRectGetMaxY(showtrainResult.frame) + 30,
                                             100,
                                             45);
        completeCondition.numberOfLines = 2;
        completeCondition.textColor = baseColor;
        completeCondition.text      = @"当日培训完成情况:";
        completeCondition.font      = font;
        [self addSubview:completeCondition];
        
        showCompleteCondition       = [UILabel new];
        showCompleteCondition.frame = CGRectMake(CGRectGetMinX(showtrainResult.frame),
                                                 CGRectGetMinY(completeCondition.frame),
                                                 450,
                                                 20);
        showCompleteCondition.textColor = baseColor;
        showCompleteCondition.font      = font;
        showCompleteCondition.text      = @"当日培训完成情况";
        showCompleteCondition.numberOfLines = 0;
        [self addSubview:showCompleteCondition];
        
        remark       = [UILabel new];
        remark.frame = CGRectMake(0,
                                  CGRectGetMaxY(showCompleteCondition.frame) + 40,
                                  100,
                                  20);
        remark.textColor = baseColor;
        remark.text      = @"备注:";
        remark.font      = font;
        [self addSubview:remark];
        
        showRemark       = [UILabel new];
        showRemark.frame = CGRectMake(CGRectGetMinX(showCompleteCondition.frame),
                                      CGRectGetMinY(remark.frame),
                                      450,
                                      20);
        showRemark.textColor = baseColor;
        showRemark.font      = font;
        showRemark.numberOfLines = 0;
        showRemark.text      = @"备注";
        [self addSubview:showRemark];

        line = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

- (void)setHistoryComment:(HistoryModel *)historyComment {
    
     UIFont *font        = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    
    showTrainClass.text  = historyComment.trainClass;
    showTrainPerson.text = historyComment.trainPerson;
    showCoachName.text       = historyComment.coachName;
   
    // 学员反馈
     CGSize feedbackSize = [historyComment.studentFeedback boundingRectWithSize:CGSizeMake(450, MAXFLOAT)
                                                                        options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font}
                                                                        context:nil].size;
    CGRect feedbackFrame      = showStudentFeedback.frame;
    feedbackFrame.size.height = feedbackSize.height;
    showStudentFeedback.frame = feedbackFrame;
    showStudentFeedback.text  = historyComment.studentFeedback;
    
    // 培训结果
    trainResult.frame     = CGRectMake(0,
                                       CGRectGetMaxY(showStudentFeedback.frame) + 30,
                                       100,
                                       20);
    showtrainResult.frame = CGRectMake(CGRectGetMinX(showStudentFeedback.frame),
                                       CGRectGetMinY(trainResult.frame),
                                       200,
                                       20);
   
    showtrainResult.text    = historyComment.trainResult;
    completeCondition.frame = CGRectMake(0,
                                         CGRectGetMaxY(showtrainResult.frame) + 30,
                                         100,
                                         45);
    
    showCompleteCondition.frame = CGRectMake(CGRectGetMinX(showtrainResult.frame),
                                             CGRectGetMinY(completeCondition.frame),
                                             450,
                                             20);
    CGSize completeConditionSize = [historyComment.completeCondition boundingRectWithSize:CGSizeMake(450, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGRect completeConditionFrame      = showCompleteCondition.frame;
    completeConditionFrame.size.height = completeConditionSize.height;
    showCompleteCondition.frame        = completeConditionFrame;
    showCompleteCondition.text         = historyComment.completeCondition;
    
    
    remark.frame = CGRectMake(0,
                              CGRectGetMaxY(showCompleteCondition.frame) + 40,
                              100,
                              20);
    showRemark.frame = CGRectMake(CGRectGetMinX(showCompleteCondition.frame),
                                  CGRectGetMinY(remark.frame),
                                  450,
                                  20);
    
    CGSize remarkSize = [historyComment.remark boundingRectWithSize:CGSizeMake(450, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGRect showRemarkFrame      = showRemark.frame;
    showRemarkFrame.size.height = remarkSize.height;
    showRemark.frame            = showRemarkFrame;
    showRemark.text             = historyComment.remark;
    
   
   
    line.frame    = CGRectMake(0, CGRectGetMaxY(showRemark.frame) + 5, 700, .5);
   
    self.height = CGRectGetMaxY(line.frame) + 10;
    
}
@end
