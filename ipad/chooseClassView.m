//
//  chooseClassView.m
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "chooseClassView.h"
#import "ContentModel.h"
#import "Content_Row_Model.h"
@interface chooseClassView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation chooseClassView
{
    UIImageView *titleImageView;
    UIImageView *dateImageView;
    BOOL         titleIsUp;
    BOOL         dateIsUp;
    
    UIView      *superClassView;
    UITableView *titleTableView;
    UITableView *dateTableView;
    NSNotification *notification;
    NSMutableArray *sectionArray;
    NSMutableArray *rowArray;
    
    UILabel *titleLabel;
    UILabel *dateLabel;
    NSInteger sectionNumber;
    NSString *content_id;
    
}
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)view trainClassArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        sectionArray = [NSMutableArray array];
        rowArray     = [NSMutableArray array];
        sectionArray = array;
        ContentModel *model = sectionArray[0];
        rowArray            = model.rowArray;
        
       
        superClassView      = view;
        
        [self createUI];
    }
    return self;
}


- (void)createUI {
   
    
    titleLabel                 = [UILabel new];
    titleLabel.userInteractionEnabled = YES;
    titleLabel.frame           = CGRectMake(3, 3, 150, 24);
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment   = 1;
    titleLabel.textColor       = [UIColor blackColor];
    titleLabel.font            = [UIFont fontWithName:FONT size:18];
    ContentModel *model        = sectionArray[0];
    titleLabel.text            = model.sectionName;
    [self addSubview:titleLabel];
    
    
    titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    titleImageView.frame        = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 6.5, 9.5, 17, 11);
    [self addSubview:titleImageView];
    
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    titleButton.frame     = CGRectMake(0,
                                       0,
                                       titleLabel.bounds.size.width + 30,
                                       self.bounds.size.height);
    [titleButton addTarget:self action:@selector(titleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:titleButton];
    
    
    dateLabel                 = [UILabel new];
    dateLabel.frame           = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 30,
                                           3,
                                           150,
                                           24);
    dateLabel.userInteractionEnabled = YES;
    dateLabel.backgroundColor = [UIColor whiteColor];
    dateLabel.textAlignment   = 1;
    dateLabel.textColor       = [UIColor blackColor];
    dateLabel.font            = [UIFont fontWithName:FONT size:18];
     Content_Row_Model *rowModel = rowArray[0];
    dateLabel.text            = rowModel.rowName;
    [self addSubview:dateLabel];
    
    
    dateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    dateImageView.frame        = CGRectMake(CGRectGetMaxX(dateLabel.frame) + 6.5, 9.5, 17, 11);
    [self addSubview:dateImageView];
    
    
    UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dateButton.frame     = CGRectMake(CGRectGetMaxX(titleButton.frame),
                                      0,
                                      dateLabel.bounds.size.width + 30,
                                      self.bounds.size.height);
    [dateButton addTarget:self action:@selector(dateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:dateButton];
    
    
    /*******************************************/
    
    
    
    
    titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x,CGRectGetMaxY(self.frame), 155, 44*4)
                                                  style:UITableViewStylePlain];
    titleTableView.delegate        = self;
    titleTableView.dataSource      = self;
    titleTableView.tag             = 10;
    
    titleTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    titleTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    titleTableView.backgroundColor = [UIColor whiteColor];
    
    
    dateTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleTableView.frame) + 25,CGRectGetMaxY(self.frame), 155, 44*7)
                                                 style:UITableViewStylePlain];
    dateTableView.delegate        = self;
    dateTableView.dataSource      = self;
    dateTableView.tag             = 20;
    dateTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    dateTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    dateTableView.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)titleButton:(UIButton *)button {
    
    NSLog(@"点击了选择大纲");
    
    if (!titleIsUp) {
        NSLog(@"打开");
        [titleImageView setImage:[UIImage imageNamed:@"up"]];
        [superClassView addSubview:titleTableView];
        
    } else {
        NSLog(@"关闭");
        [titleImageView setImage:[UIImage imageNamed:@"down"]];
        [titleTableView removeFromSuperview];
    }
    
    titleIsUp =! titleIsUp;
}
- (void)dateButton:(UIButton *)button {
    
    NSLog(@"点击了选择日期");
    
    if (!dateIsUp) {
        [dateImageView setImage:[UIImage imageNamed:@"up"]];
        [superClassView addSubview:dateTableView];
    } else {
        [dateImageView setImage:[UIImage imageNamed:@"down"]];
        [dateTableView removeFromSuperview];
    }
    
    dateIsUp =! dateIsUp;
}

#pragma mark - UITableView - Delegate - Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 10) {
       
        return sectionArray.count;
    } else {
    
        return rowArray.count;
        
    }
}


// 设置单元格的内容的
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //1,定义一个重用标示符
    static NSString *cellIdentifier = @"Cell";
    
    //2,从队列中出列一个可以重用的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //3,
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.textColor     = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:112/255.0
                                               green:199/255.0
                                                blue:243/255.0
                                               alpha:1];
    }
    if (tableView.tag == 10) {
        
        ContentModel *model = sectionArray[indexPath.row];
        cell.textLabel.text  = model.sectionName;
        
    } else {
        Content_Row_Model *rowModel = rowArray[indexPath.row];
        
        cell.textLabel.text = rowModel.rowName;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 10) {
        ContentModel *model = sectionArray[indexPath.row];
        titleLabel.text     = model.sectionName;
        rowArray            = model.rowArray;
        
        /**
         *  课程时间随着大纲的变化而改变默认值
         */
        Content_Row_Model *rowModel = rowArray[0];
        dateLabel.text  = rowModel.rowName;
        
        [titleTableView removeFromSuperview];
        [titleImageView setImage:[UIImage imageNamed:@"down"]];
        titleIsUp =! titleIsUp;
        [dateTableView reloadData];
        
        NSDictionary   *coachDict    = @{@"content_id":rowModel.row_number};
        notification = [NSNotification notificationWithName:@"content_id" object:nil userInfo:coachDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } else {
        Content_Row_Model *rowModel = rowArray[indexPath.row];
        dateLabel.text  = rowModel.rowName;
        [dateTableView removeFromSuperview];
        [dateImageView setImage:[UIImage imageNamed:@"down"]];
        dateIsUp =! dateIsUp;
    
        NSDictionary   *coachDict    = @{@"content_id":rowModel.row_number};
        notification = [NSNotification notificationWithName:@"content_id" object:nil userInfo:coachDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
   

    
}
@end
