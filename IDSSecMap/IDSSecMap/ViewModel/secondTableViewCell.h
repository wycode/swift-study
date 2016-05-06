//
//  secondTableViewCell.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sfButton;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign)NSInteger seg;
@end
