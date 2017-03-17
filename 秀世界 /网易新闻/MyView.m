//
//  MyView.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "MyView.h"

@implementation MyView
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.sprites=[[NSMutableArray alloc]init];
        self.hero=[[ZHQHero alloc]initWithBounds:[UIScreen mainScreen].bounds andWithImage:[UIImage imageNamed:@"nc.png"]];
        [self.sprites addObject:self.hero];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    //移除无用的精灵
    NSMutableArray * clears=[[NSMutableArray alloc]init];
    for(ZHQSprite * s in self.sprites)
    {
        if(s.isNotUsed)
        {
            [clears addObject:s];
        }
    }
    [self.sprites removeObjectsInArray:clears];
    //显示所有的精灵
    for(ZHQSprite * s in self.sprites)
    {
        [s draw];
    }
    //NSLog(@"%lu",(unsigned long)self.sprites.count);
}
@end
