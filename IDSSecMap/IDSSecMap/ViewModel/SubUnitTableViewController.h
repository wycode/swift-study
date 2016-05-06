//
//  SubUnitTableViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/24.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDSSMSubUnit.h"
@protocol returnSubUnit <NSObject>

- (void)getNewSubUnit:(IDSSMSubUnit *)subUnit num:(NSInteger)num row:(NSInteger)row;
- (void)replaceSubUnit:(IDSSMSubUnit *)subUnit row:(NSInteger)row;
@end
@interface SubUnitTableViewController : UITableViewController
@property (nonatomic, assign)BOOL isAddOrUpdate;
@property (nonatomic, assign)BOOL unitIsAddOrUpdate;
@property (nonatomic, strong)IDSSMSubUnit *subUnit;
@property (nonatomic, assign)NSInteger updateRow;
@property (nonatomic, assign)NSInteger unitId;
@property (weak, nonatomic) IBOutlet UITextField *zycsmcT;
@property (weak, nonatomic) IBOutlet UITextField *dwdzT;
@property (weak, nonatomic) IBOutlet UITextField *fzrT;
@property (weak, nonatomic) IBOutlet UITextField *lxdhT;
@property (weak, nonatomic) IBOutlet UIView *cslxContentView;
@property (nonatomic, assign)NSInteger cslx;
@property (weak, nonatomic) IBOutlet UIView *xfspsxContentView;
@property (nonatomic, assign)NSInteger xfspsx;
@property (weak, nonatomic) IBOutlet UIView *cfyhqkContentView;
@property (nonatomic, assign)NSInteger cfyhqk;
@property (weak, nonatomic) IBOutlet UIView *hyzlContentView;
@property (nonatomic, assign)NSInteger hyzl;
@property (weak, nonatomic) IBOutlet UIView *ygsfzwsgyContentView;
@property (nonatomic, assign)NSInteger ygsfzwsgy;
@property (weak, nonatomic) IBOutlet UITextField *czyhqkT;

@property (nonatomic ,assign)id<returnSubUnit>delegate;
@end


