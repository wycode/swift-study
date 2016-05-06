//
//  IDSSMListViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/7.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "RootEditViewController.h"
#import "IDSSMMapViewController.h"
#import "IDSSMUnitTableViewCell.h"
@interface IDSSMListViewController : UIViewController<backToMap>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign)NSInteger backIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
