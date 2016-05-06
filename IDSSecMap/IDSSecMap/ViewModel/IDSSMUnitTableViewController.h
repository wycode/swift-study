//
//  IDSSMUnitTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDSSMUnitTableViewController : UITableViewController
@property (nonatomic, copy) NSString *buildingName;
@property (nonatomic, assign)NSInteger buildId;
@property (nonatomic, strong)NSMutableArray *risks;

@property (nonatomic, assign)NSInteger type;
@property (nonatomic , assign)BOOL isAddOrUpdate;
@property (nonatomic, assign)NSInteger unitId;
@property (weak, nonatomic) IBOutlet UILabel *buildL;
@property (weak, nonatomic) IBOutlet UITextField *dwmcT;
@property (nonatomic, copy) NSString *dwmc;
@property (weak, nonatomic) IBOutlet UITextField *dwdzT;
@property (nonatomic, copy) NSString *dwdz;
@property (weak, nonatomic) IBOutlet UIView *distanceContentView;
@property (nonatomic, assign)NSInteger jlcg;
@property (weak, nonatomic) IBOutlet UITextField *fzrT;
@property (nonatomic, copy) NSString *fzr;
@property (weak, nonatomic) IBOutlet UITextField *ygsT;
@property (nonatomic, assign) NSInteger ygs;
@property (weak, nonatomic) IBOutlet UITextField *lxdhT;
@property (nonatomic, copy) NSString *lxdh;
@property (weak, nonatomic) IBOutlet UIView *dwlxContentView;
@property (nonatomic, assign)NSInteger dwlx;
@property (weak, nonatomic) IBOutlet UIView *sfsyzddwContentView;
@property (nonatomic, assign)NSInteger sfsyzddw;
@property (weak, nonatomic) IBOutlet UITextField *jzmjT;
@property (nonatomic, assign) float jzmj;
@property (weak, nonatomic) IBOutlet UIView *sflsqjyContentView;
@property (nonatomic, assign)NSInteger sflsqjy;
@property (weak, nonatomic) IBOutlet UIView *sfjcwxxfzContentView;
@property (nonatomic, assign)NSInteger sfjcwxxfz;

@property (weak, nonatomic) IBOutlet UIView *cfyhqkContentView;
@property (nonatomic, assign)NSInteger cfyhqk;

@property (weak, nonatomic) IBOutlet UIView *xfspsxContentView;
@property (nonatomic, assign)NSInteger xfspsx;

@property (weak, nonatomic) IBOutlet UIView *hyzlContentView;
@property (nonatomic, assign)NSInteger hyzl;

@property (weak, nonatomic) IBOutlet UIView *xfkzsContenView;
@property (nonatomic, assign)NSInteger xfkzs;

@property (weak, nonatomic) IBOutlet UIView *hzzdbjContentView;
@property (nonatomic, assign)NSInteger hzzdbj;

@property (weak, nonatomic) IBOutlet UIView *snxhsContentView;
@property (nonatomic, assign)NSInteger snxhs;

@property (weak, nonatomic) IBOutlet UIView *zdpsmhContentView;
@property (nonatomic, assign)NSInteger zdpsmh;

@property (weak, nonatomic) IBOutlet UIView *mhqContentView;
@property (nonatomic, assign)NSInteger mhq;

@property (weak, nonatomic) IBOutlet UIView *qtxsssContentView;
@property (nonatomic, assign)NSInteger qtxsss;
@property (weak, nonatomic) IBOutlet UITextView *yhqkT;

@property (weak, nonatomic) IBOutlet UIView *sfzzzdyhContentView;
@property (nonatomic, assign)NSInteger sfzzzdyh;

@end
