//
//  IndexTableViewCell.m
//  ipad
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

// 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 把自定义的控件 变成了单元格的属性
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 1, 20)];
        [self drawDashLine:line lineLength:3 lineSpacing:5 lineColor:[UIColor redColor]];
        [self addSubview:line];
        
        self.indexLabel           = [UILabel new];
        self.indexLabel.textColor = [UIColor colorWithRed:188/255.0 green:189/255.0 blue:190/255.0 alpha:1];
        self.indexLabel.font      = [UIFont fontWithName:FONT size:14];
        self.indexLabel.frame     = CGRectMake(10, 0, 90, 20);
        self.indexLabel.textAlignment = 1;
        [self addSubview:self.indexLabel];
        
        
    }
    return self;
}
#pragma mark - 封装画虚线方法

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
