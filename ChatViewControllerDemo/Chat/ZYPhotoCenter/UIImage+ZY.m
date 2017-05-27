//
//  UIImage+ZY.m
//  WB
//
//  Created by qianfeng on 15/4/10.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import "UIImage+ZY.h"

@implementation UIImage (ZY)

+ (UIImage *)templateImageWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)imageWithContentsName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)resizedImageWithNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    
    //保护图片某部分不被拉伸
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}

//根据图片名
+ (UIImage *)reSizedImageWithSize:(CGSize)size imageName:(NSString *)name {
    UIGraphicsBeginImageContext(size);
    UIImage *image = [UIImage imageNamed:name];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *new = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new;
}

//根据图片
+ (UIImage *)reSizedImageWithSize:(CGSize)size image:(UIImage *)image {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *new = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new;
}

// 颜色 -> 图片
+ (UIImage*)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
