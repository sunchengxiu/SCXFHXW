//
//  SCXGoodsViewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/4.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXGoodsViewController.h"
#define IMAGEWIDTH (self.view.frame.size.width)
#define HEIGHT (self.view.frame.size.height)
#define kUrl            @"http://218.244.151.190/demo/charge"
@interface SCXGoodsViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>{
    UIButton *exitButton;
    UIButton *shopButton;
    UIButton *shopCarButton;

}

@end

@implementation SCXGoodsViewController

- (void)viewDidLoad {
    
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectWeChatWithAppId:@"4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    
    
    //[ShareSDK connectSinaWeiboWithAppKey:@"1594847813" appSecret:@"17d9814614565b7671f66f54ec379356" redirectUri:@"http://www.sharesdk.cn"];
    [ShareSDK connectSinaWeiboWithAppKey:@"1594847813" appSecret:@"17d9814614565b7671f66f54ec379356" redirectUri:@"http://www.sharesdk.cn" weiboSDKCls:[WeiboSDK class]];
    
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setFrame];
    [self setUpExitButton];
    [self setUpShopButton];
}
-(void)setFrame{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, IMAGEWIDTH ,IMAGEWIDTH )];
    [_imageView setImage:_image];
    [self.view addSubview:_imageView];
    SCXCalculateClass *bound=[[SCXCalculateClass alloc]init];
    CGSize size=[bound boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 0) withText:_descriptionStr ];
    
    _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, _imageView.frame.size.height+_imageView.frame.origin.y,self.view.frame.size.width-160, size.height)];
    //[_textLabel setBackgroundColor:[UIColor grayColor]];
    _textLabel.numberOfLines=0;
    [_textLabel setText:_descriptionStr];
    [self.view addSubview:_textLabel];
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(_textLabel.frame.origin.x,_textLabel.frame.origin.y+_textLabel.frame.size.height, 100, 50)];
    [_priceLabel setText:_priceStr];
    [_priceLabel setTextColor:[UIColor redColor]];
    [self.view addSubview:_priceLabel];

}
-(void)setUpShopButton{
    shopButton=[[UIButton alloc]initWithFrame:CGRectMake(IMAGEWIDTH-20-100, HEIGHT-20-50, 100, 50)];
    shopCarButton=[[UIButton alloc]initWithFrame:CGRectMake(IMAGEWIDTH-20-shopButton.frame.size.width-100, shopButton.frame.origin.y, 100, 50)];
    [shopButton setBackgroundColor:[UIColor redColor]];
    [shopButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [shopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [shopButton addTarget:self action:@selector(shop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopButton];
    
    [shopCarButton setBackgroundColor:[UIColor orangeColor]];
    [shopCarButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopCarButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [shopCarButton addTarget:self action:@selector(fenXiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCarButton];
}
-(void)fenXiang{
    
    
    
    
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:nil
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器，iPad需要，iPhone上非必要，可对应查看文档第10个步骤
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:shopCarButton arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    //自定义标题栏相关委托
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"孙承秀"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeFacebook,
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeSMS,
                          ShareTypeQQ,ShareTypeQQSpace,
                          ShareTypeMail,
                          ShareTypeCopy,ShareTypeSinaWeibo,nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                            }];
    
//    //弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
//

    
}
-(void)shop:(UIButton *)button{
//
//    NSString *orderNo=[SCXCalculateClass rand_orderNo:12];
//    NSArray *display=@[@[@"商品",@[@"_descriptionStr"]],@[@"运费",@[@0]]];
    [self pay];
}
-(void)pay{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"请选择付款方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信",@"支付宝",@"银联",@"百度钱包", nil];
    [action showInView:self.view];

}
-(void)setUpExitButton{

    exitButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 40, 50, 50)];
    [exitButton.layer setMasksToBounds:YES];
    [exitButton.layer setCornerRadius:25];
    [exitButton setBackgroundColor:[UIColor grayColor]];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [exitButton setTitle:@"<" forState:UIControlStateNormal];
    [exitButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:exitButton];

}
-(void)exit{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setUpAlertView:(NSString *)msg{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        self.channel=@"wx";
        [self setUpAlertView:@"您确定使用微信支付?"];
    }
    else if (buttonIndex==1){
        self.channel=@"alipay";
        [self setUpAlertView:@"您确定使用支付宝支付?"];
    }
    else if (buttonIndex==2){
        self.channel=@"upacp";
        [self setUpAlertView:@"您确定使用银联支付?"];
    }
    else if(buttonIndex==3){
        self.channel=@"bfb";
        [self setUpAlertView:@"您确定使用百度钱包支付?"];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self setUpPayInfo];
    }
    
    
}
-(void)setUpPayInfo{
    long amount=[_priceStr substringFromIndex:1].longLongValue;
    NSString *amountStr=[NSString stringWithFormat:@"%ld",amount];
    NSDictionary *dic=@{@"channel":self.channel,@"amount":amountStr};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:kUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[NSData dataWithBytes:[dataStr UTF8String] length:strlen([dataStr UTF8String])]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSHTTPURLResponse *reponse1=(NSHTTPURLResponse *)response;
        if (reponse1.statusCode!=200) {
            NSLog(@"网络链接错误!");
            return ;
        }
        if (connectionError!=nil) {
            NSLog(@"网络链接错误!");
            return;
        }
        NSString *charge=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Pingpp createPayment:charge viewController:self appURLScheme:@"BossSunPing++Pay"  withCompletion:^(NSString *result, PingppError *error) {
                if (error == nil) {
                    NSLog(@"PingppError is nil");
                } else {
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                }

            }];
        });
        
    }];

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
