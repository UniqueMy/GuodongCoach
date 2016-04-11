//
//  sportrecordVC.h
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sportrecordVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) NSString *order_id,*coachName;
@property (nonatomic,retain) NSMutableArray *sportArray;
@end
