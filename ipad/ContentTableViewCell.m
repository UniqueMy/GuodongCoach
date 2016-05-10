//
//  ContentTableViewCell.m
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//
#import "Content_Row_Model.h"
#import "ContentTableViewCell.h"

@implementation ContentTableViewCell
// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        
        self.nameLabel           = [UILabel new];
        self.nameLabel.textColor = [UIColor grayColor];
        self.nameLabel.font      = [UIFont fontWithName:FONT size:16];
        self.nameLabel.frame     = CGRectMake(30, 0, self.bounds.size.width, 20);
        self.nameLabel.textAlignment = 0;
        [self addSubview:self.nameLabel];
        
        
        self.contentLabel           = [UILabel new];
        self.contentLabel.textColor = [UIColor grayColor];
        self.contentLabel.font      = [UIFont fontWithName:FONT size:16];
        self.contentLabel.textAlignment = 1;
        [self addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)setContentRowModel:(Content_Row_Model *)contentRowModel {
    
    // int height = 44;
    
    self.nameLabel.text  = contentRowModel.rowName;
    
    CGSize textSize      = [contentRowModel.content boundingRectWithSize:CGSizeMake(self.bounds.size.width - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT size:16]} context:nil].size;
    self.contentLabel.frame     = CGRectMake(30,
                                             CGRectGetMaxY(self.nameLabel.frame) + 5,
                                             textSize.width,
                                             textSize.height);
    
    self.contentLabel.text = contentRowModel.content;
    
    self.height = CGRectGetMaxY(self.contentLabel.frame) + 5;
    
}
@end
