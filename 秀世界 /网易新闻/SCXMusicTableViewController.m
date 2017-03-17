//
//  SCXMusicTableViewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/5.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXMusicTableViewController.h"
#import "JingRoundView.h"
#import <AVFoundation/AVFoundation.h>
#define STEP 5
@interface SCXMusicTableViewController ()<JingRoundViewDelegate>{
    UIView *scrollView;
    UIImageView *imageView;
   
    UIButton *nextButton;
    UIButton *previousButton;
    UILabel *Label;
    NSArray *musicTextArray;
    NSArray *musicArray;
    NSInteger count;
    CGSize size;
    AVAudioPlayer *player;
    
}

@end
static SCXMusicTableViewController *music=nil;
@implementation SCXMusicTableViewController
@synthesize isPlay;
@synthesize playButton;
+(SCXMusicTableViewController *)sharedMusic{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        music=[SCXMusicTableViewController new];
    });
    return music;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [[UIApplication sharedApplication]becomeFirstResponder];
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backGroundPlay) name:AVAudioSessionInterruptionNotification object:nil];
    
    if(![[AVAudioSession sharedInstance] setActive:YES error:nil])
    {
        NSLog(@"Failed to set up a session.");
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    JingRoundView *jing=[[JingRoundView alloc]init];
    [jing drawRect:CGRectMake(100, 100, 100, 100)];
    self.roundView.delegate = self;
    self.roundView.roundImage = [UIImage imageNamed:@"girl"];
    self.roundView.rotationDuration = 8.0;
    self.roundView.isPlay = NO;
    [self.view setNeedsDisplay];
    [self setUpArray];
    [self setUpView];
    [self setUpButton];
}
-(void)backGroundPlay{
    NSLog(@"后台中断");
    [self pause];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    count=0;
   
    
}
-(void)setUpButton{
    nextButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, self.view.frame.size.height-200, 100, 50)];
    [nextButton setBackgroundColor:[UIColor redColor]];
    nextButton.layer.masksToBounds=YES;
    nextButton.layer.cornerRadius=4;
    [nextButton setTitle:@"下一曲" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    previousButton=[[UIButton alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height-200, 100, 50)];
    [previousButton setBackgroundColor:[UIColor redColor]];
    previousButton.layer.masksToBounds=YES;
    previousButton.layer.cornerRadius=4;
    [previousButton setTitle:@"上一曲" forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    
    playButton=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-200, 100, 50)];
    [playButton setBackgroundColor:[UIColor redColor]];
    playButton.layer.masksToBounds=YES;
    playButton.layer.cornerRadius=50;
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(Play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
    [self resignFirstResponder];

}
-(void)Play:(UIButton *)Button{
   
   //[player stop];
    if (count<=musicArray.count&&count>=0&&[[playButton currentTitle]isEqualToString:@"播放"]) {
        isPlay=YES;
                [self play];
    }
    
    else if ([[playButton currentTitle]isEqualToString:@"暂停"]) {
        isPlay=NO;
        [self pause];
    }
}
-(void)pause{
    [self setText];
     [self prepareMusic];
     [playButton setTitle:@"播放" forState:UIControlStateNormal];
     [player stop];
    isPlay=NO;

}
-(void)play{
    [self setText];
    [self prepareMusic];
    [playButton setTitle:@"暂停" forState:UIControlStateNormal];
    [player stop];
    [player play];
    isPlay=YES;
}
-(void)setText{
    SCXCalculateClass *bound=[[SCXCalculateClass alloc]init];
    NSString *str1=musicTextArray[count];
    size=[bound boundingRectWithSize:CGSizeMake(0,50) withText:str1];
    
    Label.frame=CGRectMake(0, 80, size.width,50);
    [Label setText:musicTextArray[count]];
}
-(void)prepareMusic{
    NSString *str=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%ld",count] ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:str];
    NSData *data=[NSData dataWithContentsOfURL:url];
    [player stop];
    player=[[AVAudioPlayer alloc]initWithData:data error:nil];
    [player prepareToPlay];
    
}
-(void)previous:(UIButton *)button{
    [player stop];
    if (count>0) {
        Label.frame=CGRectMake(scrollView.bounds.origin.x+scrollView.bounds.size.width, 80, size.width,50);
        count--;
        [self play];
    }
    
}
-(void)next:(UIButton *)button{
    [player stop];
    count++;
    if (count<musicArray.count) {
         Label.frame=CGRectMake(400, 80, size.width,50);
        [self play];
    }
    else{
    count--;
    }
}

-(void)text{
    Label.frame=CGRectMake(Label.frame.origin.x-STEP, scrollView.bounds.origin.y, size.width, 50) ;
    
    if (Label.frame.origin.x+Label.frame.size.width<scrollView.bounds.origin.x) {
        [Label setFrame:CGRectMake(scrollView.bounds.origin.x+scrollView.bounds.size.width, scrollView.bounds.origin.y, size.width, 50)];
    }
}
-(void)setUpView{
   scrollView=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 80, 300, 50)];
    [scrollView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:scrollView];
    scrollView.clipsToBounds=YES;
    [Label setFont:[UIFont systemFontOfSize:20]];
    Label.numberOfLines=0;
    Label=[[UILabel alloc]init];
    [self setText];
    [scrollView addSubview:Label];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(text) userInfo:nil repeats:YES];
}
-(void)setUpArray{
    musicTextArray=[NSArray arrayWithObjects:@"动画片《天空之城》主题曲",@"毁灭性硬妹子-虞姬",@"金总 精神小伙社会摇 Dj",@"梁咏琪-社会摇",@"无限社会摇-安喆",@"萧全 - 社会摇 - Dj版", nil];
    musicArray=[NSArray arrayWithObjects:@"1.mp3",@"2.mp3",@"3.mp3",@"4.mp3",@"5.mp3",@"6.mp3", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)playStatuUpdate:(BOOL)playState
{
    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}
@end
