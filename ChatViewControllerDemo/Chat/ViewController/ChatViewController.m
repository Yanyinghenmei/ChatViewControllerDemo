//
//  ChatViewController.m
//  XiPinHui
//
//  Created by WeiLuezh on 2017/5/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatInputView.h"

#import "ChatLeftTableViewCell.h"
#import "ChatRightTableViewCell.h"

#import "ChatLeftImgTableViewCell.h"
#import "ChatRightImgTableViewCell.h"

#import "PhotoCenter.h"
#import "MessageModel.h"

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)ChatInputView *myInputView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)PhotoCenter *photoCenter;
@property (nonatomic, copy)NSMutableArray <MessageModel *>*dataArr;
@property (nonatomic, assign)NSInteger page;

@property (nonatomic, copy)NSString *self_id;
@property (nonatomic, copy)NSString *friend_id;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Left";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _friend_id = @"001";
    _self_id = @"002";
    
    _photoCenter = [PhotoCenter new];
    _dataArr = @[].mutableCopy;
    [self setData];
}

- (void)setData {
    MessageModel *model = [MessageModel modelWithUserId:_friend_id name:@"Left" userIcon:[UIImage imageNamed:@"icon1"] sendedText:@"Hello"];
    [_dataArr addObject:model];
    [self.tableView reloadData];
    [self myInputView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain];
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor = [UIColor colorWithRed:241/255.00 green:241/255.00 blue:241/255.00 alpha:1];
        [_tableView registerNib:[UINib nibWithNibName:@"ChatLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatLeftTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ChatRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatRightTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ChatLeftImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatLeftImgTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ChatRightImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatRightImgTableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 60;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark -- tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageModel *model = _dataArr[indexPath.row];
    if ([model.user_id isEqualToString:_self_id]) {
        if (model.messageType == MessageTypeText) {
            ChatRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRightTableViewCell"];
            cell.icon.image = model.icon;
            cell.contentLab.text = model.text;
            return cell;
        } else {
            ChatRightImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRightImgTableViewCell"];
            cell.icon.image = model.icon;
            [cell setImgViewImage:model.image];
            return cell;
        }
    } else {
        if (model.messageType == MessageTypeText) {
            ChatLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatLeftTableViewCell"];
            cell.icon.image = model.icon;
            cell.contentLab.text = model.text;
            return cell;
        } else {
            ChatLeftImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatLeftImgTableViewCell"];
            cell.icon.image = model.icon;
            [cell setImgViewImage:model.image];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



#pragma mark -- 输入键盘
- (UIView *)myInputView {
    if (!_myInputView) {
        _myInputView = [ChatInputView sharekeyboard];
        [_myInputView.imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        // 发送评论
        _myInputView.sendBlock = ^(NSString *text) {
            MessageModel *model = [MessageModel modelWithUserId:weakSelf.self_id name:@"Right" userIcon:[UIImage imageNamed:@"icon2"] sendedText:text];
            MessageModel *model1 = [MessageModel modelWithUserId:weakSelf.friend_id name:@"Left" userIcon:[UIImage imageNamed:@"icon1"] sendedText:text];
            
            [weakSelf.dataArr addObject:model];
            [weakSelf.dataArr addObject:model1];
            
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:weakSelf.dataArr.count-1 inSection:0];
            NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:weakSelf.dataArr.count-2 inSection:0];
            [weakSelf.tableView insertRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationBottom];
            weakSelf.myInputView.textField.text = @"";
            [weakSelf.tableView scrollToRowAtIndexPath:indexPath1 atScrollPosition:UITableViewScrollPositionBottom animated:true];
        };
        [self.view addSubview:_myInputView];
        [self.view bringSubviewToFront:_myInputView];
    }
    return _myInputView;
}

#pragma mark -- click
- (void)imgBtnClick:(UIButton *)btn {
    __weak typeof(self) weakSelf = self;
    
    [_photoCenter libraryPhotoWithController:self FormDataBlock:^(UIImage *image, IWFormData *formData) {
        MessageModel *model = [MessageModel modelWithUserId:weakSelf.self_id name:@"Right" userIcon:[UIImage imageNamed:@"icon2"] sendedImage:image];
        MessageModel *model1 = [MessageModel modelWithUserId:weakSelf.friend_id name:@"Left" userIcon:[UIImage imageNamed:@"icon1"] sendedImage:image];
        
        [weakSelf.dataArr addObject:model];
        [weakSelf.dataArr addObject:model1];
        
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:weakSelf.dataArr.count-1 inSection:0];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:weakSelf.dataArr.count-2 inSection:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath1 atScrollPosition:UITableViewScrollPositionBottom animated:true];
    }];
}

@end
