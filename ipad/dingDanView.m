//
//  dingDanView.m
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "dingDanView.h"
#import "dingdanCell.h"
#import "newamendViewController.h"
#import "AppDelegate.h"
#import "dingdanComment.h"
#import "clientVC.h"
#import "ingamendViewController.h"
@implementation dingDanView
{
    int viewheight;
    int viewweight;
   
    }

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"123165465130");
        viewheight = self.view.frame.size.height-64;
        viewweight = self.view.frame.size.width;
        self.view.frame =CGRectMake(0, 0, viewWidth-viewheight/4, viewHeight-64);
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

   
    
    self.view.backgroundColor =[UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    self.view.userInteractionEnabled = YES;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [self.view addSubview:titleView];
    
    UIImageView * lineImage1=[UIImageView new];
    lineImage1.image=[UIImage imageNamed:@"home__line1"];
    lineImage1.frame=CGRectMake(0, 99, self.view.frame.size.width, 1);
    [self.view addSubview:lineImage1];
    
    
    self.dingdanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dingdanButton.frame = CGRectMake(265, 15, 300, 70);
    
    
    [self.dingdanButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dingdanButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 180) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    _tableView.rowHeight = 200;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
     [self.view addSubview:_tableView];
   
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"self.request.count   %ld",(long)self.request.count);
    return self.request.count;
}


// 设置单元格的内容的
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1,定义一个重用标示符
    static NSString *cellIdentifier = @"Cell";
    
    //2,从队列中出列一个可以重用的单元格
    dingdanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //3,
    if (!cell) {
        cell = [[dingdanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    }
     dingdanComment *dingdanCom = [self.request objectAtIndex:indexPath.row];
    cell.name.text = dingdanCom.name;
    if ([dingdanCom.gender intValue] == 1) {
        cell.sex.text = @"男";
    }
    else
    {
        cell.sex.text = @"女";
    }
   
    cell.number.text    = [NSString stringWithFormat:@"电话：%@",dingdanCom.number];
    cell.classname.text = [NSString stringWithFormat:@"课程：%@",dingdanCom.course];
    cell.address.text   = [NSString stringWithFormat:@"住址：%@",dingdanCom.place];
    // 时间戳转时间的方法:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日  HH时"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dingdanCom.pre_time intValue]];
  
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    cell.date.text = [NSString stringWithFormat:@"约课日期：%@",confromTimespStr];
  
    if ([dingdanCom.process intValue] == 0) {
        cell.process.text = @"正在进行中";
    } else
    {
        cell.process.text = @"已完成";
    }
    cell.classStyle.text = [NSString stringWithFormat:@"类型：%@",dingdanCom.classStyle];
    cell.personNumber.text = [NSString stringWithFormat:@"人数：%@",dingdanCom.personNumber];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dingdanComment *dingdanCom = [self.request objectAtIndex:indexPath.row];
   
    if ([dingdanCom.process intValue] == 0)
    {
        self.block(dingdanCom.order_id,self.coachName);
    }else
    {
        NSLog(@"导航传值");
         self.daohangBlock1(dingdanCom.order_id);
    }

}

-(void)buttonClick:(UIButton *)button
{
    if ([self.status intValue] == 1) {
        self.daohangBlock(self.orderArray[0]);
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"暂时没有新订单哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
}
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static dingDanView* dingDan;
    
    dispatch_once(&onceToken, ^{
        dingDan = [[dingDanView alloc] init];
    });
    
    return dingDan;
}
@end
