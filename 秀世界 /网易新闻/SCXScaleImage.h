//
//  SCXScaleImage.h
//  网易新闻
//
//  Created by 孙承秀 on 15/12/4.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXScaleImage : NSObject
+(UIImage *)scaleImageWithOriginImage:(UIImage *)originImage andAimSize:(CGSize)aimSize;
@end
