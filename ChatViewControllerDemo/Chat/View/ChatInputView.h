//
//  ChatInputView.h
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWFormData.h"

@interface ChatInputView : UIView<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *imgBtn;
@property (nonatomic, copy)void(^sendBlock)(NSString *text);

// 评论所需
@property (nonatomic, copy)NSString *uname;

+ (instancetype)sharekeyboard;
- (void)show;
- (void)dismiss;
@end
