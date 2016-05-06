//
//  BuildingNameTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/22.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol nameOfBuilding <NSObject>

- (void)setLabelBuilding:(NSString *)name;

@end
@interface BuildingNameTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray *listBuildingNameArr;
@property (nonatomic, assign)NSInteger rowOfList;
@property (nonatomic, assign)id<nameOfBuilding>delegate;
@end
