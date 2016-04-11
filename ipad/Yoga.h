//
//  Yoga.h
//  ipad
//
//  Created by mac on 15/11/9.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Yoga : UIView
-(instancetype)initWithFrame:(CGRect)frame yogaDict:(NSDictionary *)dict;
@property (nonatomic,retain)NSArray *touchYogaArray;
@property (nonatomic,retain)NSArray *jointArray;
@property (nonatomic,retain)NSMutableArray *purposeArray;
@property (nonatomic,retain)NSArray *enduranceArray;
@property (nonatomic,retain)NSArray *temperatureArray;
@property (nonatomic,retain)NSArray *whatTimeArray;
@property (nonatomic,retain)NSArray *timesArray;
@property (nonatomic,retain)NSArray *digestionArray;
@property (nonatomic,retain)NSArray *affectArray;
@property (nonatomic,retain)NSArray *memoryArray;
@property (nonatomic,retain)NSArray *circulationArray;
@end
