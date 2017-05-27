//
//  MessageModel.h
//  ChatViewControllerDemo
//
//  Created by WeiLuezh on 2017/5/27.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeText = 0,
    MessageTypeImage = 1,
};

@interface MessageModel : NSObject
@property (nonatomic, assign)MessageType messageType;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, strong)id icon;
@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *text;
@property (nonatomic, strong)id image;

+ (instancetype)modelWithUserId:(NSString *)userId name:(NSString *)name userIcon:(id)icon sendedText:(NSString *)text;
+ (instancetype)modelWithUserId:(NSString *)userId name:(NSString *)name userIcon:(id)icon sendedImage:(id)image;

@end
