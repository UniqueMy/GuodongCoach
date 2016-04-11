//
//  HealthStatus.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthStatus : UIView
-(instancetype)initWithFrame:(CGRect)frame healthDict:(NSDictionary *)dict;
@property (nonatomic,retain)NSArray *diseaseArray;
@end
