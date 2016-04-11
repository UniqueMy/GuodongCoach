//
//  XQTableViewCell.m
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "XQTableViewCell.h"
#import "XQComment.h"
@implementation XQTableViewCell
{
    
}

// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubview];
        
    }
    return self;
}
-(void)initSubview
{
    // 把自定义的控件 变成了单元格的属性
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 300, 30)];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.dateLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 20, 300, 30)];
   
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.timeLabel];
    
    self.jiaolianLabel = [[UILabel alloc] initWithFrame:CGRectMake(670, 20, 300, 30)];
    
    self.jiaolianLabel.textColor = [UIColor whiteColor];
    self.jiaolianLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.jiaolianLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 924, 30)];
   
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.contentLabel];
    
    self.xinlvLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 300, 30)];
    
    self.xinlvLabel.textColor = [UIColor whiteColor];
    self.xinlvLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.xinlvLabel];
    
    self.biaoxianLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 60, 300, 30)];
    self.biaoxianLabel.textColor = [UIColor whiteColor];
    self.biaoxianLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.biaoxianLabel];
    
    self.reqingLabel = [[UILabel alloc] initWithFrame:CGRectMake(670, 60, 300, 30)];
    self.reqingLabel.textColor = [UIColor whiteColor];
    self.reqingLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.reqingLabel];
    
     self.labelArray = [NSMutableArray array];
    

    self.jibinLabel           = [UILabel new];
    self.jibinLabel.numberOfLines = 0;
    self.jibinLabel.textColor = [UIColor whiteColor];
    self.jibinLabel.font      = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.jibinLabel];
    [self.labelArray addObject:self.jibinLabel];
    
    self.likeLabel           = [UILabel new];
    self.likeLabel.numberOfLines = 0;
    self.likeLabel.textColor = [UIColor whiteColor];
    self.likeLabel.font      = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.likeLabel];
    [self.labelArray addObject:self.likeLabel];
    
    self.jinjiLabel = [UILabel new];
    self.jinjiLabel.numberOfLines = 0;
    self.jinjiLabel.textColor = [UIColor whiteColor];
    self.jinjiLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.jinjiLabel];
    [self.labelArray addObject:self.jinjiLabel];
    
    self.neirongLabel = [UILabel new];
    self.neirongLabel.numberOfLines = 0;
    self.neirongLabel.textColor = [UIColor whiteColor];
    self.neirongLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.neirongLabel];
    [self.labelArray addObject:self.neirongLabel];
    
    self.yinshiLabel = [UILabel new];
    self.yinshiLabel.numberOfLines = 0;
    self.yinshiLabel.textColor = [UIColor whiteColor];
    self.yinshiLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.yinshiLabel];
    [self.labelArray addObject:self.yinshiLabel];
    
    self.nextLabel = [UILabel new];
    self.nextLabel.numberOfLines = 0;
    self.nextLabel.textColor = [UIColor whiteColor];
    self.nextLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.nextLabel];
    [self.labelArray addObject:self.nextLabel];
    
    self.danyouLabel = [UILabel new];
    self.danyouLabel.numberOfLines = 0;
    self.danyouLabel.textColor = [UIColor whiteColor];
    self.danyouLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.danyouLabel];
    [self.labelArray addObject:self.danyouLabel];
    
    self.bianhuaLabel = [UILabel new];
    self.bianhuaLabel.numberOfLines = 0;
    self.bianhuaLabel.textColor = [UIColor whiteColor];
    self.bianhuaLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.bianhuaLabel];
    [self.labelArray addObject:self.bianhuaLabel];
    
    self.remarkLabel = [UILabel new];
    self.remarkLabel.numberOfLines = 0;
    self.remarkLabel.textColor = [UIColor whiteColor];
    self.remarkLabel.font = [UIFont fontWithName:FONT size:25];
    [self addSubview:self.remarkLabel];
    [self.labelArray addObject:self.remarkLabel];
    
   
    
    
}
-(void)setXqcomment:(XQComment *)xqcomment
{
    
   
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[xqcomment.date intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    self.dateLabel.text = [NSString stringWithFormat:@"日期:%@",confromTimespStr];
    
    self.timeLabel.text = [NSString stringWithFormat:@"时长:%@小时",xqcomment.time];;
    self.jiaolianLabel.text = [NSString stringWithFormat:@"教练:%@",xqcomment.coach];
    self.contentLabel.text = [NSString stringWithFormat:@"内容:%@",xqcomment.content];
    self.xinlvLabel.text = [NSString stringWithFormat:@"最高心率:%@",xqcomment.heart_rate];
    
    
    NSArray *array = @[@"一般",@"良好",@"活跃"];
    self.reqingLabel.text = [NSString stringWithFormat:@"会员热情度:%@",array[[xqcomment.enthusiasm intValue]]];
    self.biaoxianLabel.text = [NSString stringWithFormat:@"运动表现:%@",array[[xqcomment.expression intValue]]];

     
    
    int height  = 140;
    for (int a = 0; a < xqcomment.remarkArray.count; a++) {
        UILabel  *label     = self.labelArray[a];
        NSString *content   = [xqcomment.remarkArray[a] objectForKey:@"content"];
        NSString *title     = [xqcomment.remarkArray[a] objectForKey:@"title"];
        NSString *text      = [NSString stringWithFormat:@"%@:   %@",title,content];
        label.text          = text;
      //  NSLog(@"text %@",title);
        CGSize textSize      = [text boundingRectWithSize:CGSizeMake(viewWidth-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:26]} context:nil].size;
       
        if (textSize.height < 30)
        {
            label.frame     = CGRectMake(50, height, viewWidth-100, 30);
            
        } else {
            
            label.frame     = CGRectMake(50, height, textSize.width, textSize.height);
        }
        height = CGRectGetMaxY(label.frame) + 10;
        
    }
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, height + 10, viewWidth, 1)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:line];
    
    self.height = height + 10;
}
@end
