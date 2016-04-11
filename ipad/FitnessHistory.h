//
//  FitnessHistory.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitnessHistory : UIView
-(instancetype)initWithFrame:(CGRect)frame fitnessDict:(NSDictionary *)dict;
@property (nonatomic,retain)NSArray *professionalSportArray;
@property (nonatomic,retain)NSArray *sportNumberArray;
@property (nonatomic,retain)NSArray *sportTimeArray;
@property (nonatomic,retain)NSArray *whenSportArray;
@end
