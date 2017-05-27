//
//  ChatLeftTableViewCell.m
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ChatLeftTableViewCell.h"

@implementation ChatLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _icon.layer.cornerRadius = _icon.frame.size.width/2;
    _icon.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
