//
//  ClientComment.h
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientComment : NSObject
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *number;
@property (nonatomic,retain)NSString * age;
@property (nonatomic,retain)NSString *address;
@property (nonatomic,retain) NSString* sex;

@property (nonatomic,retain)NSString *area;
@property (nonatomic,retain)NSString *apparatu;
@property (nonatomic,retain)NSString *xggd;

@property (nonatomic,retain)NSString *coach;
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *enthusiasm;
@property (nonatomic,retain)NSString *expression;
@property (nonatomic,retain)NSString *heart_rate;
@property (nonatomic,retain)NSString *remark;
@property (nonatomic,retain)NSString *time;
@property (nonatomic,retain)NSString *date;

@property (nonatomic,retain)NSString *order_id;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
/*res  {
 data =     {
 area =         {
 apparatu = 4444;
 area = 12;
 id = 1;
 xggd = 333;
 };
 base =         {
 address = 44;
 age = 0;
 name = "\U9ece\U4ed5\U52c7";
 number = 5555;
 sex = 1;
 };
 "body_id" = 1;
 health = 1;
 recard =         {
 coach = "\U8d75\U5efa\U5a01";
 content = "\U4fef\U5367\U6491,\U4ef0\U5367\U8d77\U5750";
 enthusiasm = "\U9ad8";
 expression = "\U5dee";
 "heart_rate" = 102;
 id = 1;
 remark = 123;
 time = 1426829658;
 };
 };
 rc = 0;
 st = 1427260164;
 }
 */
