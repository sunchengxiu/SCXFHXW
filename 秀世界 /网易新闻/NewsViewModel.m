//
//  NewsViewModel.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "NewsViewModel.h"
#import "NetWorking.h"
#import "NewsTableVIewController.h"
@interface NewsViewModel(){

    NSArray *infoArray;
}
@end
@implementation NewsViewModel
-(instancetype)init{
    self=[super init];
    if (self) {
        _newsArray=[[NSMutableArray alloc]initWithCapacity:100];
        _scrollArray=[[NSMutableArray alloc]initWithCapacity:100];
    }
    return self;
}
+(void)downLoadNews:(NSString *)urlString{
   [NetWorking downLoadNewsUseGet:urlString];
    
}
-(void)downLoadNewsSuccess:(NSArray *)array{
    NSArray *itemsArray=[array[0]objectForKey:@"item"];
    for (NSInteger i=0; i<itemsArray.count; i++) {
        NewsModel *model=[[NewsModel alloc]init];
        [model setValuesForKeysWithDictionary:itemsArray[i]];
        model.imageData=[NetWorking downloadImage:model.thumbnail];
        [_newsArray addObject:model];
    }
    NSArray *scrollArray=[array[1] objectForKey:@"item"];
    for (NSInteger i=0; i<scrollArray.count; i++) {
        NewsModel *model=[[NewsModel alloc]init];
        [model setValuesForKeysWithDictionary:scrollArray[i]];
        model.imageData=[NetWorking downloadImage:model.thumbnail];
        [_scrollArray addObject:model];
    }
    //NSLog(@"%@",_scrollArray);
    NSArray *arr=[NSArray arrayWithObjects:_newsArray,_scrollArray,scrollArray, nil];
   // NSLog(@"%ld",arr.count);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SUCCESS" object:arr];
}
@end
