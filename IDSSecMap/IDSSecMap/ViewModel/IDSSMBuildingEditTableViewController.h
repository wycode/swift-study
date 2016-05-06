//
//  IDSSMBuildingEditTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/20.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDSSMBuildingEditTableViewController : UITableViewController
@property (nonatomic, assign)double lat;
@property (nonatomic, assign)double lng;
@property (nonatomic, assign)BOOL isAddOrUpdate;
@property (nonatomic, assign)NSInteger cellId;
@property (nonatomic, strong)NSMutableArray *risks;
@property (weak, nonatomic) IBOutlet UILabel *ssxqL;

@property (weak, nonatomic) IBOutlet UITextField *buildingName;
@property (copy, nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *buildingAddress;
@property (copy, nonatomic) NSString *addr;
@property (weak, nonatomic) IBOutlet UIView *distanceContentView;
@property (weak, nonatomic) IBOutlet UIView *ssxqContentView;
@property (nonatomic, assign)NSInteger ssxq;
@property (weak, nonatomic) IBOutlet UITextField *buildingHeight;
@property (nonatomic, assign)float jzgd;
@property (weak, nonatomic) IBOutlet UITextField *numberOfUnits;
@property (nonatomic, assign)NSInteger rzdws;
@property (weak, nonatomic) IBOutlet UITextField *jzcsdsF;
@property (nonatomic, assign)NSInteger jzcsds;
@property (weak, nonatomic) IBOutlet UITextField *jzcsdx;
@property (nonatomic, assign)NSInteger jzcsdxA;
@property (weak, nonatomic) IBOutlet UITextField *jzmjds;
@property (nonatomic, assign)float jzmjdsA;
@property (weak, nonatomic) IBOutlet UITextField *jzmjdx;
@property (nonatomic, assign)float jzmjdxA;
@property (weak, nonatomic) IBOutlet UIView *buildingTypeContentView;
@property (nonatomic, assign)NSInteger type;
@property (weak, nonatomic) IBOutlet UIView *gclxContentView;
@property (nonatomic, assign)NSInteger gclx;
@property (weak, nonatomic) IBOutlet UIView *cqqkContentView;
@property (nonatomic, assign)NSInteger cqqk;
@property (weak, nonatomic) IBOutlet UITextField *cqdwF;
@property (nonatomic, copy) NSString *cqdw;
@property (weak, nonatomic) IBOutlet UITextField *cqdwlxrF;
@property (nonatomic, copy) NSString *cqdwlxr;
@property (weak, nonatomic) IBOutlet UITextField *cqdwlxdh;
@property (nonatomic, copy) NSString *cqdwlxdhA;
@property (weak, nonatomic) IBOutlet UITextField *wydwF;
@property (nonatomic, copy) NSString *wydw;
@property (weak, nonatomic) IBOutlet UITextField *wydwlxrF;
@property (nonatomic, copy) NSString *wydwlxr;
@property (weak, nonatomic) IBOutlet UITextField *wydwlxdhF;
@property (nonatomic, copy) NSString *wydwlxdh;
@property (weak, nonatomic) IBOutlet UILabel *jgsjF;
@property (nonatomic, assign)long jgsj;
@property (weak, nonatomic) IBOutlet UIView *xfspsxContenView;
@property (nonatomic, assign) NSInteger xfspsx;
@property (weak, nonatomic) IBOutlet UIView *xfkzsContentView;
@property (nonatomic, assign) NSInteger xfkzs;
@property (weak, nonatomic) IBOutlet UIView *hzzdbjxtContentView;
@property (nonatomic, assign)NSInteger hzzdbjxt;
@property (weak, nonatomic) IBOutlet UIView *snxhsxtContentView;
@property (nonatomic, assign) NSInteger snxhsxt;
@property (weak, nonatomic) IBOutlet UIView *zdpsmhxtContentView;
@property (nonatomic , assign) NSInteger zdpsmhxt;

@property (weak, nonatomic) IBOutlet UIView *mhqContenView;
@property (nonatomic, assign)NSInteger mhq;

@property (weak, nonatomic) IBOutlet UIView *qtxfqcContentView;
@property (nonatomic, assign)NSInteger qtxfssqc;
@property (weak, nonatomic) IBOutlet UITextView *yhqkF;
@property (nonatomic, copy)NSString *yhqk;
@property (weak, nonatomic) IBOutlet UIView *sfczzdhzyhContentView;
@property (nonatomic, assign)NSInteger sfczzdhzyh;



@end
