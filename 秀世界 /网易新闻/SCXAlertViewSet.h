//
//  SCXAlertViewSet.h
//  网易新闻
//
//  Created by 孙承秀 on 15/12/5.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXAlertViewSet : NSObject
+(void)setAlertViewWithViewController:(UIViewController *)viewController andMessage:(NSString *)msg;
+(void)setUpPayAlert:(UIViewController *)viewController andMessage:(NSString *)msg;
@end
