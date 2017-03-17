//
//  NetWorking.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "NetWorking.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
@implementation NetWorking
+(void)downLoadNewsUseGet:(NSString *)urlString{
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
    __block NSArray *array;
    AFHTTPRequestOperation *operation= [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        array=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NewsViewModel *viewModel=[[NewsViewModel alloc]init];
        [viewModel downLoadNewsSuccess:array];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    [operation start];
    
}
+(NSData *)downloadImage:(NSString *)imageUrlString{
    NSURL *url=[NSURL URLWithString:imageUrlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    UIImageView *imageVIew=[[UIImageView alloc]init];
    __block NSData *data;
    [imageVIew setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        data=UIImageJPEGRepresentation(image, 1);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"jshdfj");
    }];
    //NSLog(@"%@",data);
    return data;
}
@end
