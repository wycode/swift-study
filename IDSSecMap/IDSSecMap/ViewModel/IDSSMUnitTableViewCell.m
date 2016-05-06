//
//  IDSSMUnitTableViewCell.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMUnitTableViewCell.h"
#import "IDSSMMapViewController.h"
@implementation IDSSMUnitTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)checkRiskButton:(UIButton *)sender {
    
    [self.backDelegate checkRisks];
}

- (IBAction)changeUnit:(UIButton *)sender {
    [self.backDelegate changeUnit];
}
- (IBAction)backMap:(UIButton *)sender {
    [self.backDelegate backToMap:self];
    
}
@end
