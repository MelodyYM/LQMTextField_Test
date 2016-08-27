//
//  TableViewCell.m
//  LQMTextField_Test
//
//  Created by lqm on 16/8/27.
//  Copyright © 2016年 LQM. All rights reserved.
//


#import "TableViewCell.h"
#import "CustomTextField.h"

@interface TableViewCell ()<UITextFieldDelegate>


@end


@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentTextField.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.contentTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDictionary *userInfo = @{
                               @"textFieldText":self.contentTextField.text
                               };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomTextFieldDidEndEditingNotification" object:self.contentTextField userInfo:userInfo];
}

@end

