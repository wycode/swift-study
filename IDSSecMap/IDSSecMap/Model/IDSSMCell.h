//
//  IDSSMCell.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDSSMCellInfo.h"
@interface IDSSMCell : NSObject
@property (nonatomic, strong)NSNumber *cellId;
@property (nonatomic, strong)NSNumber *lng;
@property (nonatomic, strong)NSNumber *lat;
//基本信息
@property (nonatomic, copy)NSString *name; //建筑名称(以栋为单位)
@property (nonatomic, copy)NSString *addr;//建筑地址(具体到路,号)
@property (nonatomic, assign)int type; //建筑类型
@property (nonatomic, assign)NSInteger districtId; //所属辖区
@property (nonatomic, assign)float jzgd;//建筑高度
@property (nonatomic, assign)int rzdws;//入住单位数
@property (nonatomic, assign)int jzcsds;//建筑层数－地上
@property (nonatomic, assign)int jzcsdx;//建筑层数－地下
@property (nonatomic, assign)float jzmjds;//建筑面积－地上
@property (nonatomic, assign)float jzmjdx;//建筑面积－地下
@property (nonatomic, assign)int gclx;//高层类型
@property (nonatomic, assign)int cqqk;//产权情况
@property (nonatomic, copy)NSString *cqdw; //产权单位（纯住宅、多产权不填）
@property (nonatomic, copy)NSString *cqdwlxr; //产权单位（纯住宅、多产权不填）-联系人
@property (nonatomic, copy)NSString *cqdwlxdh; //产权单位（纯住宅、多产权不填）-联系电话
@property (nonatomic, copy)NSString *wydw; //物业单位
@property (nonatomic, copy)NSString *wydwlxr; //物业单位-联系人
@property (nonatomic, copy)NSString *wydwlxdh; //物业单位-联系电话
@property (nonatomic, assign)long jgsj;//竣工时间

//消防基本情况
@property (nonatomic, assign)int  xfspsx; //消防审批手续
@property (nonatomic, assign)int xfkzs; //消防控制室
@property (nonatomic, assign)int  hzzdbjxt; //火灾自动报警系统
@property (nonatomic, assign)int  snxhsxt; //室内消火栓系统
@property (nonatomic, assign)int  zdpsmhxt; //自动喷水灭火系统
@property (nonatomic, assign)int  mhq; //灭火器
@property (nonatomic, assign)int qtxfssqc; //其他消防设施器材
@property (nonatomic, assign)NSInteger sfczzdhzyh;
@property (nonatomic, strong)NSMutableArray *risks;
@property (nonatomic, strong)NSMutableArray *units;
@property (nonatomic, strong)IDSSMCellInfo *cellInfo;
@property (nonatomic, copy) NSString *imageString;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
