//
//  IDSSMNormalUnitTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDSSMNormalUnitTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray *buildingArray;
@property (nonatomic, assign) NSInteger buildId;
@property (nonatomic, assign) NSInteger unitId;
@property (nonatomic, assign) BOOL isAddOrUpdate;
@property (weak, nonatomic) IBOutlet UILabel *buildingL;
@property (nonatomic, copy) NSString *buildingName;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (copy, nonatomic) NSString *address;
@property (weak, nonatomic) IBOutlet UITextField *csmcTextfield;
@property (nonatomic, copy) NSString *csmc;
@property (weak, nonatomic) IBOutlet UITextField *zzxqhsTextfield;
@property (nonatomic, assign) NSInteger zzxqhs;
@property (weak, nonatomic) IBOutlet UITextField *jzmjTextfield;
@property (nonatomic, assign)float jzmj;
@property (weak, nonatomic) IBOutlet UITextField *ygzssT;
@property (nonatomic, assign)NSInteger ygzss;
@property (weak, nonatomic) IBOutlet UITextField *fzrT;
@property (nonatomic, copy) NSString *fzr;
@property (weak, nonatomic) IBOutlet UITextField *lxdhT;
@property (nonatomic, copy) NSString *lxdh;
@property (weak, nonatomic) IBOutlet UIView *jlcgContentView;
@property (nonatomic ,assign)NSInteger jlcg;
@property (weak, nonatomic) IBOutlet UIView *cslxContentView;
@property (nonatomic ,assign)NSInteger cslx;

@property (weak, nonatomic) IBOutlet UIView *yhqkcfContentView;
@property (nonatomic ,assign)NSInteger yhqkcf;
@property (weak, nonatomic) IBOutlet UIView *hyzlContentView;
@property (nonatomic ,assign)NSInteger hyzl;

@property (weak, nonatomic) IBOutlet UIView *xfspsxContentView;
@property (nonatomic ,assign)NSInteger xfspsx;

@property (weak, nonatomic) IBOutlet UIView *sfczshyContentView;
@property (nonatomic ,assign)NSInteger sfczshy;
@property (weak, nonatomic) IBOutlet UIView *sfwgzrContentView;
@property (nonatomic ,assign)NSInteger sfwgzr;
@property (weak, nonatomic) IBOutlet UIView *sffhssyqContentView;
@property (nonatomic ,assign)NSInteger sffhssyq;
@property (weak, nonatomic) IBOutlet UIView *sfwgcfyhqContentView;
@property (nonatomic ,assign)NSInteger sfwgcfyhq;
@property (weak, nonatomic) IBOutlet UIView *sfpbxxqcContentView;
@property (nonatomic ,assign)NSInteger sfpbxxqc;
@property (weak, nonatomic) IBOutlet UIView *sfjgxcpxContentView;
@property (nonatomic ,assign)NSInteger sfjgxcpx;
@property (weak, nonatomic) IBOutlet UITextView *yhqkT;

@property (weak, nonatomic) IBOutlet UITextView *bcwtT;






@end
