//
//  UIImage+ZY.h
//  WB
//
//  Created by qianfeng on 15/4/10.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZY)

// 图片始终可渲染
+ (UIImage *)templateImageWithName:(NSString *)name;

//使用imageWithContentsFile的方式加载图片
+ (UIImage *)imageWithContentsName:(NSString *)name;

+ (UIImage *)resizedImageWithNamed:(NSString *)name;

//重绘图片
+ (UIImage *)reSizedImageWithSize:(CGSize)size imageName:(NSString *)name;
+ (UIImage *)reSizedImageWithSize:(CGSize)size image:(UIImage *)image;

+ (UIImage*)createImageWithColor:(UIColor *)color;

+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size;
@end
