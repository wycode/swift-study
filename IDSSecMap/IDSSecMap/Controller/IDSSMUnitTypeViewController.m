//
//  IDSSMUnitTypeViewController.m
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMUnitTypeViewController.h"
#import "NetworkManager.h"
@interface IDSSMUnitTypeViewController () <UITableViewDataSource, UITableViewDelegate,getUnitTypes>
@end

@implementation IDSSMUnitTypeViewController

- (instancetype)init {
    if (self = [super init]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [NSMutableArray array];
   
    self.view.backgroundColor = [UIColor lightGrayColor];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    NetworkManager *manager = [[NetworkManager alloc]init];
    manager.typesDelegate = self;
    NSUserDefaults *userfault = [NSUserDefaults standardUserDefaults];
    NSString *userSn = [userfault objectForKey:@"userSn"];
   // [manager getAllUnitTypes:userSn];
}

- (void)backItemClick {
    NSInteger number = 0;
    for (int i = 0; i<self.indexPath.section ;i++)
    {
        NSArray *secArr = [self.array objectAtIndex:i];
        number = number +secArr.count;
    }
    number = number +self.indexPath.row+1;
    
    [self.delegate setUnitType:[[self.array objectAtIndex:self.indexPath.section] objectAtIndex:self.indexPath.row] num:number];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = [self.array objectAtIndex:section];
       return group.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSArray *groups = [NSArray arrayWithObjects:@"未分类",@"人员密集场所", @"危险化学品场所", @"高层地下建筑", @"重要机关和单位", @"大型仓储", @"大型城市综合体", @"一般场所", nil];
    return groups[section];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"styleCell"];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"styleCell"];
    }
    if (self.indexPath &&self.indexPath!=indexPath)
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
    
    if (self.indexPath == indexPath)
        tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    tableViewCell.textLabel.text = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return tableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.indexPath == indexPath)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.indexPath = indexPath;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    self.indexPath = nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - unitTypes代理方法

- (void)setUnitTypes:(NSArray *)typesArray
{
    
    for (int i=0; i<8; i++) {
        NSMutableArray *oneGroup = [NSMutableArray array];
        for(NSDictionary *dictionary in typesArray)
        {
            NSNumber *group = dictionary[@"group"];
            if (group.intValue == i )
            {
                [oneGroup addObject:dictionary[@"name"]];
                
            }
        }
        [self.array addObject:oneGroup];
    }
  //  NSLog(@"%@",self.array);
    [self.tableView reloadData];
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
