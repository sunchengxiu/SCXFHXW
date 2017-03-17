//
//  SCXShopTableViewController.m
//  网易新闻
//
//  Created by 孙承秀 on 15/12/3.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXShopTableViewController.h"

@interface SCXShopTableViewController (){
    NSArray *array;
}

@end

@implementation SCXShopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerClass:[SCXShopTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXGoodsViewController *goods=[[SCXGoodsViewController alloc]init];
    SCXImage *image=[[SCXImage alloc]init];
    goods.image=[SCXScaleImage scaleImageWithOriginImage:image.imageArray[indexPath.row] andAimSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.width)];
    goods.descriptionStr=image.textArray[indexPath.row];
    goods.priceStr=image.priceArray[indexPath.row];
    [self presentViewController:goods animated:YES completion:^{
        
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // static NSString *cellId=@"CELL";
//    SCXShopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell==nil) {
//        cell=[[SCXShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    SCXShopTableViewCell *cell=[[SCXShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL" withIndexPath:indexPath withTableViewController:self];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
