//
//  LQM_ViewController.m
//  LQMTextField_Test
//
//  Created by lqm on 16/8/27.
//  Copyright © 2016年 LQM. All rights reserved.
//

#import "LQM_ViewController.h"
#import "CustomTextField.h"
#import "TableViewCell.h"

@interface LQM_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *lqmTabelView;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSArray *placeHolders;

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *age;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *four;
@property(nonatomic, copy) NSString *five;

@property(nonatomic, copy) NSString *name_1;
@property(nonatomic, copy) NSString *age_1;
@property(nonatomic, copy) NSString *address_1;
@property(nonatomic, copy) NSString *four_1;
@property(nonatomic, copy) NSString *five_1;

@end

@implementation LQM_ViewController
static NSString * const ID = @"textFieldCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>7.0?YES:NO)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.lqmTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
     self.lqmTabelView.delegate = self;
     self.lqmTabelView.dataSource = self;
    [self.view addSubview: self.lqmTabelView];
    
//    [self.lqmTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    [self.lqmTabelView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    
    self.lqmTabelView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
}


// 如果不能保证控制器的dealloc方法肯定会被调用，不要在viewDidLoad方法中注册通知。
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.lqmTabelView.rowHeight = 150;
    // 注册通知
    // 注意：此处监听的通知是：UITextFieldTextDidEndEditingNotification，textField结束编辑发送的通知，textField结束编辑时才会发送这个通知。
    // 想实时监听textField的内容的变化，你也可以注册这个通知：UITextFieldTextDidChangeNotification，textField值改变就会发送的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LQMTextFieldDidEndEditing:) name:@"CustomTextFieldDidEndEditingNotification" object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
#pragma mark -----------
    
    //注册通知 监听键盘的高度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kyeboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 在这个方法里移除通知，因为：
    // 防止控制器被强引用导致-dealloc方法没有调用
    // 其他界面也有textField，其他界面的textField也会发送同样的通知，导致频繁的调用监听到通知的方法，而这些通知是这个界面不需要的，所以在视图将要消失的时候移除通知 同样，在视图将要显示的时候注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CustomTextFieldDidEndEditingNotification" object:nil];
#pragma mark -----------
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentTextField.indexPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *customCell = (TableViewCell *)cell;
    //
    customCell.titleLabel.text = self.titles[indexPath.row];
    customCell.contentTextField.placeholder = self.placeHolders
    [indexPath.row];
    //
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
    
   else if (indexPath.row == 5) {
        customCell.contentTextField.text = self.name_1;
    } else if (indexPath.row == 6) {
        customCell.contentTextField.text = self.age_1;
    } else if (indexPath.row == 7){
        customCell.contentTextField.text = self.address_1;
    } else if (indexPath.row == 8){
        customCell.contentTextField.text = self.four_1;
    } else if (indexPath.row == 9){
        customCell.contentTextField.text = self.five_1;
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
    if (textField.indexPath.section == 0)
    {
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
            case 5: // 名称
                self.name_1 = textField.text;
                break;
            case 6: // 年龄
                self.age_1 = textField.text;
                break;
            case 7: // 地址
                self.address_1 = textField.text;
                break;
            case 8: // 地址
                self.four_1 = textField.text;
                break;
            case 9: // 地址
                self.five_1 = textField.text;
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
        _titles = @[@"姓名",@"年龄",@"地址",@"four",@"five",@"姓名1",@"年龄1",@"地址1",@"four1",@"five1"];
    }
    return _titles;
}

- (NSArray *)placeHolders
{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入姓名",@"请输入年龄",@"请输入地址",@"four",@"five",@"请输入姓名1",@"请输入年龄1",@"请输入地址1",@"four1",@"five1"];
    }
    return _placeHolders;
}


#pragma mark -//通知的实现---

- (void)keyboardWillShow:(NSNotification *)notification
{
    //键盘弹出后的frame
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardBounds;
    [keyboardBoundsValue getValue:&keyboardBounds];
    
    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, keyboardBounds.size.height, 0);
    [_lqmTabelView setContentInset:e];
    
    //调整滑动条距离窗口底边的距离
    [_lqmTabelView setScrollIndicatorInsets:e];
    
}

- (void)kyeboardWillHide:(NSNotification *)notification
{
    
    //键盘缩回后，恢复正常设置
    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, 0, 0);
    [_lqmTabelView setScrollIndicatorInsets:e];
    [_lqmTabelView setContentInset:e];
}


@end



























