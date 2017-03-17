//
//  SCXScaleImage.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/4.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXScaleImage.h"

@implementation SCXScaleImage
+(UIImage *)scaleImageWithOriginImage:(UIImage *)originImage andAimSize:(CGSize)aimSize{
    UIGraphicsBeginImageContextWithOptions(aimSize, NO, 0);
    [originImage drawInRect:CGRectMake(0, 0, aimSize.width, aimSize.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;

}
@end
