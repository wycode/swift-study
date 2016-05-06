//
//  IDSSMSubUnitsViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/23.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMSubUnitsViewController.h"
#import "IDSSMSubUnit.h"
#import "SubUnitTableViewController.h"
@interface IDSSMSubUnitsViewController ()<UITableViewDataSource,UITableViewDelegate,returnSubUnit>

@end

@implementation IDSSMSubUnitsViewController
-(instancetype)init
{
    if (self = [super init])
    {
        _subUnits = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addNewSubUnit)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = back;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)goBack
{
    [self.delegate setSubUnits:self.subUnits];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addNewSubUnit
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
    
    SubUnitTableViewController *subController = [storyboard instantiateViewControllerWithIdentifier:@"subUnit"];
    subController.delegate = self;
    subController.unitIsAddOrUpdate = self.unitIsAddOrUpdate;
    subController.isAddOrUpdate = YES;
    subController.unitId = self.unitId;
    [self.navigationController pushViewController:subController animated:YES];
}
- (void)getNewSubUnit:(IDSSMSubUnit *)subUnit num:(NSInteger)num row:(NSInteger)row

{
    
    [self.subUnits addObject:subUnit];
    
}
- (void)replaceSubUnit:(IDSSMSubUnit *)subUnit row:(NSInteger)row
{
    [self.subUnits replaceObjectAtIndex:row withObject:subUnit];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subUnits.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
    
    SubUnitTableViewController *subController = [storyboard instantiateViewControllerWithIdentifier:@"subUnit"];
    subController.delegate = self;
    subController.updateRow = indexPath.row;
    subController.unitIsAddOrUpdate = self.unitIsAddOrUpdate;
    subController.isAddOrUpdate = NO;
    subController.unitId = self.unitId;
    IDSSMSubUnit *subUnit = [self.subUnits objectAtIndex:indexPath.row];
    subController.subUnit = [[IDSSMSubUnit alloc]init];
    subController.subUnit = subUnit;
    [self.navigationController pushViewController:subController animated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subUnitCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"subUnitCell"];
    }
    IDSSMSubUnit *subUnit = [self.subUnits objectAtIndex:indexPath.row];
    cell.textLabel.text = subUnit.name;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
