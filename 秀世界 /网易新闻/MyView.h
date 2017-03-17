//
//  MyView.h
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHQSprite.h"
#import "ZHQHero.h"
@interface MyView : UIView
//所有精灵
@property (strong,nonatomic) NSMutableArray * sprites;
//英雄
@property (strong,nonatomic) ZHQHero * hero;
@end
