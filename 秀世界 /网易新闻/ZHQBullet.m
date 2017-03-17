//
//  ZHQBullet.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQBullet.h"

@implementation ZHQBullet
//rect是英雄的frame
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image
{
    self=[super initWithBounds:rect andWithImage:image];
    if(self)
    {
        self.origin=CGPointMake(rect.origin.x+rect.size.width/2-image.size.width/2, rect.origin.y-image.size.height);
    }
    return self;
}
-(void)update
{
    self.origin=CGPointMake(self.origin.x, self.origin.y-STEP);
    if(self.origin.y<-self.image.size.height)
    {
        self.isNotUsed=YES;
    }
}
@end
