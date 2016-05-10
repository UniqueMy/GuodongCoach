//
//  ContentModel.m
//  ipad
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "ContentModel.h"
#import "Content_Row_Model.h"
#import "ContentTableViewCell.h"
@implementation ContentModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        
        self.sectionName  = [dictionary objectForKey:@"name"] ? [dictionary objectForKey:@"name"] : NULL;
        
        
        self.sectionString = [dictionary objectForKey:@"description"] ? [dictionary objectForKey:@"description"] : NULL;
        
        
        self.sectionNumber = [dictionary objectForKey:@"framework_id"] ? [dictionary objectForKey:@"framework_id"] : NULL;
        
        
        self.rowArray     = [NSMutableArray array];
        self.cellRowArray = [NSMutableArray array];
        if ([dictionary objectForKey:@"subtitel"]) {
            for (NSDictionary *rowdict in [dictionary objectForKey:@"subtitel"]) {
                
                Content_Row_Model *rowModel = [[Content_Row_Model alloc]
                                               initWithDictionary:rowdict];
                ContentTableViewCell *cell  = [[ContentTableViewCell alloc] init];
                [self.cellRowArray addObject:cell];
                [self.rowArray addObject:rowModel];
               
            }
        } else {
            self.rowArray = NULL;
        }
        
        
        
        
    }
    return self;
}
@end
