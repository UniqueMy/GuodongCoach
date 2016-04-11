//
//  AppDelegate.m
//  ipad
//
//  Created by mac on 15/3/14.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "APService.h"
#import "newamendViewController.h"
#import "Reachability.h"
#import <Bugly/CrashReporter.h>
@interface AppDelegate ()
{
    Reachability *hostReach;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    
    
    ViewController *viewController = [[ViewController alloc] init];
    self.nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = self.nav;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    // Override point for customization after application launch.
    // Required

    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(reachabilityChanged:)
     
                                                 name:kReachabilityChangedNotification
     
                                               object:nil];
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.guodongwl.com"];
    
    [reach startNotifier];
    
    //.....
    /**
     *  崩溃日志
     */
     [[CrashReporter sharedInstance] enableLog:YES];
     [[CrashReporter sharedInstance] installWithAppId:@"900019617"];
    

    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"APNS   %@",remoteNotification);
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *reach = [notification object];
    
    if([reach isKindOfClass:[Reachability class]]){
        
        NetworkStatus statuWetwork = [reach currentReachabilityStatus];
        
        NSLog(@"statuWetwork  %ld",(long)statuWetwork);
        switch (statuWetwork) {
            case 0:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接中断" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert show];
            }
                break;
                           
            default:
                break;
        }
        //Insert your code here
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // ReÏstart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
     [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"ERROR   %@",error);
}

// apn 内容获取：

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // 取得 APNs 标准信息内容
//    NSDictio nary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    
    NSLog(@"userinfo   %@",userInfo);
  //  NSLog(@"CONTENT   %@",content);
    
    [APService handleRemoteNotification:userInfo];
   // completionHandler(UIBackgroundFetchResultNewData);
    NSString *order_id = [userInfo objectForKey:@"order_id"];
    NSLog(@"order_id  %@",order_id);
    ViewController *ingVC = [ViewController new];
    ingVC.idnew_order = order_id;
     ingVC.isPush = YES;
    [self.nav pushViewController:ingVC animated:YES];
    
    NSLog(@"userInfo  %@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"USERINFO   %@",userInfo);
    
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSString *order_id = [userInfo objectForKey:@"order_id"];
    NSLog(@"order_id  %@",order_id);
    ViewController *ingVC = [ViewController new];
    ingVC.idnew_order = order_id;
    ingVC.isPush = YES;
    [self.nav pushViewController:ingVC animated:YES];

}

@end
