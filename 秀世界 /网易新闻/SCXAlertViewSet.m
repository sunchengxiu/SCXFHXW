//
//  SCXAlertViewSet.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/5.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXAlertViewSet.h"

@implementation SCXAlertViewSet
+(void)setAlertViewWithViewController:(UIViewController *)viewController andMessage:(NSString *)msg{
   
}
+(void)setUpPayAlert:(UIViewController *)viewController andMessage:(NSString *)msg{

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    [viewController presentViewController:alert animated:YES completion:nil];

}
@end
