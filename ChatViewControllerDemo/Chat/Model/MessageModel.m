//
//  MessageModel.m
//  ChatViewControllerDemo
//
//  Created by WeiLuezh on 2017/5/27.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (instancetype)modelWithUserId:(NSString *)userId name:(NSString *)name userIcon:(id)icon sendedText:(NSString *)text {
    MessageModel *model = [MessageModel new];
    model.user_id = userId;
    model.name = name;
    model.icon = icon;
    model.text = text;
    model.messageType = MessageTypeText;
    return model;
}
+ (instancetype)modelWithUserId:(NSString *)userId name:(NSString *)name userIcon:(id)icon sendedImage:(id)image{
    MessageModel *model = [MessageModel new];
    model.user_id = userId;
    model.name = name;
    model.icon = icon;
    model.image = image;
    model.messageType = MessageTypeImage;
    return model;
}
@end
