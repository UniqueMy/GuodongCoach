//
//  InteractiveView.m
//  ipad
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "InteractiveView.h"
#import "QuestionView.h"

@implementation InteractiveView
{
    UIImageView  *sanjiaoImageView;
    CGFloat      lineLeftWidth;
    QuestionView *question;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        int viewheight = viewHeight-64;
        self.frame = CGRectMake(0,
                                0,
                                viewWidth-viewheight/4,
                                viewHeight-64);
        self.backgroundColor = [UIColor whiteColor];
        
        UIColor *colorA = [UIColor colorWithRed:237/255.0
                                          green:144/255.0
                                           blue:147/255.0
                                          alpha:1];
               
        lineLeftWidth = (viewHeight - 64) / 4;
        
        
       
        
        UIButton *questionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        questionButton.frame     = CGRectMake(0, 0, lineLeftWidth, 80);
        questionButton.backgroundColor = colorA;
        questionButton.titleLabel.font = [UIFont fontWithName:FONT size:22];
        [questionButton setTitle:@"答疑" forState:UIControlStateNormal];
        [questionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [questionButton addTarget:self action:@selector(questionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:questionButton];
        
        
        // 分割线
       UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftWidth - 1,
                                                         0,
                                                         1,
                                                         viewHeight - 64)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        question = [[QuestionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, viewWidth - CGRectGetMaxX(line.frame), viewHeight - 64)];
        [self addSubview:question];
        
    }
    return self;
}

- (void)questionClick:(UIButton *)button {
    sanjiaoImageView.frame = CGRectMake(lineLeftWidth - 18.2,
                                        39.2 / 2,
                                        19.2,
                                        39.2);
    [question removeFromSuperview];
    question = [[QuestionView alloc] initWithFrame:CGRectMake(lineLeftWidth, 0, viewWidth - lineLeftWidth, viewHeight - 64)];
    [self addSubview:question];

}
@end
