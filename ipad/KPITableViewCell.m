//
//  KPITableViewCell.m
//  ipad
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "KPITableViewCell.h"

@implementation KPITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        self.backgroundColor = [UIColor colorWithRed:235/255.0
                                               green:6/255.0
                                                blue:150/255.0
                                               alpha:1];
        CGFloat viewheight = viewHeight-64;
        self.frame         = CGRectMake(0, 0, viewWidth-viewheight/4 - 60, 44);
        CGFloat width      = self.bounds.size.width / 5;
        
       
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(2,
                                                                   1,
                                                                   width - 2,
                                                                   self.bounds.size.height - 2)];
        self.dateLabel.backgroundColor = [UIColor whiteColor];
        self.dateLabel.textColor       = [UIColor grayColor];
        self.dateLabel.textAlignment   = 1;
        self.dateLabel.font            = [UIFont fontWithName: FONT size:19];
        [self addSubview:self.dateLabel];
        
        self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.dateLabel.frame) + 1,
                                                                    1,
                                                                    width - 2,
                                                                    self.bounds.size.height- 2)];
        self.classLabel.backgroundColor = [UIColor whiteColor];
        self.classLabel.textColor       = [UIColor grayColor];
        self.classLabel.textAlignment   = 1;
        self.classLabel.font            = [UIFont fontWithName: FONT size:19];
        [self addSubview:self.classLabel];
        
        self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.classLabel.frame) + 1,
                                                                     1,
                                                                     width - 2,
                                                                     self.bounds.size.height- 2)];
        self.personLabel.backgroundColor = [UIColor whiteColor];
        self.personLabel.textColor       = [UIColor grayColor];
        self.personLabel.textAlignment   = 1;
        self.personLabel.font            = [UIFont fontWithName: FONT size:19];
        [self addSubview:self.personLabel];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.personLabel.frame) + 1,
                                                                    1,
                                                                    width - 2,
                                                                    self.bounds.size.height- 2)];
        self.moneyLabel.backgroundColor = [UIColor whiteColor];
        self.moneyLabel.textColor       = [UIColor grayColor];
        self.moneyLabel.textAlignment   = 1;
        self.moneyLabel.font            = [UIFont fontWithName: FONT size:19];
        [self addSubview:self.moneyLabel];
        
        self.obtain_moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame) + 1,
                                                                           1,
                                                                           width ,
                                                                           self.bounds.size.height- 2)];
        self.obtain_moneyLabel.backgroundColor = [UIColor whiteColor];
        self.obtain_moneyLabel.textColor       = [UIColor grayColor];
        self.obtain_moneyLabel.textAlignment   = 1;
        self.obtain_moneyLabel.font            = [UIFont fontWithName: FONT size:19];
        [self addSubview:self.obtain_moneyLabel];
        
    }
    return self;
}

@end
