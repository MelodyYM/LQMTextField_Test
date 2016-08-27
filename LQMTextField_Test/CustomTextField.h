//
//  CustomTextField.h
//  LQMTextField_Test
//
//  Created by lqm on 16/8/27.
//  Copyright © 2016年 LQM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField
/**
 *  indexPath属性用于区分不同的cell
 */
@property (strong, nonatomic) NSIndexPath *indexPath;
@end
