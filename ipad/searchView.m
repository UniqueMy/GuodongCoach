//
//  searchView.m
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "searchView.h"
#import "clientVC.h"
#import "SearchComment.h"
#import "searchCell.h"
@implementation searchView
{
    int viewheight;
    int viewweight;
    UITextField *textField;
    UITableView *_tableView;
    
}
- (id)init
{
    self = [super init];
    if (self) {
        viewheight = self.view.frame.size.height-64;
        viewweight = self.view.frame.size.width;
        self.view.frame =CGRectMake(0, 0, viewWidth-viewheight/4, viewHeight-64);
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    // self.view.frame =CGRectMake(viewheight/4, 0, viewWidth-viewheight/4, viewHeight-64);
    self.view.backgroundColor =[UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    self.view.userInteractionEnabled = YES;
    // 550, 150, 150, 50
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(150, 150, 400, 100)];
    textField.borderStyle =UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入搜索关键字";
    textField.keyboardType=UIKeyboardTypeDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont fontWithName:FONT size:30];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:30] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:textField];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchButton.frame = CGRectMake(600, 150, 100, 100);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont fontWithName:FONT size:30];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:searchButton];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(130, 300, 600, 320) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    _tableView.rowHeight = 80;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
-(void)searchButton:(UIButton *)button
{
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.search",BASEURL];
    
    NSDictionary *dataDict = @{@"kv":textField.text};
    
    NSLog(@"url %@",url);
    [HttpTool postWithUrl:url params:dataDict contentType:CONTENTTYPE success:^(id responseObject) {
        NSLog(@"res  %@",[responseObject objectForKey:@"msg"] );
        if ([[ responseObject objectForKey:@"rc"] intValue] == 0)
        {
            NSLog(@"data7777  %@",[responseObject objectForKey:@"data"]);
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            
            self.request  =[[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in dataArray) {
                SearchComment *search = [[SearchComment alloc] initWithDictionary:dict];
                [self.request addObject:search];
                [_tableView reloadData];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    } fail:^(NSError *error) {
        NSLog(@"error   %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }];
    [self.view endEditing:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"request.count  %ld",(unsigned long)self.request.count);
    return self.request.count;
}
//设置单元格的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  static NSString *cellidentifier = @"cell";
    
    searchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[searchCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
        
    }
    
    SearchComment *search = [self.request objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = search.name;
    
    cell.ageLabel.text =  [NSString stringWithFormat:@"%@岁", search.age];
    
    cell.address.text = search.area;
    
    self.order_id = search.order_id;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchComment *search = [self.request objectAtIndex:indexPath.row];
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.daohangBlock(search.order_id);
    
}
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static searchView* search;
    
    dispatch_once(&onceToken, ^{
        search = [[searchView alloc] init];
    });
    
    return search;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
