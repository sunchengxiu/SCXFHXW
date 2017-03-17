//
//  ZHQSprite.h
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define STEP 5
@interface ZHQSprite : NSObject
//界面的大小
@property (assign,nonatomic) CGRect rect;
//坐标
@property (assign,nonatomic) CGPoint origin;
//图片
@property (strong,nonatomic) UIImage * image;
//不可用
@property (assign,nonatomic) BOOL isNotUsed;
-(void)draw;//绘制自己
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image;
-(void)update;//更新自己的位置
-(CGRect)frame;
-(BOOL)Collision:(ZHQSprite *)sprite;
@end
