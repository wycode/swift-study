//
//  FirstTableViewCell.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.text = self.title;
    self.detailText.text = self.detail;
}
- (void)getAddress:(NSString *)address latitude:(double)latitude longitude:(double)longitude
{
    self.detailText.text = address;
    self.coor = CLLocationCoordinate2DMake(latitude, longitude);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
