//
//  NewsTableViewCell.m
//  网易新闻
//
//  Created by 孙承秀 on 15/11/14.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "NewsTableViewCell.h"
@interface NewsTableViewCell(){
    UIImageView *imageView;
    UILabel *titleLabel;//显示label
    UILabel *styleTypeLabel;//显示专题或者直播
    UILabel *typeLabel;// 显示是否进行时
    UILabel *commentsallLabel;//显示评论次数
    UILabel *hasVideoLabel;//显示是否有视频
    UILabel *titleLabel1;//显示label
    UILabel *styleTypeLabel1;//显示专题或者直播
    NSArray *imagesArray;
    UILabel *label;

}


@end

@implementation NewsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpCell];
    }
    return self;

}
-(void)setUpCell{
    imageView=[[UIImageView alloc]init];
    //[imageView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:imageView];
    titleLabel=[[UILabel alloc]init];
    titleLabel1=[[UILabel alloc]init];
    titleLabel1.hidden=YES;
    [titleLabel1 setTextColor:[UIColor blueColor]];
    [titleLabel setTextColor:[UIColor blueColor]];
    //[titleLabel1 setFont:[UIFont systemFontOfSize:25]];
    //[titleLabel1 setBackgroundColor:[UIColor cyanColor]];
    [self.contentView addSubview:titleLabel];
    styleTypeLabel=[[UILabel alloc]init];
    //[styleTypeLabel setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:styleTypeLabel];
    styleTypeLabel1=[[UILabel alloc]init];
    styleTypeLabel1.hidden=YES;
    //[styleTypeLabel1 setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:styleTypeLabel1];
    [self.contentView addSubview:titleLabel1];


}
-(void)setUpData:(NewsModel *)model{
    if (model.style!=nil) {
        titleLabel1.hidden=NO;
        titleLabel.hidden=YES;
        styleTypeLabel1.hidden=NO;
        styleTypeLabel.hidden=YES;
        titleLabel1.text=model.title;
        titleLabel1.lineBreakMode=NSLineBreakByCharWrapping;
        titleLabel1.numberOfLines=0;
        imagesArray= [model.style objectForKey:@"images"];
        _count=imagesArray.count;
        for (NSInteger i=0; i<_count; i++) {
            [self setUpImageView:i];
        }
    }
    else{
        styleTypeLabel1.hidden=YES;
        styleTypeLabel.hidden=NO;
        titleLabel1.hidden=YES;
        titleLabel.hidden=NO;
        titleLabel.text=model.title;
        titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
        titleLabel.numberOfLines=0;
        [SCXCalculateClass downLoadImage:model withImageView:imageView withString:nil];
    }
    if ([model.styleType isEqualToString:@"topic"]) {
        [styleTypeLabel setBackgroundColor:[UIColor redColor]];
        [styleTypeLabel setText:@"专题"];
        [styleTypeLabel setTextAlignment:NSTextAlignmentCenter];
        [styleTypeLabel setTextColor:[UIColor whiteColor]];
    }
    if (model.hasVideo!=nil) {
        label=[[UILabel alloc]init];
        [label setText:@"视频"];
        [label setTextColor:[UIColor redColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:label];
        
    }
}
-(void)setUpImageView:(NSInteger )i{
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5+i*(2+([UIScreen mainScreen].bounds.size.width-14)/_count), 30, ([UIScreen mainScreen].bounds.size.width-14)/_count, 140)];
    [SCXCalculateClass downLoadImage:nil withImageView:imageView1 withString:imagesArray[i]];
    [self.contentView addSubview:imageView1];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [imageView setFrame:CGRectMake(5, 10, 100, 80)];
    [titleLabel setFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5, 5, [UIScreen mainScreen].bounds.size.width-imageView.frame.origin.x-imageView.frame.size.width-5, 60)];
    [styleTypeLabel setFrame:CGRectMake(5+imageView.frame.size.width+5, imageView.frame.origin.x+imageView.frame.size.height-20, 50, 20)];
    [styleTypeLabel1 setFrame:CGRectMake(5, self.frame.size.height-20, 50, 20)];
    [titleLabel1 setFrame:CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width-10, 30)];
    [label setFrame:CGRectMake(styleTypeLabel.frame.origin.x+styleTypeLabel.frame.size.width+5, styleTypeLabel.frame.origin.y, 50, 20)];
}
@end
