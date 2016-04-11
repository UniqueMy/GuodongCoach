//
//  historyCell.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "historyCell.h"
@implementation historyCell
// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        self.textdate = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 300, 80)];
        NSString *date = @"2015/2/6";
        self.textdate.text = [NSString stringWithFormat:@"测试时间：   %@",date];
        self.textdate.textColor = [UIColor whiteColor];
        self.textdate.font = [UIFont fontWithName:FONT size:30];
        [self addSubview:self.textdate];
        
        self.jiaolian = [[UILabel alloc] initWithFrame:CGRectMake(450, 20, 300, 80)];
        NSString *jiaolian = @"陈菲菲";
        self.jiaolian.text = [NSString stringWithFormat:@"教练员：   %@",jiaolian];
        self.jiaolian.textColor = [UIColor whiteColor];
        self.jiaolian.font = [UIFont fontWithName:FONT size:30];
        [self addSubview:self.jiaolian];
        
        UIImageView *jiantouImage = [[UIImageView alloc] initWithFrame:CGRectMake(900, 50, 20, 20)];
        jiantouImage.image = [UIImage imageNamed:@"jiantou"];
        jiantouImage.userInteractionEnabled = YES;
        [self addSubview:jiantouImage];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 119, 920, 1)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        
        
    }
    return self;
}

@end
