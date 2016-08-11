//
//  QuestionReplyCell.m
//
//
//  Created by mac on 16/6/6.
//
//
#import "UIImageView+WebCache.h"
#import "QuestionReplyCell.h"
#import "QuestionReply.h"


@implementation QuestionReplyCell
{
    UIImageView *headImageView;
    UILabel     *nickNameLabel;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UILabel     *targetLabel;
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
        
        targetLabel           = [UILabel new];
        targetLabel.font      = [UIFont fontWithName:FONT size:15];
        [self addSubview:targetLabel];
        
        
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

- (void)setReply:(QuestionReply *)reply {
    
   
   
    [headImageView sd_setImageWithURL:[NSURL URLWithString:reply.sourceHeadImg]];
    nickNameLabel.text = reply.sourceName;
    timeLabel.text     = reply.timeString;
    
    if ([reply.isCoach isEqualToString:@"2"]) {
        [headImageView addSubview:isCoachImageView];
    }
    
    NSString *target = [NSString stringWithFormat:@"回复%@:",reply.targetName];
    
    CGSize targetSize = [target sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:16]}];
    targetLabel.frame = CGRectMake(CGRectGetMaxX(headImageView.frame) + (5),
                                   CGRectGetMaxY(headImageView.frame) + (5),
                                   targetSize.width,
                                   16);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:target];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:33/255.0 green:155/255.0 blue:131/255.0 alpha:1] range:NSMakeRange(2,reply.targetName.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(2+reply.targetName.length,1)];
    targetLabel.attributedText = str;
    
    
    CGSize contentSize = [reply.content boundingRectWithSize:CGSizeMake(viewWidth-(13) - CGRectGetMaxX(headImageView.frame) - (5), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:(13)]} context:nil].size;
    
    contentLabel.frame = CGRectMake(CGRectGetMaxX(targetLabel.frame),
                                    CGRectGetMaxY(headImageView.frame) + (5),
                                    viewWidth-(13) - CGRectGetMaxX(headImageView.frame) - (5),
                                    contentSize.height);
    contentLabel.text  = reply.content;
    
    line.frame = CGRectMake(0,
                            CGRectGetMaxY(contentLabel.frame) + (5),
                            viewWidth,
                            .5);
    
    CGRect CellFrame       = self.frame;
    CellFrame.size.height  = CGRectGetMaxY(line.frame);
    self.frame             = CellFrame;
}
@end
