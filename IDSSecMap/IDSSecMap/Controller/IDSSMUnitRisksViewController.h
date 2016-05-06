//
//  IDSSMUnitRisksViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDSSMRisk.h"
@interface IDSSMUnitRisksViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *risks;
@property (nonatomic, assign)NSInteger unitId;
@property (nonatomic, assign)NSInteger cellId;
@property (nonatomic, assign)BOOL cellOrUnit;
@end
