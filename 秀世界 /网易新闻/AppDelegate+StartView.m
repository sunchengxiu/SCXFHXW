//
//  AppDelegate+StartView.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/15.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "AppDelegate+StartView.h"

@implementation AppDelegate (StartView)
-(void)showStartView{

     UIImageView *view=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [view setImage:[UIImage imageNamed:@"qidong.png"]];
    view.tag=1000;
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissView) userInfo:nil repeats:nil];
    [self.window addSubview:view];

}
-(void)dismissView{
    UIImageView *view=(UIImageView *)[self.window viewWithTag:1000];
    [view removeFromSuperview];

}
@end
