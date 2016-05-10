//
//  chooseView.m
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "chooseView.h"
#import "AllCoachModel.h"
@interface chooseView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation chooseView
{
    BOOL         isUp;
    UIImageView  *showImageView;
    UITableView  *_tableView;
    UIView       *superView;
    NSInteger    viewtag;
    
}
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)supView viewTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        superView      = supView;
        viewtag        = tag;
        self.dataArray = [NSMutableArray array];
        [self createBaseView];
        
    }
    return self;
}

- (void)createBaseView {
    
    _showLabel                 = [UILabel new];
    _showLabel.frame           = CGRectMake(2, 2, 200, 25);
    _showLabel.backgroundColor = [UIColor whiteColor];
    _showLabel.textAlignment   = 1;
    _showLabel.font            = [UIFont fontWithName:FONT size:19];
    [self addSubview:_showLabel];
    
    showImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    showImageView.frame            = CGRectMake(CGRectGetMaxX(_showLabel.frame) + 14, 8.7, 22.1, 13.65);
    [self addSubview:showImageView];
    
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showButton.frame  = CGRectMake(0,
                                   0,
                                   self.bounds.size.width,
                                   self.bounds.size.height);
    [showButton addTarget:self action:@selector(showButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showButton];
    
    /*******************/
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x,
                                                               CGRectGetMaxY(self.frame),
                                                               204,
                                                               44*4)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)showButtonClick:(UIButton *)button {
    if (!isUp) {
        showImageView.image = [UIImage imageNamed:@"up"];
        [superView addSubview:_tableView];
    } else {
        showImageView.image = [UIImage imageNamed:@"down"];
        [_tableView removeFromSuperview];
    }
    isUp =! isUp;
}

#pragma mark - UITableViewDelegate 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor colorWithRed:235/255.0
                                               green:6/255.0
                                                blue:150/255.0
                                               alpha:1];
        cell.textLabel.textColor     = [UIColor whiteColor];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.font          = [UIFont fontWithName:FONT size:19];
    }
    if (viewtag == 100) {
        AllCoachModel *allCoach = self.dataArray[indexPath.row];
        cell.textLabel.text     = allCoach.userName;

    } else {
       
        cell.textLabel.text     = self.dataArray[indexPath.row];

    }
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (viewtag == 100) {
         AllCoachModel *model = self.dataArray[indexPath.row];
         _showLabel.text      = model.userName;
        // 发送通知 请求数据
        NSDictionary   *frame_idDict  = @{@"coach_uid":model.uid};
        NSNotification *notification  = [NSNotification notificationWithName:@"coach_uid" object:nil userInfo:frame_idDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } else {
        _showLabel.text     = self.dataArray[indexPath.row];
        
        // 发送通知 请求数据
        NSDictionary   *frame_idDict  = @{@"dateType":[NSString stringWithFormat:@"%ld",(long)indexPath.row]};
        NSNotification *notification  = [NSNotification notificationWithName:@"dateType" object:nil userInfo:frame_idDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
   
    showImageView.image  = [UIImage imageNamed:@"down"];
    isUp                 =! isUp;
    [_tableView removeFromSuperview];
    
   
}

@end
