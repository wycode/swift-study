//
//  IDSSMComplexTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDSSMComplexTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *buildingL;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong)NSMutableArray *risks;

@property (nonatomic, strong)NSMutableArray *subUnits;
@property (nonatomic, assign)NSInteger buildId;
@property (nonatomic, assign)NSInteger cellId;
@property (nonatomic, assign)NSInteger unitId;
@property (nonatomic, assign)BOOL isAddOrUpdate;
@property (nonatomic, copy) NSString *buildingName;
@property (weak, nonatomic) IBOutlet UITextField *zhtmcT;
@property (weak, nonatomic) IBOutlet UITextField *addrT;
@property (nonatomic, copy)NSString *addr;
@property (nonatomic, copy) NSString *zhtmc;
@property (weak, nonatomic) IBOutlet UITextField *zgsmcT;
@property (weak, nonatomic) IBOutlet UITextView *czyhqkT;
@property (nonatomic, copy) NSString *czyhqk;
@property (nonatomic , copy) NSString *zgsmc;
@property (weak, nonatomic) IBOutlet UITextField *wyglmcT;
@property (nonatomic, copy) NSString *wyglmc;
@property (weak, nonatomic) IBOutlet UIView *xfspqkContentView;
@property (nonatomic, assign)NSInteger xfspqk;
@property (weak, nonatomic) IBOutlet UIView *sflsqjyContentView;
@property (nonatomic, assign)NSInteger sflsqjy;
@property (weak, nonatomic) IBOutlet UIView *sfjcwxxfContentView;
@property (nonatomic, assign)NSInteger sfjcwxxf;
@property (weak, nonatomic) IBOutlet UIView *xfkzsContentView;
@property (nonatomic, assign)NSInteger xfkzs;
@property (weak, nonatomic) IBOutlet UIView *hzzdbjContentView;
@property (nonatomic, assign)NSInteger hzzzbj;
@property (weak, nonatomic) IBOutlet UIView *snxhsContentView;
@property (nonatomic,assign) NSInteger snxhs;
@property (weak, nonatomic) IBOutlet UIView *zdpsContentView;
@property (nonatomic, assign)NSInteger zdpsmh;
@property (weak, nonatomic) IBOutlet UIView *mhqContentView;
@property (nonatomic, assign)NSInteger mhq;
@property (weak, nonatomic) IBOutlet UIView *qtxfssContentView;
@property (nonatomic, assign)NSInteger qtxfssqc;
@property (weak, nonatomic) IBOutlet UIView *sfczzdyhContentView;
@property (nonatomic, assign) NSInteger sfczzdyh;
@end
