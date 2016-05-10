//
//  ContentTableViewCell.h
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Content_Row_Model;

@interface ContentTableViewCell : UITableViewCell

@property (nonatomic,strong) Content_Row_Model *contentRowModel;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,retain) UILabel *contentLabel;
@property (nonatomic,retain) UILabel *nameLabel;

@end
