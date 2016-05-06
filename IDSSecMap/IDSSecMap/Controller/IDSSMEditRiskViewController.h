//
//  IDSSMEditRiskViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/16.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDSSMRisk.h"
@interface IDSSMEditRiskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *riskBrief;
@property (weak, nonatomic) IBOutlet UITextView *riskDetail;
@property (weak, nonatomic) IBOutlet UIButton *leftSegButton;
@property (weak, nonatomic) IBOutlet UIButton *midSegButton;
@property (weak, nonatomic) IBOutlet UIButton *rightSegButton;
@property (weak, nonatomic) IBOutlet UIButton *leftStateButton;
@property (weak, nonatomic) IBOutlet UIButton *rightState;
@property (nonatomic , strong)IDSSMRisk *risk;
@property (nonatomic, assign)NSInteger unitId;
@property (nonatomic, assign)NSInteger cellId;
@property (nonatomic, assign)BOOL addOrUpdate;
@property (nonatomic, assign)BOOL cellOrUnit;
@property (nonatomic, assign)NSInteger riskNum;
@end
