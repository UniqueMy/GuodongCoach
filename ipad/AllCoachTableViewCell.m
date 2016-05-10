//
//  AllCoachTableViewCell.m
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "AllCoachTableViewCell.h"

@implementation AllCoachTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        self.contentLabel       = [UILabel new];
        self.contentLabel.frame = CGRectMake(0,
                                      0,
                                      130,
                                      self.bounds.size.height);
        
        self.contentLabel.textAlignment = 1;
        self.contentLabel.textColor     = [UIColor grayColor];
        self.contentLabel.font          = [UIFont fontWithName:FONT size:20];
        [self addSubview:self.contentLabel];
    }
    return self;
}



@end
