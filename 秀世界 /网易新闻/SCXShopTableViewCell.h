//
//  SCXShopTableViewCell.h
//  网易新闻
//
//  Created by 孙承秀 on 15/12/3.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXShopTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UILabel *textLabel1;
@property(nonatomic,strong)UILabel *textLabel2;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)UITableViewController *tableViewController;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndexPath:(NSIndexPath *)indexPath withTableViewController:(UITableViewController *)tableViewController;

@end
