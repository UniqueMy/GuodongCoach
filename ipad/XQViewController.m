//
//  XQViewController.m
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//
#import "XQViewController.h"
#import "XQTableViewCell.h"
#import "XQComment.h"
@interface XQViewController ()
{
    UITableView *_tableView;
}
@end

@implementation XQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:27.00/255 green:27.00/255 blue:27.00/255 alpha:1];
    UIView *daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.text=@"运动记录";
    titlelabel.font=[UIFont fontWithName:FONT size:36];
    titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:backButton];
    
    [self createView];
    
}
-(void)createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, viewWidth, viewHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.rowHeight = 400;
    _tableView.backgroundColor = [UIColor clearColor];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.recard_list&order_id=%@",BASEURL,self.order_id];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
      
        NSArray *data = [responseObject objectForKey:@"data"];
        self.request = [[NSMutableArray alloc] initWithCapacity:0];
        self.cellArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
            
            for (NSDictionary *dict in data) {
                XQComment *xqcomment = [[XQComment alloc] initWithDictionary:dict];
                XQTableViewCell *cell = [[XQTableViewCell alloc] init];
                [self.request addObject:xqcomment];
                [self.cellArray addObject:cell];
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error  %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.request.count;
}
// 设置单元格的内容的
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1,定义一个重用标示符
    static NSString *cellIdentifier = @"Cell";
    
    //2,从队列中出列一个可以重用的单元格
    XQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //3,
    XQComment *xq = [self.request objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[XQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
      //  NSLog(@"xq.remark.count %lu",(unsigned long)xq.remarkArray.count);
       
    }
   
    
    cell.xqcomment = xq;
    return cell;
}
#pragma mark 重新设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQTableViewCell *cell = self.cellArray[indexPath.row];
    cell.xqcomment = self.request[indexPath.row];
    return cell.height;
    
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
