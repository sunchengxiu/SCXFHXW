//
//  ZHQFoe.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQFoe.h"

@implementation ZHQFoe
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image
{
    self=[super initWithBounds:rect andWithImage:image];
    if(self)
    {
        //调整坐标
        self.origin=CGPointMake(arc4random()%(int)(rect.size.width-self.image.size.width),-self.image.size.height);
    }
    return self;
}
-(void)update
{
    //往下走5
    self.origin=CGPointMake(self.origin.x, self.origin.y+STEP);
    //已经超出界面
    if(self.origin.y>self.rect.size.height)
    {
        self.isNotUsed=YES;
    }
}
@end
