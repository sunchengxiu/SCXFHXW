//
//  ZHQBoom.m
//  飞机大战
//
//  Created by wyzc on 15/11/10.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQBoom.h"

@implementation ZHQBoom
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image
{
    self=[super initWithBounds:rect andWithImage:image];
    if(self)
    {
        self.origin=rect.origin;
    }
    return self;
}
-(void)update
{
    self.isNotUsed=YES;
}
@end
