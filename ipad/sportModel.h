//
//  sportModel.h
//  ipad
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sportModel : NSObject
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *title_id;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
