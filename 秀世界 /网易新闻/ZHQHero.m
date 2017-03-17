//
//  ZHQHero.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQHero.h"

@implementation ZHQHero
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image
{
    self=[super initWithBounds:rect andWithImage:image];
    if(self)
    {
        self.origin=CGPointMake((rect.size.width-image.size.width)/2, rect.size.height-image.size.height);
    }
    return self;
}
@end
