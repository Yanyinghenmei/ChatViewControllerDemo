//
//  ChatLeftImgTableViewCell.m
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ChatLeftImgTableViewCell.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface ChatLeftImgTableViewCell ()
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidth;
@end

@implementation ChatLeftImgTableViewCell {
    
}

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


- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer= [CAShapeLayer layer];
        
        _shapeLayer.contents = (id)[UIImage imageNamed:@"liaotianbeijing1"].CGImage;
        _shapeLayer.contentsCenter = CGRectMake(0.5, 0.8, 0.1, 0.1);
        _shapeLayer.contentsScale = [UIScreen mainScreen].scale;
        
        _imgView.layer.mask = _shapeLayer;
        _imgView.layer.frame = _imgView.frame;
    }
    return _shapeLayer;
}

- (void)setImgViewImage:(UIImage *)image {
    _imgView.image = image;
    CGRect frame;
    if (_imgView.image) {
        if (_imgView.image.size.width <= 40 || _imgView.image.size.height <= 40) {
            if (_imgView.image.size.width < _imgView.image.size.height) {
                frame = CGRectMake(0, 0, 40, _imgView.image.size.height * (40)/_imgView.image.size.width);
            } else {frame = CGRectMake(0, 0, _imgView.image.size.width * (40)/_imgView.image.size.height, 40);
            }
        } else if (_imgView.image.size.width <= kScreenWidth-120) {
            frame = CGRectMake(0, 0, _imgView.image.size.width, _imgView.image.size.height);
        } else {
            frame = CGRectMake(0, 0, kScreenWidth-120, _imgView.image.size.height * (kScreenWidth-120)/_imgView.image.size.width);
        }
        _imgWidth.constant = frame.size.width;
        _imgHeight.constant = frame.size.height;
        self.shapeLayer.frame = frame;
    }
}


@end
