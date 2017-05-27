//
//  ChatRightImgTableViewCell.h
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/27.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRightImgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
- (void)setImgViewImage:(UIImage *)image;
@end
