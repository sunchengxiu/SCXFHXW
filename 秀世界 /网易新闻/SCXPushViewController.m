//
//  SCXPushViewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/7.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXPushViewController.h"
#import "YJViewController.h"
#import "SCXRegisterViewController.h"
@interface SCXPushViewController ()

@end

@implementation SCXPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [self setUpLabel];
    [self setUPButton];
}
-(void)setUpLabel{
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 50)];
    [_nameLabel setBackgroundColor:[UIColor grayColor]];
    [_nameLabel setText:@"未登录"];
    [self.view addSubview:_nameLabel];

}
-(void)setUPButton{
    _registerButton=[[UIButton alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y+100, 200, 50)];
    [_registerButton.layer setMasksToBounds:YES];
    [_registerButton.layer setCornerRadius:4];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_registerButton setBackgroundColor:[UIColor grayColor]];
    [_registerButton addTarget:self action:@selector(registerTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
}
-(void)registerTap{
    
    
    
    SCXRegisterViewController *registerView=[[SCXRegisterViewController alloc]init];
    [registerView setText:^(NSString *str) {
        self.nameLabel.text=str;
    }];
    
    [self.navigationController presentViewController:registerView animated:YES completion:nil];
   
    
//    YJViewController *yj=[[YJViewController alloc]init];
//    [self.navigationController presentViewController:yj animated:YES completion:nil];
}
-(void)done{


}
-(void)cancel{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
