//
//  Food.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Food : UIView
-(instancetype)initWithFrame:(CGRect)frame foodDict:(NSDictionary *)dict;
@property (nonatomic,retain)NSArray *foodAnalyzeArray;
@property (nonatomic,retain)NSArray *lawFoodArray;
@property (nonatomic,retain)NSArray *sportTonicArray;
@property (nonatomic,retain)NSArray *foodPlanArray;
@end
