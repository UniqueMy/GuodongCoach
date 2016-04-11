//
//  personView.m
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "personView.h"

@implementation personView
{
    int viewheight;
    int viewweight;
    BOOL isopen ;
    UIView *statusView;
    
    int status;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.view.frame =CGRectMake(0, 0, viewWidth-viewheight/4, viewHeight-64);
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    viewheight = self.view.frame.size.height-64;
    viewweight = self.view.frame.size.width;
    
    self.view.backgroundColor =[UIColor colorWithRed:28.00/255 green:25.00/255 blue:25.00/255 alpha:1];
    self.view.userInteractionEnabled = YES;
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"appVersion %@",appVersion);

  
    UILabel *Label =[[UILabel alloc] initWithFrame:CGRectMake(550, 150, 150, 50)];
    Label.textColor = [UIColor whiteColor];
    Label.text = @"姓名：";
    Label.font = [UIFont fontWithName:FONT size:36];
    [self.view addSubview:Label];
    
    NSArray *labelArray = @[@"出课数：",@"所在区域：",@"身份证号：",];
    for (int a = 0; a < 3; a++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100*a+350, 200, 50)];
        label.text = labelArray[a];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:FONT size:36];
        [self.view addSubview:label];
        
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 50, 240, 240)];
    self.imageView.layer.cornerRadius = 120;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    
    self.yanImage = [[UIImageView alloc] initWithFrame:CGRectMake(700, 550, 50, 50)];
    
    [self.view addSubview:self.yanImage];
    
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(680, 650, 200, 30)];
    version.textColor = [UIColor whiteColor];
    version.font = [UIFont fontWithName:FONT size:22];
    version.text = [NSString stringWithFormat:@"版本号:%@",appVersion];
    [self.view addSubview:version];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(650,150,150,50)];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:FONT size:36];
    [self.view addSubview:self.nameLabel];
    
    
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 450, 400, 50)];
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.font = [UIFont systemFontOfSize:36];
    [self.view addSubview:self.addressLabel];
    //
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 350, 400, 50)];
    
    self.classLabel.textColor = [UIColor whiteColor];
    self.classLabel.font = [UIFont systemFontOfSize:36];
    [self.view addSubview:self.classLabel];
    //
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 550, 400, 50)];
    self.idLabel.textColor = [UIColor whiteColor];
    self.idLabel.font = [UIFont systemFontOfSize:36];
    [self.view addSubview:self.idLabel];
    
    self.statusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.statusButton.frame = CGRectMake(550, CGRectGetMaxY(self.nameLabel.frame)+25, 23, 23);
    self.statusButton.clipsToBounds = YES;
    self.statusButton.layer.cornerRadius = self.statusButton.frame.size.width/2;
    
    [self.statusButton addTarget:self action:@selector(statusButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.statusButton];
}

-(void)statusButton:(UIButton *)button
{
   // NSLog(@"z点击了状态按钮");
    if (!isopen) {
        if (!statusView)
        {
            statusView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+5, CGRectGetMaxY(button.frame)+5, 100, 95)];
            statusView.clipsToBounds = YES;
            statusView.layer.cornerRadius = 12;
            statusView.backgroundColor = [UIColor lightGrayColor];
            NSArray *array = @[@"zaixian",@"likai"];
            for (int a = 0; a < 2; a++) {
                
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10+a*45, 47*1.8, 13*1.8)];
                imageview.userInteractionEnabled = YES;
                imageview.image = [UIImage imageNamed:array[a]];
                [statusView addSubview:imageview];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(5,10+a*45, 47*1.8, 13*1.8);
                button.tag = 1001+a;
                button.showsTouchWhenHighlighted = YES;
                [button addTarget:self action:@selector(changestatus:) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor clearColor];
                [statusView addSubview:button];
            }
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home__line"]];
            image.frame = CGRectMake(0, 45, 100, 1);
            [statusView addSubview:image];
        }
         [self.view addSubview:statusView];
    }
    else
    {
        
        [statusView removeFromSuperview];
    }
    
    isopen = !isopen;
   
   
}
-(void)changestatus:(UIButton *)button
{
  
    if (button.tag == 1001) {
        status = 0;
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.change_status&status=%d",BASEURL,status];
        [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
            NSLog(@"res  %@",responseObject);
            if ([[responseObject objectForKey:@"rc"] intValue] == 0)
            {
               self.statusButton.backgroundColor = [UIColor greenColor];
            }
        } fail:^(NSError *error) {
            NSLog(@"error  %@",error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"似乎已断开与互联网的连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }];
    }
    else
    {
        status = 1;
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=coach.change_status&status=%d",BASEURL,status];
        [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
            NSLog(@"res  %@",responseObject);
            if ([[responseObject objectForKey:@"rc"] intValue] == 0)
            {
                self.statusButton.backgroundColor = [UIColor orangeColor];
            }
        } fail:^(NSError *error) {
            NSLog(@"error  %@",error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }];
    }
   
    
  
    
    [statusView removeFromSuperview];
    isopen = NO;
}
+ (instancetype)sharedViewControllerManager {
    static dispatch_once_t onceToken;
    static personView* personview;
    
    dispatch_once(&onceToken, ^{
        personview = [[personView alloc] init];
    });
    
    return personview;
}



@end
