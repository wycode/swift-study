//
//  FirstTableViewCell.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDSSMLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface FirstTableViewCell : UITableViewCell<returnAddress>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailText;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *detail;
@property (nonatomic, assign)CLLocationCoordinate2D coor;
@end
