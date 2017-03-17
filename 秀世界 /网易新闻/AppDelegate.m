//
//  AppDelegate.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsTableVIewController.h"
#import "AppDelegate+StartView.h"
#define appKey @"d19d3c30abc8"
#define appSecret @"dce8b99715d11435efc22953c69dba5b"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ShareSDK ssoEnabled:YES];
    
    [ShareSDK registerApp:@"d43c56f0c1af"];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [SMSSDK registerApp:appKey withSecret:appSecret];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    self.db=[FMDatabase databaseWithPath:[SCXCalculateClass path:@"db.db"]];
   // NSLog(@"%@",[SCXCalculateClass path:@"db.db"]);
    if ([self.db open]==NO) {
        NSLog(@"数据库打开失败!");
    }
    NSString *sql=@"create table if not exists t_news(thumbnail text null primary key,online text null,title text null,source text null,updateTime text null,id text null,documentId text null,type text null,hasVideo text null,commentsUrl text null,comments text null,commentsall text null,styleType text null,link text null，style blob null,imageData blob null)";
    if ([self.db executeUpdate:sql]==NO) {
        NSLog(@"bjhb");
    }
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //新闻
    NewsTableVIewController *news=[[NewsTableVIewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:news];
    na.tabBarItem.title=@"新闻";
    na.navigationBar.barTintColor=[UIColor redColor];
    [na.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil]forState:UIControlStateHighlighted];
    //[na.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"UIControlStateHighlighted.png"]];
    [na.tabBarItem setImage:[UIImage imageNamed:@"tabbar_home@2x"]];
    [na.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_home_selected@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //购物
    SCXShopTableViewController *shopTableViewController=[[SCXShopTableViewController alloc]init];
    UINavigationController *shopNavigationController=[[UINavigationController alloc]initWithRootViewController:shopTableViewController];
    shopNavigationController.tabBarItem.title=@"购物";
    [shopNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil]forState:UIControlStateHighlighted];
    //[na.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"UIControlStateHighlighted.png"]];
    [shopNavigationController.tabBarItem setImage:[UIImage imageNamed:@"tabbar_message_center@2x"]];
    [shopNavigationController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_message_center_selected@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //购物车
    SCXShopCarTableViewController *shopCar=[[SCXShopCarTableViewController alloc]init];
    UINavigationController *shopCarNavigation=[[UINavigationController alloc]initWithRootViewController:shopCar];
    shopCarNavigation.tabBarItem.title=@"地图";
    
    //游戏
    SCXGameViewController *gameViewController=[[SCXGameViewController alloc]init];
    UINavigationController *gameNavigation=[[UINavigationController alloc]initWithRootViewController:gameViewController];
    gameNavigation.tabBarItem.title=@"游戏";
    
    // 多媒体
    SCXMusicTableViewController *music=[[SCXMusicTableViewController alloc]init];
    UINavigationController *musicNavigation=[[UINavigationController alloc]initWithRootViewController:music];
    musicNavigation.tabBarItem.title=@"多媒体";
    
    //标签栏
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    tabbar.viewControllers=[NSArray arrayWithObjects:na,shopNavigationController,shopCarNavigation,gameNavigation,musicNavigation, nil];
    //[tabbar.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"UIControlStateHighlighted"]];
    [self.window setRootViewController:tabbar];
    [self.window makeKeyAndVisible];
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"isFirst"]){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFirst"];
        [self showStartView];
    }
    return YES;
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    NSLog(@"后台");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"进入前台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"活跃");
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type==UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case (UIEventSubtypeRemoteControlStop):
                NSLog(@"停止");
                break;
                case (UIEventSubtypeRemoteControlTogglePlayPause):
                NSLog(@"线控播放");
                if ([SCXMusicTableViewController sharedMusic].isPlay) {
                    //[musci.playButton setTitle:@"暂停" forState:UIControlStateNormal];
                    [[SCXMusicTableViewController sharedMusic] pause];
                    
                    
                }
                else{
                    [[SCXMusicTableViewController sharedMusic]play];
                    
                }
                break;
                
                case (UIEventSubtypeRemoteControlPause):
                [[SCXMusicTableViewController sharedMusic] pause];
                NSLog(@"暂停");
                break;
                case (UIEventSubtypeRemoteControlPlay):
                [[SCXMusicTableViewController sharedMusic] play];
                break;
                case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一曲");
                [[SCXMusicTableViewController sharedMusic] next:nil];
                break;
                case UIEventSubtypeRemoteControlPreviousTrack:
                [[SCXMusicTableViewController sharedMusic] previous:nil];
                break;
                
            default:
                break;
        }
    }


}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [Pingpp handleOpenURL:url withCompletion:nil];

}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
@end
