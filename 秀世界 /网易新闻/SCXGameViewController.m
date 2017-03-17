//
//  ViewController.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "SCXGameViewController.h"
#import "MyView.h"
#import "ZHQFoe.h"
#import "ZHQBullet.h"
#import "ZHQBoom.h"
@interface SCXGameViewController ()
{
    MyView * view;
    UIImage * foeImage;
    UIImage * bulletImage;
    UIImage * boomImage;
    //是否在英雄上按下
    BOOL isPress;
    //移动前一点
    CGPoint prePoint;
    UILabel *label;
    UIButton *button;
    BOOL isPlay;
    BOOL isGameOver;
    NSTimer *time;
    BOOL isPause;
}
@end

@implementation SCXGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //time=[[NSTimer alloc]init];
    view=[[MyView alloc]init];
    self.view=view;
    label=[[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 200, 200, 50)];
    [label setText:@"Game Over"];
    //[label setBackgroundColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setTextColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    label.hidden=YES;
    
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    isPlay=YES;
    self.navigationItem.titleView=button;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(stopGame)];
    foeImage=[UIImage imageNamed:@"dr.png"];
    bulletImage=[UIImage imageNamed:@"zd.png"];
    boomImage=[UIImage imageNamed:@"bz.png"];
    self.view.backgroundColor=[UIColor whiteColor];
    
}
-(void)stopGame{
    //self.tabBarController.tabBar.hidden=NO;
    [time invalidate];
    self.tabBarController.tabBar.hidden=NO;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.tabBarController.tabBar.hidden=YES;

}
-(void)play:(UIButton *)button1{
    label.hidden=YES;
    
    if ([[button1 currentTitle] isEqualToString: @"开始"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self game];
        //定时器继续
        [time setFireDate:[NSDate distantPast]];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if([[button1 currentTitle] isEqualToString: @"暂停"]){
        self.tabBarController.tabBar.hidden=NO;
        [button setTitle:@"开始" forState:UIControlStateNormal];
        //定时器关闭
        [time setFireDate:[NSDate distantFuture]];
    
    }
    else if (isGameOver) {
        [time invalidate];
        label.hidden=NO;
        isPlay=NO;
        isPause=YES;
        [button setTitle:@"开始" forState:UIControlStateNormal];
        [view.sprites removeAllObjects];
        [view init];
       
    }

    
}
-(void)game{
time=[NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(timer:) userInfo:nil repeats:YES];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    CGRect rect=view.hero.frame;
    if(CGRectContainsPoint(rect, point))
    {
        isPress=YES;
        prePoint=point;
    }
    else
    {
        isPress=NO;
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];//从集合里取出任意一个对象
    CGPoint point=[touch locationInView:self.view];
    if(isPress)
    {
        float x=point.x-prePoint.x;
        float y=point.y-prePoint.y;
        view.hero.origin=CGPointMake(view.hero.origin.x+x, view.hero.origin.y+y);
        prePoint=point;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isPress=NO;
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isPress=NO;
}
-(void)timer:(NSTimer *)sender
{
    NSMutableArray * foes=[[NSMutableArray alloc]init];
    NSMutableArray * bullets=[[NSMutableArray alloc]init];
    //更新精灵位置
    for(ZHQSprite * s in view.sprites)
    {
        if([s isMemberOfClass:[ZHQFoe class]])
        {
            [foes addObject:s];
        }
        if([s isMemberOfClass:[ZHQBullet class]])
        {
            [bullets addObject:s];
        }
        //NSLog(@"foe=%d,bullet=%d,sprite=%d",foes.count,bullets.count,view.sprites.count);
        [s update];
    }

    static int count=1;//计数器
    count++;
    if(count%5==0)//够5次
    {
        //放入一个敌人
        ZHQFoe * foe=[[ZHQFoe alloc]initWithBounds:self.view.bounds andWithImage:foeImage];
        [view.sprites addObject:foe];
        
        //放入子弹
        ZHQBullet * bullet=[[ZHQBullet alloc]initWithBounds:view.hero.frame andWithImage:bulletImage];
        [view.sprites addObject:bullet];
        
        count=1;//清空
    }
    //碰撞检测
    for(ZHQSprite * foe in foes)//遍历敌人
    {
        for(ZHQSprite * bullet in bullets)//遍历子弹
        {
            if([foe Collision:bullet])//敌人和子弹碰撞
            {
                foe.isNotUsed=YES;
                bullet.isNotUsed=YES;
                ZHQBoom * boom=[[ZHQBoom alloc]initWithBounds:foe.frame andWithImage:boomImage];
                [view.sprites addObject:boom];
            }
        }
        //敌人和英雄碰撞
        if([foe Collision:view.hero])
        {
            [sender invalidate];
            label.hidden=NO;
            isGameOver=YES;
            [self play:nil];
            
        }
    }
    //刷新界面
    [self.view setNeedsDisplay];
}

@end
