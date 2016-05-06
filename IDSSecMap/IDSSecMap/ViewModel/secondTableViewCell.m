//
//  secondTableViewCell.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "secondTableViewCell.h"

@implementation secondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.text = self.title;
    self.sfButton.selected = self.seg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
