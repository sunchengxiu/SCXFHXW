//
//  ZHQSprite.m
//  飞机大战
//
//  Created by wyzc on 15/11/9.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQSprite.h"

@implementation ZHQSprite
-(id)initWithBounds:(CGRect)rect andWithImage:(UIImage *)image
{
    self=[super init];
    if(self)
    {
        self.rect=rect;
        self.image=image;
    }
    return self;
}
-(void)draw
{
    [self.image drawAtPoint:self.origin];
}
-(void)update
{
    
}
-(CGRect)frame
{
    return CGRectMake(self.origin.x, self.origin.y, self.image.size.width, self.image.size.height);
}
-(BOOL)Collision:(ZHQSprite *)sprite
{
    CGRect me=self.frame;
    CGRect he=sprite.frame;
    return CGRectIntersectsRect(me, he);
}
@end
