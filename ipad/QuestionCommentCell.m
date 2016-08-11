//
//  QuestionCommentCell.m
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "QuestionCommentCell.h"
#import "QuestionContent.h"
@implementation QuestionCommentCell
{
    UIImageView *headImageView;
    UILabel     *nickNameLabel;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UILabel     *line;
    UIImageView *isCoachImageView;
     CGFloat      selfWidth;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        
        self.backgroundColor = [UIColor whiteColor];
        
       
        selfWidth            = viewWidth - (((viewHeight - 64) / 4) * 2);
        headImageView       = [UIImageView new];
        headImageView.frame = CGRectMake(13,
                                         13,
                                         47,
                                         47);
        headImageView.layer.cornerRadius  = headImageView.bounds.size.width / 2;
        headImageView.layer.masksToBounds = YES;
        [self addSubview:headImageView];
        
        isCoachImageView       = [UIImageView new];
        isCoachImageView.frame = CGRectMake(47, 40, 12, 20.4);
        isCoachImageView.image = [UIImage imageNamed:@"tabbarOrange_1"];
        [self addSubview:isCoachImageView];
        
        nickNameLabel       = [UILabel new];
        nickNameLabel.frame = CGRectMake(CGRectGetMaxX(headImageView.frame) + 10,
                                         CGRectGetMinY(headImageView.frame) + 10,
                                         150,
                                         18);
        nickNameLabel.textColor = [UIColor grayColor];
        nickNameLabel.font      = [UIFont fontWithName:FONT size:15];
        [self addSubview:nickNameLabel];
        
        
        
        timeLabel       = [UILabel new];
        timeLabel.frame = CGRectMake(CGRectGetMaxX(headImageView.frame) + 10,
                                     CGRectGetMaxY(nickNameLabel.frame),
                                     150,
                                     16);
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font      = [UIFont fontWithName:FONT size:10];
        [self addSubview:timeLabel];
        
        
        contentLabel           = [UILabel new];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font      = [UIFont fontWithName:FONT size:15];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        
        
        line                 = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
    }
    return self;
}

- (void)setContentModel:(QuestionContent *)contentModel {
    
    [headImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.comment_headimgString]];
    nickNameLabel.text = contentModel.comment_nickName;
    timeLabel.text     = contentModel.comment_time;
    
    CGSize contentSize = [contentModel.comment_content boundingRectWithSize:CGSizeMake(selfWidth- 13 - CGRectGetMaxX(headImageView.frame) - (5), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:16]} context:nil].size;
    
    contentLabel.frame = CGRectMake(CGRectGetMaxX(headImageView.frame) + (5),
                                    CGRectGetMaxY(timeLabel.frame) + 10,
                                    selfWidth-(13) - CGRectGetMaxX(headImageView.frame) - (5),
                                    contentSize.height);
    contentLabel.text  = contentModel.comment_content;
    
    line.frame = CGRectMake(0,
                            CGRectGetMaxY(contentLabel.frame) + (5),
                            viewWidth,
                            .5);
    
    CGRect CellFrame       = self.frame;
    CellFrame.size.height  = CGRectGetMaxY(line.frame);
    self.frame             = CellFrame;
    
}

@end
