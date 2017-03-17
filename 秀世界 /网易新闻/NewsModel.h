//
//  NewsModel.h
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,strong)NSString *thumbnail ;//标题图片
@property(nonatomic,strong)NSString *online ;//在线人数
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *source ;//资源来源
@property(nonatomic,copy)NSString *updateTime;//更新时间
@property(nonatomic,copy)NSString *id;//点击进入的时候详情
@property(nonatomic,copy)NSString *documentId ;
@property(nonatomic,copy)NSString *type ;//种类
@property(nonatomic,copy)NSString *hasVideo;//是否有视频
@property(nonatomic,copy)NSString *commentsUrl ;//视频地址
@property(nonatomic,copy)NSString *comments ;//评论
@property(nonatomic,copy)NSString *commentsall ;
@property(nonatomic,copy)NSString *styleType ;
@property(nonatomic,strong)NSString *link;//链接
@property(nonatomic,strong)NSDictionary *style;//风格
@property(nonatomic,strong)NSData *imageData;
@end
