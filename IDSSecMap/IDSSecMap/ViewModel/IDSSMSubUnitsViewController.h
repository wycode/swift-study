//
//  IDSSMSubUnitsViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/23.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol getSubUnits <NSObject>

- (void)setSubUnits:(NSMutableArray *)subunits;

@end
@interface IDSSMSubUnitsViewController : UIViewController
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic, assign)BOOL unitIsAddOrUpdate;
@property (nonatomic, strong)NSMutableArray *subUnits;
@property (nonatomic, assign)BOOL isAddOrUpdate;
@property (nonatomic, assign)NSInteger unitId;
@property (nonatomic, assign)id<getSubUnits>delegate;
@end

