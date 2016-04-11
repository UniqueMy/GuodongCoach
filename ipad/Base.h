//
//  Base.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"

@interface Base : UIView<QCheckBoxDelegate>

-(instancetype)initWithFrame:(CGRect)frame baseDict:(NSDictionary *)dict title:(NSString *)title;
@property (nonatomic,retain)NSArray *weightCheck;

@end
