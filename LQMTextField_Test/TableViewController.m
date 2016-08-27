//
//  TableViewController.h
//  LQMTextField_Test
//
//  Created by lqm on 16/8/27.
//  Copyright © 2016年 LQM. All rights reserved.
//
#import "TableViewController.h"
#import "TableViewCell.h"
#import "CustomTextField.h"

@interface TableViewController ()
@property(nonatomic, strong) NSArray *titles;

@property(nonatomic, strong) NSArray *placeHolders;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *age;

@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *four;
@property(nonatomic, copy) NSString *five;

@end

@implementation TableViewController
static NSString * const ID = @"textFieldCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

// 如果不能保证控制器的dealloc方法肯定会被调用，不要在viewDidLoad方法中注册通知。
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.rowHeight = 150;
    // 注册通知
    // 注意：此处监听的通知是：UITextFieldTextDidEndEditingNotification，textField结束编辑发送的通知，textField结束编辑时才会发送这个通知。
    // 想实时监听textField的内容的变化，你也可以注册这个通知：UITextFieldTextDidChangeNotification，textField值改变就会发送的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LQMTextFieldDidEndEditing:) name:@"CustomTextFieldDidEndEditingNotification" object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 在这个方法里移除通知，因为：
    // 防止控制器被强引用导致-dealloc方法没有调用
    // 其他界面也有textField，其他界面的textField也会发送同样的通知，导致频繁的调用监听到通知的方法，而这些通知是这个界面不需要的，所以在视图将要消失的时候移除通知 同样，在视图将要显示的时候注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CustomTextFieldDidEndEditingNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentTextField.indexPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *customCell = (TableViewCell *)cell;
    customCell.titleLabel.text = self.titles[indexPath.row];
    customCell.contentTextField.placeholder = self.placeHolders[indexPath.row];
    if (indexPath.row == 0) {
        customCell.contentTextField.text = self.name;
    } else if (indexPath.row == 1) {
        customCell.contentTextField.text = self.age;
    } else if (indexPath.row == 2){
        customCell.contentTextField.text = self.address;
    } else if (indexPath.row == 3){
        customCell.contentTextField.text = self.four;
    } else if (indexPath.row == 4){
        customCell.contentTextField.text = self.five;
    }
    
    
}

#pragma mark - private method
// 接收到注册监听的通知后调用
- (void)LQMTextFieldDidEndEditing:(NSNotification *)noti
{
    CustomTextField *textField = noti.object;
    
    if (!textField.indexPath) {
        return;
    }
    
    NSString *userInfoValue = [noti.userInfo objectForKey:@"textFieldText"];
    NSLog(@"text:%@,userInfoValue:%@",textField.text,userInfoValue);
    if (textField.indexPath.section == 0) {
        switch (textField.indexPath.row) {
            case 0: // 名称
                self.name = textField.text;
                break;
            case 1: // 年龄
                self.age = textField.text;
                break;
            case 2: // 地址
                self.address = textField.text;
                break;
            case 3: // 地址
                self.four = textField.text;
                break;
            case 4: // 地址
                self.five = textField.text;
                break;
            default:
                break;
        }
    } else if (textField.indexPath.section == 1) {
        // 同上，请自行脑补
    } else if (textField.indexPath.section == 2) {
        // 同上，请自行脑补
    } else {
        // 同上，请自行脑补
    }
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"姓名",@"年龄",@"地址",@"four",@"five"];
    }
    return _titles;
}

- (NSArray *)placeHolders
{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入姓名",@"请输入年龄",@"请输入地址",@"four",@"five"];
    }
    return _placeHolders;
}

@end
