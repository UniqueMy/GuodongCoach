//
//  HistoryCheckTableViewCell.m
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//
#import "historyCheckModel.h"
#import "HistoryCheckTableViewCell.h"

@implementation HistoryCheckTableViewCell
{
    UIColor *baseColor;
    UIFont  *baseFont;
    UILabel *timeLabel;
    UILabel *classLabel;
    UILabel *resultLabel;
    UILabel *personLabel;
    UILabel *remarkLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        baseColor = [UIColor colorWithRed:158/255.0
                                    green:127/255.0
                                     blue:180/255.0
                                    alpha:1];
        
        baseFont = [UIFont fontWithName:@"Arial-BoldMT" size:19];
        
        /******************************************************/
        
        NSArray *labelArray = @[@"考核时间:",@"考核大纲:",@"考核成绩:",@"监考人:",@"备    注:"];
        for (int a = 0; a < 5; a++) {
            UILabel *label  = [UILabel new];
            label.textColor = baseColor;
            label.frame     = CGRectMake(40,  25 + a*50, 120, 20);
            label.font      = baseFont;
            label.text      = labelArray[a];
            [self addSubview:label];
            
        }
        
        timeLabel           = [UILabel new];
        timeLabel.textColor = baseColor;
        timeLabel.font      = baseFont;
        timeLabel.frame     = CGRectMake(160, 25, 450, 20);
        [self addSubview:timeLabel];
        
        classLabel           = [UILabel new];
        classLabel.textColor = baseColor;
        classLabel.font      = baseFont;
        classLabel.frame     = CGRectMake(160, CGRectGetMaxY(timeLabel.frame) + 30, 450, 20);
        [self addSubview:classLabel];
        
        resultLabel           = [UILabel new];
        resultLabel.textColor = baseColor;
        resultLabel.font      = baseFont;
        resultLabel.frame     = CGRectMake(160, CGRectGetMaxY(classLabel.frame) + 30, 450, 20);
        [self addSubview:resultLabel];
        
        personLabel           = [UILabel new];
        personLabel.textColor = baseColor;
        personLabel.font      = baseFont;
        personLabel.frame     = CGRectMake(160, CGRectGetMaxY(resultLabel.frame) + 30, 450, 20);
        [self addSubview:personLabel];
        
        remarkLabel           = [UILabel new];
        remarkLabel.textColor = baseColor;
        remarkLabel.font      = baseFont;
        remarkLabel.frame     = CGRectMake(160, CGRectGetMaxY(personLabel.frame) + 30, 420, 20);
        [self addSubview:remarkLabel];
        
        
    }
     return self;
}

- (void)setHistoryModel:(historyCheckModel *)historyModel {
   
    
    
    timeLabel.text   = historyModel.time;
    classLabel.text  = historyModel.className;
    resultLabel.text = historyModel.result;
    personLabel.text = historyModel.invigilation;
    
    
    CGSize remarkSize = [historyModel.remark boundingRectWithSize:CGSizeMake(420, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:20]} context:nil].size;
    CGRect remarkFrame        = remarkLabel.frame;
    remarkLabel.numberOfLines = 0;
    remarkFrame.size.height   = remarkSize.height;
    remarkLabel.frame         = remarkFrame;
    remarkLabel.text          = historyModel.remark;
    
    self.height = CGRectGetMaxY(remarkLabel.frame) + 15;
    NSLog(@"height %f",self.height);
    
    
}
@end
