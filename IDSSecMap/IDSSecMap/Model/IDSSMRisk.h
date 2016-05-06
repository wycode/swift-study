//
//  IDSSMRisk.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  隐患级别
 */
typedef NS_ENUM(NSInteger, IDSSMRiskPriority) {
    /*!
     *  无隐患
     */
    IDSSMRiskNone = 1,
    /*!
     *  一般隐患
     */
    IDSSMRiskLight = 2,
    /*!
     *  重大隐患
     */
    IDSSMRiskSevere = 3
};

@interface IDSSMRisk : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger cellId;
@property (nonatomic, assign) NSInteger subUnitId;
@property (nonatomic, assign) NSInteger unitId;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) IDSSMRiskPriority priority;
@property (nonatomic, assign) long recordTime;

/*!
 *  未排除，已排除
 */
@property (nonatomic, assign) NSInteger state;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
