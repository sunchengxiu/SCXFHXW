//
//  SCXImage.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/4.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXImage.h"

@implementation SCXImage
-(NSArray *)imageArray{
return [NSArray arrayWithObjects:[UIImage imageNamed:@"1.JPG"],[UIImage imageNamed:@"2.JPG"],[UIImage imageNamed:@"3.JPG"],[UIImage imageNamed:@"4.JPG"],[UIImage imageNamed:@"5.JPG"],[UIImage imageNamed:@"6.JPG"], nil];

}
-(NSArray *)textArray{
    return [NSArray arrayWithObjects:@"男士潮流假两件套衬衫，有胸针,男士潮流假两件套衬衫，有胸针,男士潮流假两件套衬衫，有胸针",@"男士秋冬潮流呢大衣，潮男必备, 限时降价",@"情侣过膝棉衣，拉风必备",@"男士冬季潮流呢大衣，加厚",@"男士春季外套西服，特价",@"型男加长版西服外套，潮男必备", nil];
}
-(NSArray *)priceArray{

    return [NSArray arrayWithObjects:@"￥100.00",@"￥123.00",@"￥254.00",@"￥138.00",@"￥235.00",@"￥128.00", nil];
}
-(NSArray *)musicArray{
    return [NSArray arrayWithObjects:@"动画片《天空之城》主题曲",@"毁灭性硬妹子-虞姬",@"金总 精神小伙社会摇 Dj",@"梁咏琪-社会摇",@"无限社会摇-安喆",@"萧全 - 社会摇 - Dj版", nil];

}
-(NSArray *)musicImageArray{
    return [NSArray arrayWithObjects: [UIImage imageNamed:@"111.jpg"],[UIImage imageNamed:@"222.jpg"],[UIImage imageNamed:@"333.jpg"],[UIImage imageNamed:@"444.jpg"],[UIImage imageNamed:@"555.jpg"],[UIImage imageNamed:@"666.jpg"], nil];

}
@end
