//
//  IDSSMTabBarViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/7.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@protocol showSomething <NSObject>

- (void)setMap:(NSMutableArray *)cellArray coordinate:(CLLocationCoordinate2D )coordinate;

@end
@interface IDSSMTabBarViewController : UITabBarController
@property(nonatomic, strong) NSMutableArray *cellsArray;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign)BOOL addCellOrUpdate;
@property (nonatomic, copy)NSString *userSn;
@property (nonatomic, assign)float latitude;
@property (nonatomic, assign)float longitude;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, assign)id<showSomething>showDelegate;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *imageView;
- (void)gotoEditing;

@end
