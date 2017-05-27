//
//  UIScrollView+HideKeyboard.m
//  JadeSource
//
//  Created by Daniel on 17/3/15.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "UIScrollView+HideKeyboard.h"
#import <objc/runtime.h>

const NSString *hitTestHideDisabled;
@implementation UIScrollView (HideKeyboard)
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    
    NSNumber *number = objc_getAssociatedObject(self, &hitTestHideDisabled);
    // 如果可用
    if (![number boolValue]) {
        if (![view isKindOfClass:[UITextField class]] &&
            ![view isKindOfClass:[UITextView class]]) {
            [self endEditing:true];
            UIView *superView = self.superview;
            if (superView) {
                [superView endEditing:true];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShouldHideKeyboard" object:nil];
        }
    }
    return view;
}

// 是不是不可用
- (void)setHitTestHideKeyboardDisable:(BOOL)disable {
    objc_setAssociatedObject(self,&hitTestHideDisabled, @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
