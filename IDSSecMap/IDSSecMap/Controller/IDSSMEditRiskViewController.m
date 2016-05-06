//
//  IDSSMEditRiskViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/16.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMEditRiskViewController.h"
#import "NetworkManager.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "IDSSMUnitRisksViewController.h"
#import "IDSSMTabBarViewController.h"
@interface IDSSMEditRiskViewController ()<reloadView,MBProgressHUDDelegate>

@end

@implementation IDSSMEditRiskViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _risk = [[IDSSMRisk alloc]init];
        self.risk.state = 1;
        self.risk.priority = 1;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = @"隐患编辑";
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    UIBarButtonItem *rightButtnon = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(summitEditing)];
    self.navigationItem.rightBarButtonItem = rightButtnon;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.riskBrief.text = self.risk.brief;
    self.riskDetail.text = self.risk.detail;
    switch (self.risk.priority) {
        case IDSSMRiskNone:
            self.leftSegButton.selected = YES;
            break;
        case IDSSMRiskLight:
            self.midSegButton.selected = YES;
            break;
        case IDSSMRiskSevere:
            self.rightSegButton.selected = YES;
            break;
        default:
            {self.leftSegButton.selected = YES;
                self.risk.priority = IDSSMRiskNone;
               // self.risk.state = 1;
           }
            break;
    }
    
    if (self.risk.state == 1)
    {
        self.leftStateButton.selected = YES;
        self.rightState.selected = NO;
    }
    else
    { self.rightState.selected = YES;
        self.leftStateButton.selected = NO;
    }
    switch (self.risk.state) {
        case 1:
        { self.leftStateButton.selected = YES;
            self.rightState.selected = NO;
        }
            break;
        case 2:
        {  self.rightState.selected = YES;
            self.leftStateButton.selected = NO;
        }
            break;
        default:
            break;
    }
}
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 上传完成后的回调
- (void)reloadView:(NSDictionary *)dictionary
{
    NSString *string = [dictionary objectForKey:@"d"];
    if(string == nil)
        return;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *riskDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",riskDic);
    IDSSMRisk *risk = [[IDSSMRisk alloc]init];
    risk.ID = [riskDic[@"id"] integerValue];
    risk.unitId = [riskDic[@"unitId"]integerValue];
    risk.brief = riskDic[@"brief"];
    risk.detail = riskDic[@"detail"];
    risk.priority = [riskDic[@"priority"] integerValue];
    risk.state = [riskDic[@"state"] integerValue];
    
    risk.recordTime = self.risk.recordTime*1000;
    self.risk = risk;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    hud.customView = imageView;
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = NSLocalizedString(@"完成", @"ok");
    [hud hideAnimated:YES afterDelay:1.f];

}
#pragma mark - 上传完成后的回调
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    
    if (self.addOrUpdate)
    {
         IDSSMUnitRisksViewController *risksViewController = [self.navigationController.viewControllers objectAtIndex:3];
        
            [risksViewController.risks addObject:self.risk];
            [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        IDSSMUnitRisksViewController *risksViewController = [self.navigationController.viewControllers objectAtIndex:3];
        [risksViewController.risks replaceObjectAtIndex:self.riskNum withObject:self.risk];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)summitEditing
{
    self.risk.brief = self.riskBrief.text;
    self.risk.detail = self.riskDetail.text;
    
    self.risk.recordTime = [[NSDate date] timeIntervalSince1970];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
    hud.minSize = CGSizeMake(150.f, 100.f);
    hud.minShowTime = 1.f;
 
    if (self.addOrUpdate)
    {
        
        NetworkManager *manager = [[NetworkManager alloc]init];
        NSDictionary *dictionar1 = [NSDictionary dictionaryWithObjectsAndKeys:self.risk.brief,@"brief",self.risk.detail,@"detail",@(self.risk.priority),@"priority",@(self.risk.state),@"state",@(self.unitId),@"unitId",nil];
         NSDictionary *dictionar2 = [NSDictionary dictionaryWithObjectsAndKeys:self.risk.brief,@"brief",self.risk.detail,@"detail",@(self.risk.priority),@"priority",@(self.risk.state),@"state",@(self.cellId),@"cellId",nil];
        NSString *string = @"";
        if(!self.cellOrUnit)
        {
            string = [dictionar1 JSONString];
        }
        else
        {
            string = [dictionar2 JSONString];
        }
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        NSString *user = [userdefault objectForKey:@"userSn"];
        manager.reloadDelegate = self;
        [manager addRisk:user risk:string];
    }
    else
    {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.risk.brief,@"brief",self.risk.detail,@"detail",@(self.risk.priority),@"priority",@(self.risk.state),@"state",@(self.risk.unitId),@"unitId",@(self.risk.ID),@"id",nil];
         NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:self.risk.brief,@"brief",self.risk.detail,@"detail",@(self.risk.priority),@"priority",@(self.risk.state),@"state",@(self.risk.cellId),@"cellId",@(self.risk.ID),@"id",nil];
         NSString *string = @"";
        if(self.cellOrUnit)
        {
           string = [dictionary JSONString];
        }
        else
        {
            string = [dictionary2 JSONString];
        }
        NetworkManager *manager = [[NetworkManager alloc]init];
        manager.reloadDelegate = self;
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        NSString *user = [userdefault objectForKey:@"userSn"];
        [manager updateRisk:user risk:string];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)buttonClick:(UIButton *)sender {
    
   if (sender.tag<105)
   {
       self.leftSegButton.selected = NO;
       self.midSegButton.selected = NO;
       self.rightSegButton.selected = NO;
       sender.selected = YES;
       self.risk.priority = sender.tag - 100 ;
   }
    else
    {
        self.leftStateButton.selected = NO;
        self.rightState.selected = NO;
        sender.selected = YES;
        
        self.risk.state = sender.tag - 1000;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
