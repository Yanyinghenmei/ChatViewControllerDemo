//
//  ViewController.m
//  ChatViewControllerDemo
//
//  Created by WeiLuezh on 2017/5/27.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "Chat/ViewController/ChatViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [_pushBtn addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushBtnClick:(UIButton *)btn {
    ChatViewController *chatVC = [ChatViewController new];
    chatVC.title = @"";
    [self.navigationController pushViewController:chatVC animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
