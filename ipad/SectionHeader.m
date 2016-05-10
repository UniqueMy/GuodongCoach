//
//  SectionHeader.m
//  ipad
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "SectionHeader.h"

@implementation SectionHeader

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        self.backgroundColor = [UIColor colorWithRed:247/255.0
                                               green:247/255.0
                                                blue:247/255.0
                                               alpha:1];
    }
    return self;
}

- (void)createUI {
    
    _sectionLabel  = [UILabel new];
    _sectionLabel.frame     = CGRectMake(0,
                                        0,
                                        self.bounds.size.width,
                                        self.bounds.size.height);
    _sectionLabel.textColor = [UIColor colorWithRed:239/255.0
                                             green:151/255.0
                                              blue:155/255.0
                                             alpha:1];
    _sectionLabel.font      = [UIFont fontWithName:FONT size:20];
    [self addSubview:_sectionLabel];
}




@end
