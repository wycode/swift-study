//
//  IDSSMSubUnit.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/20.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDSSMSubUnit : NSObject

@property (nonatomic, assign)int ID;
@property (nonatomic, assign)int unitId;

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *addr; //地址（楼层）
@property (nonatomic, assign)int type; //类型

//基本信息
@property (nonatomic, copy)NSString *fzr; //负责人
@property (nonatomic, copy)NSString *lxdh; //联系电话

//消防基本情况
@property (nonatomic, assign) int spqk; //审批情况
@property (nonatomic, assign)int yhqkcf; //用火情况-厨房
@property (nonatomic, assign)NSInteger yhqkhyzl; //用火情况-火源种类
@property (nonatomic, assign)int ygsfzwsgnl; //员工是否掌握“四个能力”
@property (nonatomic, copy)NSString *czyhqk;

@property (nonatomic, strong)NSMutableArray *risks;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;



@end
