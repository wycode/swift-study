//
//  IDSSMUnitRisksViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMUnitRisksViewController.h"
#import "FirstTableViewCell.h"
#import "IDSSMEditRiskViewController.h"
@interface IDSSMUnitRisksViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger numOfRisk;
@property (nonatomic, strong)NSMutableArray *array;
@end

@implementation IDSSMUnitRisksViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _risks = [NSMutableArray array];
        _array = [NSMutableArray array];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect frame = CGRectMake(0, 0, 375, 670);
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.array = [NSMutableArray arrayWithObjects:@"隐患描述",@"隐患详情",@"隐患程度",@"排除状况",@"纪录时间",nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"隐患";
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;

    self.navigationItem.titleView = label;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UITabBarController *tabController = [self.navigationController.viewControllers objectAtIndex:2];
  //  tabController.tabBar.hidden = YES;
}
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonClick
{
   
    IDSSMEditRiskViewController *riskEditViewController = [[IDSSMEditRiskViewController alloc]init];
    riskEditViewController.addOrUpdate = true;
    riskEditViewController.unitId = self.unitId;
    riskEditViewController.cellId = self.cellId;
    riskEditViewController.cellOrUnit = self.cellOrUnit;
   // riskEditViewController.riskDelegate = self;
   // riskEditViewController.unitId = self.unitId;
    [self.navigationController pushViewController:riskEditViewController animated:YES];
}
- (void)riskReturn:(IDSSMRisk *)risk
{
    
}
#pragma mark - tableView的代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.risks.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"riskCell"];
    if(!cell)
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstTableViewCell" owner:self options:nil] lastObject];
    if(self.array.count != 0)
    {
    cell.titleLabel.text = [self.array objectAtIndex:indexPath.row];
    IDSSMRisk *risk = [self.risks objectAtIndex:indexPath.section];
  //  NSLog(@"%d",risk.priority);
    NSArray *degree = [NSArray arrayWithObjects:@"无隐患",@"一般隐患",@"重大隐患", nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:risk.recordTime/1000];
    switch (indexPath.row) {
        case 0:
            cell.detailText.text = risk.brief;
            break;
        case 1:
            cell.detailText.text = risk.detail;
            break;
        case 2:
            if(risk.priority>=1&&risk.priority<=3)
            {
            cell.detailText.text = [degree objectAtIndex:risk.priority-1];
            break;
            }
        case 3:
            cell.detailText.text = risk.state == 1?@"未排除":@"已排除";
            break;
        case 4:
            cell.detailText.text = [formatter stringFromDate:date];
            break;
        default:
            break;
    }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailText.userInteractionEnabled = NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   IDSSMRisk *risk = [self.risks objectAtIndex:indexPath.section];
    self.numOfRisk = indexPath.section;
    
    IDSSMEditRiskViewController *editRiskViewController = [[IDSSMEditRiskViewController alloc]init];
    editRiskViewController.risk = risk;
    
   // editRiskViewController.cellId = self.cellId;
    editRiskViewController.riskNum = indexPath.section;
    editRiskViewController.addOrUpdate = false;
    [self.navigationController pushViewController:editRiskViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setRisk:)])
    {
        [destination setValue:[self.risks objectAtIndex:self.numOfRisk] forKey:@"risk"];
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
