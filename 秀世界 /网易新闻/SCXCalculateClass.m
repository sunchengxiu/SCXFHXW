//
//  SCXCalculateClass.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/15.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXCalculateClass.h"

@implementation SCXCalculateClass
+(NSString *)rand_orderNo:(int)length{

char order[]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    char orderNo[length];
    for (int i=0; i<length; orderNo[i++]=(char)order[arc4random_uniform(62)]);
    return [[NSString alloc]initWithBytes:orderNo length:length encoding:NSUTF8StringEncoding];

}
- (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    
    CGSize retSize = [str boundingRectWithSize:size
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
+(void)downLoadImage:(NewsModel *)model withImageView:(UIImageView *)imageView withString:(NSString *)str{
    NSString *string;
    if (str==nil) {
         string=model.thumbnail;
    }
    else{
        string=str;
    }
    NSURL *url=[NSURL URLWithString:string];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"图标3.png"]];

}
+(BOOL)examineNetworkingReachabilityWithUrlstring:(NSString *)urlString{
    __block BOOL netState=NO;
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:urlString]];
    NSOperationQueue *queue=manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [queue setSuspended:NO];
                netState=YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
              
            default:
                  netState=NO;
                [queue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    //NSLog(@"%ld",netState);
    return netState;
}
+(void)setAlertViewWithWarnString:(NSString *)warnString andViewController:(UIViewController *)viewController{

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:warnString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *knowAction=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:knowAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}
+(NSString *)path:(NSString *)databasePath{

    NSString *path=NSHomeDirectory();
    NSString *dataBasePath=[path stringByAppendingPathComponent:@"Documents"];
    return [dataBasePath stringByAppendingPathComponent:databasePath];
}
@end
