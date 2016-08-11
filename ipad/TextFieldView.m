//
//  TextFieldView.m
//  果动
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "TextFieldView.h"

@implementation TextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
      //  self.backgroundColor = BASECOLOR;
        
        _textField = [UITextField new];
        _textField.frame = CGRectMake((13),
                                      (self.frame.size.height - (32)) / 2,
                                      viewWidth - (99),
                                      (32));
        _textField.backgroundColor = [UIColor colorWithRed:55/255.0
                                                     green:55/255.0
                                                      blue:55/255.0
                                                     alpha:1];
        _textField.placeholder     = @"说点什么吧";
        _textField.textColor       = [UIColor grayColor];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
        _textField.leftView        = leftView;
        _textField.leftViewMode    = UITextFieldViewModeAlways;
        _textField.font            = [UIFont fontWithName:FONT size:(14)];
        [_textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:_textField];
        
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake((5),
                                                                                   (_textField.bounds.size.height - (15)) / 2,
                                                                                   (15),
                                                                                   (15))];
        leftImageView.image        = [UIImage imageNamed:@"textFieldImage"];
        [_textField addSubview:leftImageView];

        
        _publishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _publishButton.frame     = CGRectMake(viewWidth - ((13 + 60)),
                                             (self.frame.size.height - (30)) / 2,
                                             (60),
                                             (30));
        [_publishButton setTitleColor:[UIColor orangeColor]
                            forState:UIControlStateNormal];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [self addSubview:_publishButton];
    }
    return self;
}

@end
