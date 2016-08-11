//
//  QuestionContentCell.m
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "QuestionContentCell.h"
#import "QuestionContent.h"
@implementation QuestionContentCell
{
    UIImageView *headImageView;
    UILabel     *nickNameLabel;
    UILabel     *timeLabel;
    UILabel     *contentLabel;
    UIImageView *contentImageView;
    UILabel     *line;
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
        headImageView.frame = CGRectMake(13, 13, 47, 47);
        headImageView.layer.cornerRadius  = headImageView.bounds.size.width / 2;
        headImageView.layer.masksToBounds = YES;
        [self addSubview:headImageView];
        
        nickNameLabel       = [UILabel new];
        nickNameLabel.frame = CGRectMake(CGRectGetMaxX(headImageView.frame) + 10,
                                         30,
                                         200,
                                         18);
        nickNameLabel.font  = [UIFont fontWithName:FONT size:(15)];
        nickNameLabel.textColor = [UIColor grayColor];
        [self addSubview:nickNameLabel];
        
        timeLabel       = [UILabel new];
        timeLabel.frame = CGRectMake(selfWidth - 163,
                                     CGRectGetMinY(nickNameLabel.frame),
                                     150,
                                     15);
        timeLabel.font  = [UIFont fontWithName:FONT size:14];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = 2;
        [self addSubview:timeLabel];
        
        contentLabel           = [UILabel new];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font      = [UIFont fontWithName:FONT size:14];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        
        line                 = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        
    }
    return self;
}


- (void)setContentModel:(QuestionContent *)contentModel {
    
    
    [headImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.headImgString]];
    nickNameLabel.text = contentModel.nickName;
    timeLabel.text     = contentModel.timeString;
    
    CGSize contentSize = [contentModel.content boundingRectWithSize:CGSizeMake(selfWidth - 26, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:15]} context:nil].size;
    
    contentLabel.frame = CGRectMake(13,
                                    CGRectGetMaxY(headImageView.frame) +10,
                                    selfWidth - 26,
                                    contentSize.height);
    contentLabel.text  = contentModel.content;
    
    
    CGFloat imageWidth    = (selfWidth - 52) / 3;
    CGRect  CellFrame     = self.frame;
    CGFloat imageViewMaxY = 0;
    
    for (int a = 0; a < 9; a++) {
        
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake((13) + (a%3)*(imageWidth + (5)),
                                     CGRectGetMaxY(contentLabel.frame) +(5)+(a/3)*(imageWidth + (5)),
                                     imageWidth,
                                     imageWidth);
        
        imageView.tag = 10 + a;
        [self addSubview:imageView];
    }
    
    for (int a = 0; a < 9; a++) {
        UIImageView *tapImageView = (UIImageView*)[self viewWithTag:10 + a];
        if (a < contentModel.photoArray.count) {
            tapImageView.hidden = NO;
            [tapImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.photoArray[a]]];
        } else {
            tapImageView.hidden = YES;
        }
    }
    
    
    if (contentModel.photoArray.count % 3 == 0) {
        imageViewMaxY  = (imageWidth + (5)) *((contentModel.photoArray.count/3));
    } else {
        imageViewMaxY  = (imageWidth + (5)) *((contentModel.photoArray.count/3) + 1);
    }
    
    

    
    line.frame = CGRectMake(0,
                            CGRectGetMaxY(contentLabel.frame) + (5) +imageViewMaxY,
                            viewWidth,
                            .5);
    
   
   CellFrame.size.height  = CGRectGetMaxY(line.frame);
    self.frame            = CellFrame;
}

@end
