//
//  dingdanCell.m
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "dingdanCell.h"
@implementation dingdanCell

// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 110, 20)];
        self.name.textColor = [UIColor whiteColor];
        self.name.text = @"陈菲菲";
     //   self.name.backgroundColor = [UIColor redColor];
        self.name.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.name];
        
        self.sex = [[UILabel alloc] initWithFrame:CGRectMake(180, 40, 40, 20)];
        self.sex.textColor = [UIColor whiteColor];
        self.sex.text = @"男";
        //self.sex.backgroundColor = [UIColor orangeColor];
        self.sex.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.sex];
        
        self.number = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 260, 20)];
        self.number.textColor = [UIColor whiteColor];
        NSString *dianhua = @"18289245331";
//        self.number.backgroundColor = [UIColor orangeColor];
        self.number.text = [NSString stringWithFormat:@"电话：%@",dianhua];
        self.number.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.number];

        self.classname = [[UILabel alloc] initWithFrame:CGRectMake(530, 40, 350, 20)];
        self.classname.textColor = [UIColor whiteColor];
        NSString *class = @"瑜伽";
        
        self.classname.text = [NSString stringWithFormat:@"课程：%@",class];
        self.classname.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.classname];
        
        self.address = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 700, 20)];
        self.address.textColor = [UIColor whiteColor];
      //  self.address.backgroundColor = [UIColor redColor];
        NSString *address = @"北京市朝阳区建国路珠江绿洲103室";
        self.address.text = [NSString stringWithFormat:@"住址：%@",address];
        self.address.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.address];
        
        self.date = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 400, 20)];
        self.date.textColor = [UIColor whiteColor];
        NSString *date = @"2015/2/6 10时";
        self.date.text = [NSString stringWithFormat:@"约课日期：%@",date];
        self.date.font = [UIFont fontWithName:FONT size: 27];
        [self addSubview:self.date];
        
        self.process = [[UILabel alloc] initWithFrame:CGRectMake(700, 100, 150, 20)];
        self.process.textColor = [UIColor redColor];
        self.process.textAlignment = 1;
        self.process.font = [UIFont fontWithName:FONT size:27];
        [self addSubview:self.process];
        
        self.classStyle = [[UILabel alloc] initWithFrame:CGRectMake(400, 150, 200, 20)];
        self.classStyle.text = [NSString stringWithFormat:@"类型：体验店"];
        self.classStyle.font = [UIFont fontWithName:FONT size:27];
        self.classStyle.textColor = [UIColor whiteColor];
        [self addSubview:self.classStyle];
        
        self.personNumber = [[UILabel alloc] initWithFrame:CGRectMake(600, 150, 200, 20)];
        self.personNumber.text = [NSString stringWithFormat:@"人数：2人"];
        self.personNumber.font = [UIFont fontWithName:FONT size:27];
        self.personNumber.textColor = [UIColor whiteColor];
        [self addSubview:self.personNumber];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personNumber.frame) + 10, viewWidth, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}


@end
