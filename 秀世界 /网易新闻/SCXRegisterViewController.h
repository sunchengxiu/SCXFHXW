//
//  SCXRegisterViewController.h
//  网易新闻
//
//  Created by 孙承秀 on 15/12/7.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXPushViewController.h"
@interface SCXRegisterViewController : UIViewController
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITextField *textField1;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)SCXPushViewController *push;
@property(nonatomic,strong)void (^text)(NSString *str);
@end
