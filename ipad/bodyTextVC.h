//
//  bodyTextVC.h
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bodyTextVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic,retain)NSString *order_id,*coachName;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic,assign) BOOL complete;
@end
