//
//  IWFormData.h
//  MeiJia
//
//  Created by Jabraknight on 15/5/27.
//  Copyright (c) 2015年 YyJd. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用来封装文件数据的模型
 */
@interface IWFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
/*
 * 文件路径
 */
@property (nonatomic, copy) NSString *filePath;
@end
