//
//  clientVC.h
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clientVC : UIViewController
- (NSString*)setString2:(NSString *)string ;
@property (nonatomic,retain)NSArray *baseArray,*healthArray,*bodyArray;
@property (nonatomic,retain)NSString *order_id;
@end
