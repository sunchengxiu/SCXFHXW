//
//  NewsTableVIewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "NewsTableVIewController.h"
#import "NewsTableViewCell.h"
#import "NewsViewModel.h"
#import "config.h"
#import "SCXPushViewController.h"
@interface NewsTableVIewController()
{
    UISearchBar *searchBar;
}

@end
@implementation NewsTableVIewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    [self.tableView.header beginRefreshing];
    //[self setUpSearchBar];
    [self setUpScroolView];
    _newsArray=[[NSMutableArray alloc]initWithCapacity:100];
   _tableView1=[[UITableView alloc]init];
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    _tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview: _tableView1];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0,0 , 50, 50)];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    //[button setBackgroundColor:[UIColor redColor]];
    [self.navigationItem.leftBarButtonItem setCustomView:button];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [_tableView1 registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"NEWS"];
    __block NewsTableVIewController *tableViewController=[[NewsTableVIewController alloc]init];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
        [tableViewController reload];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [NewsViewModel downLoadNews:NEWSURL];
        [tableViewController reload];
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadSuccess:) name:@"SUCCESS" object:nil];
  
}
-(void)login{
    self.tabBarController.tabBar.hidden=YES;
    SCXPushViewController *push=[[SCXPushViewController alloc]init];
    CATransition *transition=[[CATransition alloc]init];
    [transition setType:kCATransitionPush];
    transition.subtype=kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:push animated:YES];
    
}
-(void)reload{
    //[self.tableView.header beginRefreshing];
    [_newsArray removeAllObjects];
    [NewsViewModel downLoadNews:NEWSURL];
    [self.tableView1 reloadData];
}
-(void)setUpSearchBar{
//    //获得状态栏和导航栏的高度
//    CGRect statusBarFrame=[[UIApplication sharedApplication] statusBarFrame];
//    CGRect navigationBarFrame=self.navigationController.navigationBar.frame;
//    searchBar.frame=CGRectMake(0, statusBarFrame.size.height+navigationBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, 40);
//    [searchBar setPlaceholder:@"搜索"];
//    [self.view addSubview:searchBar];
//    //_tableView1.frame=CGRectMake(0, searchBar.frame.origin.y+40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(statusBarFrame.size.height+navigationBarFrame.size.height)-40);
    
}
-(void)setUpScroolView{
    NSMutableArray *itemArray=[[NSMutableArray alloc]initWithObjects:@"头条",@"推荐",@"娱乐",@"财经",@"自媒体",@"时政",@"凤凰卫视",@"美女",@"段子",@"萌物" ,nil];
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width-20, 44)];
    UIButton *button;
    for (NSInteger i=0; i<itemArray.count; i++) {
        button=[[UIButton alloc]initWithFrame:CGRectMake(5+i*(5+80), 4, 80, 36)];
        
        [button setTitle:itemArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
        //[button setBackgroundColor:[UIColor redColor]];
        [scrollview addSubview:button];
    }
    [scrollview setContentSize:CGSizeMake(button.frame.size.width*itemArray.count, button.frame.size.height)];
   // [scrollview setBackgroundColor:[UIColor cyanColor]];
    scrollview.bounces=NO;
    self.navigationItem.titleView=scrollview;
}
-(void)downloadSuccess:(NSNotification *)object{
    [self.tableView.header endRefreshing];
    NSMutableArray *array=object.object;
    _mutableArray=array;
    //NSLog(@"%ld",array.count);
    _scrollArray=array[2];
    _scrollArray1=array[1];
    _newsArray=array[0];
    [self.tableView reloadData];
   // [SVProgressHUD showWithStatus:@"正在玩命刷新数据中...." maskType:SVProgressHUDMaskTypeBlack];
    if([SCXCalculateClass examineNetworkingReachabilityWithUrlstring:@"https://www.baidu.com"]==NO){
        //[SCXCalculateClass setAlertViewWithWarnString:@"网络连接失败，请检查您的网络。" andViewController:self];
    }
    //[SVProgressHUD dismiss];


}
-(void)viewWillAppear:(BOOL)animated{
    
    [NewsViewModel downLoadNews:NEWSURL];
    [self.tableView1 reloadData];
  

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *newsCell=[[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NEWS"];
    [newsCell setUpData:_newsArray[indexPath.row]];
    return newsCell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArray.count;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model=[[NewsModel alloc]init];
    model=_newsArray[indexPath.row];
    if (model.style!=nil) {
        return 200;
    }
    else{
     return 100;
    }

   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self setUpScrollView1];
}
-(UIScrollView *)setUpScrollView1{
   // NSArray *array=[_mutableArray[2] objectForKey:@"item"];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*_scrollArray.count, 200);
    //[scrollView setBackgroundColor:[UIColor redColor]];
    scrollView.pagingEnabled=YES;
    [self setUpPageControl:scrollView];
    for (NSInteger i=0; i<_scrollArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        //[imageView setBackgroundColor:[UIColor redColor]];
        [SCXCalculateClass downLoadImage:_scrollArray1[i] withImageView:imageView withString:nil];
        [scrollView addSubview:imageView];
    }
    return scrollView;
}
-(void)setUpPageControl:(UIScrollView *)scrollView{
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    [pageControl setNumberOfPages:_scrollArray.count];
    CGSize size=[pageControl sizeForNumberOfPages:_scrollArray.count];
    [pageControl setFrame:CGRectMake(self.view.frame.size.width-size.width-10, 170, size.width, size.height)];
    //[pageControl setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:pageControl];
    

}
@end
