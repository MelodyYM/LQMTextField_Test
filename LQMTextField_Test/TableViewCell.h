//
//  TableViewCell.h
//  LQMTextField_Test
//
//  Created by lqm on 16/8/27.
//  Copyright © 2016年 LQM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTextField;

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CustomTextField *contentTextField;

@end
