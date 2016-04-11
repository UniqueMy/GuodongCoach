//
//  questionnaireVC.h
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
@interface questionnaireVC : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,QCheckBoxDelegate,UIAlertViewDelegate>
@property (nonatomic,retain)NSString *order_id;
@property (nonatomic,retain)NSString *isOver;
@property (nonatomic,copy) void(^baseAnswerBlock)(NSArray *answer);
@end
