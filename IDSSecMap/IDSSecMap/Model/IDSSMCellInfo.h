//
//  IDSSMCellInfo.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/20.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDSSMCellInfo : NSObject

@property (nonatomic, assign)int allUnitCount;
@property (nonatomic, assign)int keyUnitCount;
@property (nonatomic, assign)int xfllCount;
@property (nonatomic, assign)int xfsCount;

@property (nonatomic, assign)int allRiskCount;
@property (nonatomic, assign)int criticalRiskCount;
@property (nonatomic, assign)int normalRiskCount;
@property (nonatomic, copy)NSString *icon;

@end
