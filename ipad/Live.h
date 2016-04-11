//
//  Live.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Live : UIView
-(instancetype)initWithFrame:(CGRect)frame liveDict:(NSDictionary *)dict;
@property (nonatomic,retain)NSArray *sleepStatusArray;
@property (nonatomic,retain)NSArray *smokeArray;
@property (nonatomic,retain)NSArray *smokeNumberArray;
@property (nonatomic,retain)NSArray *drinkArray;
@property (nonatomic,retain)NSArray *drinkNumberArray;

@end
