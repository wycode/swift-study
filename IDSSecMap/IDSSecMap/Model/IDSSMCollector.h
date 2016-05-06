//
//  IDSSMCollector.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDSSMCollector : NSObject

@property (nonatomic, assign)int ID;

@property (nonatomic, copy)NSString *userSn;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *password;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *idCard;
@property (nonatomic, copy)NSString *descriptions;
@end
