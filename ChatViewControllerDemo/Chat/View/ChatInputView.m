//
//  ChatInputView.m
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ChatInputView.h"
#import "UIScrollView+HideKeyboard.h"

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// 16进制 -> rgb颜色
#define HEXCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define TextViewHeight 40.f
#define InputBarHeight 51.f

@implementation ChatInputView


+ (instancetype)sharekeyboard {
    ChatInputView *keyboardView = [[ChatInputView alloc] initWithFrame:CGRectMake(0, DeviceHeight-InputBarHeight, DeviceWidth, 329.5)];
    return keyboardView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLORV(0xffffff);
        self.layer.borderColor = HEXCOLORV(0xeeeeee).CGColor;
        self.layer.borderWidth = .5f;
        
        CGFloat btnWidth = InputBarHeight-10;
        CGFloat btnHeight = InputBarHeight-20;
        _imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, btnWidth, btnHeight)];
        [_imgBtn setImage:[UIImage imageNamed:@"chat_img"] forState:UIControlStateNormal];
        [self addSubview:_imgBtn];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgBtn.frame)+5, 5, DeviceWidth-btnWidth-10-5-10, TextViewHeight)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderColor = HEXCOLORV(0xcccccc).CGColor;
        _textField.layer.borderWidth = .5f;
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = true;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.leftView = ({
            UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            left;});
        _textField.leftViewMode = UITextFieldViewModeAlways;
        //_textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.returnKeyType = UIReturnKeySend;
        _textField.delegate = self;
        _textField.enablesReturnKeyAutomatically = YES;
        [self addSubview:_textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)sendBtnClick:(UIButton *)btn {
    [self textFieldShouldReturn:_textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (_sendBlock) {
        _sendBlock(textField.text);
    }
    return YES;
}

- (void)show {
    if (_uname) {
        _textField.placeholder = [NSString stringWithFormat:@"回复 %@", _uname];
    } else {
        _textField.placeholder = nil;
    }
    [_textField becomeFirstResponder];
}

- (void)dismiss {
    _uname = nil;
    [_textField resignFirstResponder];
}

- (void)showNotification:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘高度
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, DeviceHeight-keyboardSize.height-InputBarHeight, DeviceWidth, keyboardSize.height+InputBarHeight);
    }];
}

- (void)dismissNotification:(NSNotification*)notification {
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.frame;
    frame.origin.y = DeviceHeight-InputBarHeight;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
