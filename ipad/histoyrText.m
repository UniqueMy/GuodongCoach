//
//  histoyrText.m
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "histoyrText.h"
#import "historyCell.h"
#import "historyComment.h"
#import "bodyTextVC.h"
@implementation histoyrText
{
    UITableView *_tableView;
}
- (void)viewDidLoad {
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
    titlelabel.text=@"历史测试";
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    NSLog(@"order_id  %@",self.order_id);
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.history_test&order_id=%@",BASEURL,self.order_id];
    NSLog(@"url   %@",url);
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res  %@",responseObject);
        if ([[responseObject objectForKey:@"rc"] intValue] == 0) {
            NSArray *data = [responseObject objectForKey:@"data"];
            self.request = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in data) {
                historyComment *history = [[historyComment alloc] initWithDictionary:dict];
                [self.request addObject:history];
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"errror  %@",error);
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
    historyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //3,
    if (!cell) {
        cell = [[historyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
    }
    historyComment *history = [self.request objectAtIndex:indexPath.row];
    cell.textdate.text = [NSString stringWithFormat:@"测试时间:%@",history.test_time];
    cell.jiaolian.text = [NSString stringWithFormat:@"教练:%@",history.coach_name];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
       historyComment *history = [self.request objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    bodyTextVC *botyVC = [bodyTextVC new];
    botyVC.order_id = history.order_id;
    botyVC.complete = YES;
    [self.navigationController pushViewController:botyVC animated:YES];
    
}

-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
