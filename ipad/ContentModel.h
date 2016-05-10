//
//  ContentModel.h
//  ipad
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic,retain) NSMutableArray *rowArray;
@property (nonatomic,retain) NSMutableArray *cellRowArray;
@property (nonatomic,retain) NSString  *sectionName;
@property (nonatomic,retain) NSString  *sectionString;
@property (nonatomic,retain) NSString  *sectionNumber;



- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

