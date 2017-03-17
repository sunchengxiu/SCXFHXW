//
//  SCXRegisterViewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/7.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXRegisterViewController.h"

@interface SCXRegisterViewController ()<UITextFieldDelegate>

@end

@implementation SCXRegisterViewController

- (void)viewDidLoad {
    _push=[[SCXPushViewController alloc]init];
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpView];
    
}
-(void)setUpView{
    UIButton *bu=[[UIButton alloc]initWithFrame:CGRectMake(10, 100, 50, 50)];
    [bu setBackgroundColor:[UIColor lightGrayColor]];
    [bu setTitle:@"返回" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(cancel1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 50)];
    [_textField setPlaceholder:@"请输入手机号"];
    [_textField setKeyboardType:UIKeyboardTypeNumberPad];
    _textField.delegate=self;
    _textField.tag=100;
    _textField.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:_textField];
    _textField1=[[UITextField alloc]initWithFrame:CGRectMake(_textField.frame.origin.x, _textField.frame.origin.y+100, 200, 50)];
    _textField1.delegate=self;
    //[_textField1 setBackgroundColor:[UIColor blackColor]];
    _textField1.backgroundColor=[UIColor cyanColor];
    [_textField1 setPlaceholder:@"请输入验证码 "];
    _textField1.tag=200;
    [self.view addSubview:_textField1];
    _button1=[[UIButton alloc]initWithFrame:CGRectMake(_textField1.frame.origin.x+250, _textField1.frame.origin.y, 50, 50)];
    [_button1 setBackgroundColor:[UIColor cyanColor]];
    [_button1 setTitle:@"验证" forState:UIControlStateNormal];
    [self.view addSubview:_button1];
    [_button1 addTarget:self action:@selector(registerCode) forControlEvents:UIControlEventTouchUpInside];
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, _textField1.frame.origin.y+100, 200, 50)];
    [_button setBackgroundColor:[UIColor lightGrayColor]];
    [_button setTitle:@"获取语音验证码" forState:UIControlStateNormal];
    _button.tag=300;
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(yanZheng:) forControlEvents:UIControlEventTouchUpInside];
    
    _button2=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, _button.frame.origin.y+100, 200, 50)];
    [_button2 setBackgroundColor:[UIColor lightGrayColor]];
    [_button2 setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    _button2.tag=400;
    [self.view addSubview:_button2];
    [_button2 addTarget:self action:@selector(yanZheng:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];

}
-(void)cancel1{
    if (self.text) {
        self.text(@"未登录");
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)yanZheng:(UIButton *)button{
    if (button.tag==400) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
         //这个参数可以选择是通过发送验证码还是语言来获取验证码
                                phoneNumber:_textField.text
                                       zone:@"86"
                           customIdentifier:nil //自定义短信模板标识
                                     result:^(NSError *error)
         {
             
             if (!error)
             {
                 NSLog(@"block 获取验证码成功");
                 
             }
             else
             {
                 [self show];
                 
             }
             
         }];
    }
    else if(button.tag==300){
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodVoice
     //这个参数可以选择是通过发送验证码还是语言来获取验证码
                            phoneNumber:_textField.text
                                   zone:@"86"
                       customIdentifier:nil //自定义短信模板标识
                                 result:^(NSError *error)
    {
        
        if (!error)
        {
            NSLog(@"block 获取验证码成功");
            
        }
        else
        {
            [self show];
            
        }
        
    }];
    }
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18810977491" zone:@"86" customIdentifier:@"{Mister_Sun}" result:^(NSError *error) {
//        NSLog(@"--%@",error);
//    }];

}
-(void)show{
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"获取验证码失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    
}
-(void)registerCode{
    [SMSSDK  commitVerificationCode:_textField1.text
     //传获取到的区号
                        phoneNumber:_textField.text
                               zone:@"86"
                             result:^(NSError *error)
     {
         
         if (!error)
         {
            self.text(@"注册成功");
            _push.nameLabel.text=@"注册成功";
             [self dismissViewControllerAnimated:YES completion:nil];
             [self show1];
             
         }
         else
         {
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                             message:@"验证失败!"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];

}
-(void)show1{

        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"验证成功!"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==_textField) {
        self.tel=textField.text;
    }
    else{
        self.code=textField.text;
    }
    NSLog(@"123456%@",textField.text);
    NSLog(@"%@%@",self.tel,self.code);

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
