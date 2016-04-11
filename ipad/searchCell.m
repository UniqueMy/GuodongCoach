//
//  searchCell.m
//  ipad
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell
// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 60)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:FONT size:30];
        [self addSubview:self.nameLabel];
        
        self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 100, 60)];
        self.ageLabel.textColor = [UIColor whiteColor];
        self.ageLabel.font = [UIFont systemFontOfSize: 30];
        [self addSubview:self.ageLabel];
        
        
        self.address = [[UILabel alloc] initWithFrame:CGRectMake(300, 10, 250, 60)];
        self.address.textColor = [UIColor whiteColor];
        self.address.font = [UIFont fontWithName:FONT size:30];
        [self addSubview:self.address];
    }
    return self;
}

@end
