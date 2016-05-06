//
//  IDSSMUnit.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDSSMRisk;

/*!
 *  Unit类型
 */
typedef NS_ENUM(NSInteger, IDSSMUnitGroup) {
    /*!
     *  人员密集场所
     */
    RYMJCS,
    /*!
     *  危险化学品场所
     */
    WXHXPCS,
    /*!
     *  高层地下建筑
     */
    GCDXJZ,
    /*!
     *  重要机关和单位
     */
    ZYJGHDW,
    /*!
     *  大型仓储
     */
    DXCC,
    /*!
     *  大型城市综合体
     */
    DXCSZHT,
    /*!
     *  一般场所
     */
    YBCS
};

@interface IDSSMUnit : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *fzr;
@property (nonatomic, strong)NSMutableArray *subUnits;
/*!
 *  所属建筑
 */
@property (nonatomic, assign) NSInteger cellId;

/*!
 *  所属消防监管单位
 */
@property (nonatomic, assign) NSInteger supervisorUnit;

/*!
 *  引用ID
 */
@property (nonatomic, copy) NSString *refId;

/*!
 *  内部广场ID
 */
@property (nonatomic, assign) NSInteger mallId;

/*!
 *  单位类型
 */
@property (nonatomic, assign) NSInteger dwlx;

/*!
 *  单位名称
 */
@property (nonatomic, copy) NSString *dwmc;

/*!
 *  单位地址
 */
@property (nonatomic, copy) NSString *dwdz;

@property (nonatomic, assign)float jzmj;//建筑面积

@property (nonatomic, assign)int ygzss;//员工（住宿）数


//一般场所 独占属性

@property (nonatomic, assign) int zzxqhs;//住宅小区户数

//综合体建筑 独占属性

@property (nonatomic ,copy) NSString *zgsmc; //总公司名称
@property (nonatomic, copy) NSString *wyglgsmc; //物业管理公司名称

//消防基本情况
//单位或场所、综合体建筑 共享属性
@property (nonatomic, assign) int sflsqjycs; //是否落实“7+1”措施
@property (nonatomic, assign) int xfspsx; //消防审批手续
@property (nonatomic, assign) int sfjcwxxfz; //是否建成微型消防站
@property (nonatomic, assign) int xfkzs; //消防控制室
@property (nonatomic, assign) int hzzdbjxt; //火灾自动报警系统
@property (nonatomic, assign) int snxhsxt; //室内消火栓系统
@property (nonatomic, assign) int zdpsmhxt; //自动喷水灭火系统
@property (nonatomic, assign) int mhq; //灭火器
@property (nonatomic, assign) int qtxfssqc; //其他消防设施器材

//单位或场所、一般场所 共享属性
@property (nonatomic, assign) int yhqkcf; //用火情况-厨房
@property (nonatomic, assign) int yhqkhyzl; //用火情况-火源种类

//单位或场所 独占属性
@property (nonatomic, assign) int sfsyzddw; //是否属于重点单位

//一般场所 独占属性
@property (nonatomic, assign) int sfczshy; //是否存在三合一
@property (nonatomic, assign) int sfwgzr; //是否违规住人
@property (nonatomic, assign) int sffhssyq; //是否符合疏散要求
@property (nonatomic, assign) int sfwgcfyhq; //是否违规存放液化气
@property (nonatomic, assign) int sfpbxfqc; //是否配备消防器材
@property (nonatomic, assign) int sfjgxcpxjy; //是否经过宣传培训教育
@property (nonatomic, copy) NSString *bcqk; //补充情况

//@property (nonatomic, strong) NSMutableArray *subUnits;
/*!
 *  单位负责人
 */
@property (nonatomic, copy) NSString *dwfzr;

/*!
 *  联系人
 */
@property (nonatomic, copy) NSString *lxr;

/*!
 *  联系电话
 */
@property (nonatomic, copy) NSString *lxdh;

/*!
 *  是否输入重点单位
 */

/*!
 *  是否判定为重大危险源
 */
@property (nonatomic, assign) NSInteger sfpdwzdwxy;

/*!
 *  是否设消防控制室
 */
@property (nonatomic, assign) NSInteger sfsxfkzs;

/*!
 *  是否取得消防相关手续
 */
@property (nonatomic, assign) NSInteger sfqdxfxgsx;

/*!
 *  是否落实"六加一"
 */
@property (nonatomic, assign) NSInteger sflsljy;

/*!
 *  9月3日至6日是否停用
 */
@property (nonatomic, assign) NSInteger sfty;

/*!
 *  场所情况
 */
@property (nonatomic, copy) NSString *csqk;


/*!
 *  室外地图上的Cell/Unit显示,
 *  如果一个Cell包含多个Unit, 则依据最严重的隐患进行显示
 *  气球 - 重点单位, 颜色高亮在外延
 *  灰色 - risks==null, 待检查隐患
 *  蓝色 - risks都已解决, 无隐患
 *  红色 - risks包含一条重大隐患
 *  黄色 - risks包含一条一版隐患, 并且无重大隐患
 */
@property (nonatomic, copy)NSString *imageString;
@property (nonatomic, strong) NSMutableArray<IDSSMRisk *> *risks;

// 当dwlx = DXCSZHT(6, 大型城市综合体)时会有下面属性
/*!
 *  总公司名称
 */

@property (nonatomic, copy) NSString *nbgspmc;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
