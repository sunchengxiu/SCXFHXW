//
//  SCXGoodsViewController.h
//  网易新闻
//
//  Created by 孙承秀 on 15/12/4.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
@interface SCXGoodsViewController : UIViewController
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)NSString *descriptionStr;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)NSString *priceStr;
@property(nonatomic,strong)NSString *channel;
@end
