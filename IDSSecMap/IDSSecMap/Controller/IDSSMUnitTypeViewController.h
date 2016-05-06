//
//  IDSSMUnitTypeViewController.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol unitTypeShow <NSObject>

- (void)setUnitType:(NSString *)string num:(NSInteger)num;

@end
@interface IDSSMUnitTypeViewController :UIViewController
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)id<unitTypeShow>delegate;

- (void)setUnitTypes:(NSArray *)typesArray;

@end
