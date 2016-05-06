//
//  IDSSMUnitTableViewCell.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol backToMap <NSObject>

- (void)backToMap:(UIView *)view;
- (void)changeUnit;
- (void)checkRisks;
@end
@interface IDSSMUnitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *proirityImageView;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goImageView;
@property (weak, nonatomic) IBOutlet UILabel *dwdzLabel;
@property (nonatomic ,assign)id<backToMap>backDelegate;
@property (nonatomic, assign)BOOL headerShow;
@property (nonatomic, assign)NSInteger headerSection;
@end
