//
//  NetworkManager.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/8.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDSSMCell.h"
#import "IDSSMUnit.h"
#import "IDSSMMapViewController.h"

@protocol getUnitTypes <NSObject>

- (void)setUnitTypes:(NSArray *)typesArray;

@end
@protocol setCellsArray <NSObject>

- (void)setCellsArray:(NSMutableArray *)array;
@optional
- (void)annotationEditing;
@end
@protocol loginDelegate <NSObject>

- (void)resultFromNetwork:(NSDictionary *)dictionary;

@end
@protocol reloadView <NSObject>

- (void)reloadView:(NSDictionary *)dictionary;

@end
@interface NetworkManager : NSObject

@property (nonatomic, strong)NSMutableArray *cellsArray;
@property (nonatomic, strong)NSMutableArray *buildingArray;
@property (nonatomic, assign)float latitude;
@property (nonatomic, assign)float longitude;
@property (nonatomic, assign)id<setCellsArray>delegate;
@property (nonatomic, assign)id<loginDelegate>loginDelegate;
@property (nonatomic, assign)id<getUnitTypes>typesDelegate;
@property (nonatomic, assign)id<reloadView>reloadDelegate;

- (void)getCellsInMap:(CLLocationCoordinate2D)coordinate userSn:(NSString *)userSn;
- (void)loginWithName:(NSString *)name password:(NSString *)password;
- (void)getAllGeoTypes:(NSString *)userSn;
- (void)updateUnit:(NSString *)unit userSn:(NSString *)userSn;
- (void)addUnit:(NSString *)unit userSn:(NSString *)userSn;
- (void)updateRisk:(NSString *)userSn risk:(NSString *)risk;
- (void) addRisk:(NSString *)userSn risk:(NSString *)risk;
- (void)addBuilding:(NSString *)building userSn:(NSString *)userSn;
- (void)updateBuilding:(NSString *)building userSn:(NSString *)userSn;
- (void)addSubUnit:(NSString *)subUnit userSn:(NSString *)userSn;
- (void)updateSubUnit:(NSString *)subUnit userSn:(NSString *)userSn;
- (void)getBuildingList;
@end


