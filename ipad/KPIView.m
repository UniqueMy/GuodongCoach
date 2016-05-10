//
//  KPIView.m
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "KPIView.h"
#import "chooseView.h"
#import "AllCoachModel.h"
#import "KPITableViewCell.h"
#import "KPIModel.h"
@interface KPIView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation KPIView
{
    int            viewheight;
    int            viewweight;
    AllCoachModel  *coachModel;
    NSMutableArray *allCoachArray;
    NSMutableArray *dataArray;
    chooseView     *chooseCoachView;
    chooseView     *chooseDateView;
    NSString       *coach_id;
    NSString       *beginString;
    NSString       *endString;
    UITableView    *_tableView;
    
    
   
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        viewheight = viewHeight-64;
      
        self.frame = CGRectMake(0,
                                0,
                                viewWidth-viewheight/4,
                                viewHeight-64);
        self.backgroundColor = [UIColor whiteColor];
       
        [self startRequest];
        [self createUI];
    }
    return self;
}

- (void)startRequest {
    
    //请求所有教练列表
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=train.allcoach",BASEURL];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        allCoachArray = [NSMutableArray array];
        
      //  NSDictionary *FirstDict = @{@"username":@"所有教练",@"uid":@""};
        
      //  AllCoachModel *coachModel = [[AllCoachModel alloc] initWithDictionary:FirstDict];
        
       // [allCoachArray addObject:coachModel];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            
            coachModel = [[AllCoachModel alloc] initWithDictionary:dict];
            [allCoachArray addObject:coachModel];
            
        }
        coachModel                     = allCoachArray[0];
        chooseCoachView.dataArray      = allCoachArray;
        chooseCoachView.showLabel.text = coachModel.userName;
        coach_id                       = coachModel.uid;
        //默认转换本周始末时间戳
        [self getNowDateBeginAndEndWith:[NSDate date] unit:0];
        
        //请求KPI数据
        [self requestKPIDataRequestWithCoach_id:coach_id begin:beginString end:endString];
    } fail:^(NSError *error) {}];
    
}

- (void)createUI {
    
    CGRect chooseCoachFrame = CGRectMake(30, 30, 250, 30);
    
    chooseCoachView                 = [[chooseView alloc] initWithFrame:chooseCoachFrame superView:self viewTag:100];
    chooseCoachView.backgroundColor = [UIColor colorWithRed:235/255.0
                                             green:6/255.0
                                              blue:150/255.0
                                             alpha:1];
   
    [self addSubview:chooseCoachView];
    
    
    
    CGRect chooseDateFrame = CGRectMake(CGRectGetMaxX(chooseCoachView.frame) + 25, 30, 250, 30);
    NSMutableArray *dateArray      = (NSMutableArray *)@[@"本周",@"本月",@"本年",@"所有"];
    
    chooseDateView                 = [[chooseView alloc] initWithFrame:chooseDateFrame superView:self viewTag:200];
    chooseDateView.backgroundColor = [UIColor colorWithRed:235/255.0
                                                green:6/255.0
                                                 blue:150/255.0
                                                alpha:1];
    chooseDateView.showLabel.text  = dateArray[0];
    chooseDateView.dataArray       = dateArray;
    [self addSubview:chooseDateView];

   // NSLog(@"width  %f",self.bounds.size.width);
   

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30,
                                                               CGRectGetMaxY(chooseCoachView.frame) + 30,
                                                              self.frame.size.width - 60,
                                                              self.frame.size.height - (CGRectGetMaxY(chooseCoachView.frame) + 30) - 30 - 20)
                                              style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    
    
    // 接收通知  更换显示页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultCoach_uid:) name:@"coach_uid" object:nil];
    // 接收通知  更换显示页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultDateType:) name:@"dateType" object:nil];
    
    
    
    
    
}
// 自定义区头的标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 60, 44)];
    headView.backgroundColor = [UIColor colorWithRed:235/255.0
                                               green:6/255.0
                                                blue:150/255.0
                                               alpha:1];
    CGFloat width      = headView.bounds.size.width / 5;
    
    NSArray *textArray = @[@"日期",@"课程",@"会员",@"价格",@"课时费"];
    
    for (int a = 0; a < 5; a++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment   = 1;
        label.textColor       = [UIColor blackColor];
        label.font            = [UIFont fontWithName:FONT size:20];
        label.text            = textArray[a];
        [headView addSubview:label];
        
        
        switch (a) {
            case 0:
                label.frame = CGRectMake(2, 2, width - 2, headView.bounds.size.height - 3);
                break;
            case 1:
                label.frame = CGRectMake(width *a +1 , 2, width - 2, headView.bounds.size.height - 3);
                break;
            case 2:
                label.frame = CGRectMake(width *a , 2, width - 2, headView.bounds.size.height - 3);
                break;
            case 3:
                label.frame = CGRectMake(width *a - 1 , 2, width - 2, headView.bounds.size.height - 3);
                break;
            case 4:
                 label.frame = CGRectMake(width *a - 2, 2, width , headView.bounds.size.height - 3);
                break;
                
            default:
                break;
        }
       
       
    }
    
    
    return headView;
}
//区头高度
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"刷新数组 %lu",(unsigned long)dataArray.count);
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cell";
    
    KPITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[KPITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    KPIModel *kpi               = dataArray[indexPath.row];
    cell.dateLabel.text         = kpi.time;
    cell.classLabel.text        = kpi.course_name;
    cell.personLabel.text       = kpi.user_name;
    cell.moneyLabel.text        = kpi.pay_count;
    cell.obtain_moneyLabel.text = [NSString stringWithFormat:@"%.1f", [kpi.obtain_money floatValue]];
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 接收通知
// 更换显示页
- (void)resultCoach_uid:(NSNotification *)notification {
   
    coach_id = [notification.userInfo objectForKey:@"coach_uid"];
    NSLog(@"tongzhi %@",coach_id);
    //请求KPI数据
    [self requestKPIDataRequestWithCoach_id:coach_id begin:beginString end:endString];
    
}
- (void)resultDateType:(NSNotification *)notification {
 
    NSInteger datetype = [[notification.userInfo objectForKey:@"dateType"] integerValue];
    [self getNowDateBeginAndEndWith:[NSDate date] unit:datetype];
    //请求KPI数据
    [self requestKPIDataRequestWithCoach_id:coach_id begin:beginString end:endString];
}

- (void)requestKPIDataRequestWithCoach_id:(NSString *)coach begin:(NSString *)begin end:(NSString *)end {
    
   // NSLog(@"coach_id %@  begin %@  end %@",coach,beginString,endString);
    
    
    NSString *url = [NSString stringWithFormat:@"%@/pad/?method=coach.course_recard",BASEURL];
    NSDictionary *dataDict = @{@"coach_id":coach,@"start_time":begin,@"end_time":end};
    NSLog(@"dataDict %@",dataDict);
    [HttpTool postWithUrl:url params:dataDict contentType:CONTENTTYPE success:^(id responseObject) {
        
        dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"recard_list"]) {
             KPIModel *kpi = [[KPIModel alloc] initWithDictionary:dict];
            [dataArray addObject:kpi];
        }
         NSLog(@"数据数组 %lu",(unsigned long)dataArray.count);
        [_tableView reloadData];
        
    } fail:^(NSError *error) {}];
    
}


- (void)getNowDateBeginAndEndWith:(NSDate *)newDate unit:(NSInteger )integer{
    
    if (integer != 3) {
        if (newDate == nil) {
            newDate = [NSDate date];
        }
        double interval   = 0;
        NSDate *beginDate = nil;
        NSDate *endDate   = nil;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setFirstWeekday:2];//设定周一为周首日
        
        NSCalendarUnit unit;
        switch (integer) {
            case 0:
                unit = NSWeekCalendarUnit;
                break;
            case 1:
                unit = NSMonthCalendarUnit;
                break;
                
            case 2:
                unit = NSYearCalendarUnit;
                break;
                
            default:
                break;
        }
        BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:newDate];
        //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
        if (ok) {
            endDate = [beginDate dateByAddingTimeInterval:interval-1];
        }else {
            return;
        }
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy.MM.dd HH.mm.ss"];
       
        beginString = [NSString stringWithFormat:@"%.0f",[beginDate timeIntervalSince1970]];
        endString = [NSString stringWithFormat:@"%.0f",[endDate timeIntervalSince1970]];

    } else {
        
        beginString = @"0";
         endString  = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
        
    }
    
}
@end
