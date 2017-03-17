//
//  SCXShopTableViewCell.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/3.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXShopTableViewCell.h"

@implementation SCXShopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndexPath:(NSIndexPath *)indexPath withTableViewController:(UITableViewController *)tableViewController{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpcell];
        SCXImage *image=[[SCXImage alloc]init
        ];
        _tableViewController=tableViewController;
        NSLog(@"%ld",(long)indexPath.row);
        _image=image.imageArray[indexPath.row];
        _image=[SCXScaleImage scaleImageWithOriginImage:image.imageArray[indexPath.row] andAimSize:_image.size];
        _str=[NSString stringWithString:image.textArray[indexPath.row]];;
        _price=[NSString stringWithString:image.priceArray[indexPath.row]];
    }
    return self;
}
-(void)setUpcell{

    _imageView1=[[UIImageView alloc]init];
    _textLabel1=[[UILabel alloc]init];
    _textLabel2=[[UILabel alloc]init];
}

//懒加载
//-(UIImageView *)imageView1{
//    if (_imageView1==nil) {
//        _imageView1=[[UIImageView alloc]initWithFrame:CGRectZero];
//        [_imageView1 setBackgroundColor:[UIColor redColor]];
//        [self.contentView addSubview:_imageView1];
//    }
//    return _imageView1;
//}
//-(UILabel *)textLabel1{
//    if (!_textLabel1) {
//        _textLabel1=[[UILabel alloc]init];
//    }
//    return _textLabel1;
//}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView1.frame=CGRectMake(50, 0, 300, 300);
    [_imageView1 setBackgroundColor:[UIColor redColor]];
    [_imageView1 setImage:_image];
    _textLabel1.frame=CGRectMake(50, _imageView1.frame.size.height+_imageView1.frame.origin.y, _imageView1.frame.size.width, 30);
    //_textLabel1.numberOfLines=1;
    //_textLabel1.lineBreakMode= NSLineBreakByWordWrapping;
    //[_textLabel1 setBackgroundColor:[UIColor grayColor]];
    [_textLabel1 setText:_str];
    _textLabel2.frame=CGRectMake(_textLabel1.frame.origin.x, _textLabel1.frame.origin.y+_textLabel1.frame.size.height-2, _textLabel1.frame.size.width, 20);
    [_textLabel2 setTextColor:[UIColor redColor]];
    [_textLabel2 setText:_price];
    [self.contentView addSubview:_imageView1];
    [self.contentView addSubview:_textLabel1];
    [self.contentView addSubview:_textLabel2];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
}

@end
