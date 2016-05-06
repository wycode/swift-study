//
//  IDSSMListOfDepartmentViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/27.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMListOfDepartmentViewController.h"
#import "IDSSMTabBarViewController.h"
#import "IDSSShcsTableViewCell.h"
@interface IDSSMListOfDepartmentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSMutableArray *finalArray;
@end
@implementation IDSSMListOfDepartmentViewController
- (instancetype)init
{
    if(self = [super init])
    {
        _dataArray = [NSMutableArray array];
        _finalArray = [NSMutableArray array];
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"选择涉会场馆";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1]];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    self.sectionArray = [NSMutableArray array];
    NSArray *arra = [[NSUserDefaults standardUserDefaults]objectForKey:@"districts"];
    
    
        for (NSDictionary *district in arra)
        {
            NSMutableArray *dis = [NSMutableArray array];

            for (NSDictionary *dic in self.dataArray)
            {
            if(dic[@"districtId"] == district[@"id"])
                [dis addObject:dic];
            }
            [self.sectionArray addObject:dis];
        }
    
    
    
  
  
       // if(arr.count!=0)
    self.finalArray = self.sectionArray;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回地图" style:UIBarButtonItemStylePlain target:self action:@selector(backToLastMap)];
    [item setTintColor:[UIColor whiteColor]];
    if(self.indexPath != nil)
    self.navigationItem.rightBarButtonItem = item;
    
}
- (void)backToLastMap
{
    NSDictionary *dic = [[self.finalArray objectAtIndex:self.indexPath.section] objectAtIndex:self.indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    IDSSMTabBarViewController *tabController = (IDSSMTabBarViewController *)[story instantiateViewControllerWithIdentifier:@"TabBarController"];
    tabController.userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
    tabController.latitude = [dic[@"lat"] floatValue];
    tabController.longitude = [dic[@"lng"] floatValue];
    [self.navigationController pushViewController:tabController animated:YES];

}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.finalArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [self.finalArray objectAtIndex:section];
    return arr.count;
}
- (IDSSShcsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IDSSShcsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"departmentCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"IDSSShcsTableViewCell" owner:self options:nil] lastObject];
    }
    NSArray *arr = [self.finalArray objectAtIndex:indexPath.section];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"name"];
    cell.addrLabel.text = [dic objectForKey:@"addr"];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"districts"];;
    NSArray *dicA = self.finalArray[section];
    NSDictionary *dic = dicA.lastObject;
    for (NSDictionary *ddd in arr)
    {
        if(ddd[@"id"] == dic[@"districtId"])
        {
            return ddd[@"name"];
        }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_indexPath)
        _indexPath = [[NSIndexPath alloc]init];
    self.indexPath = indexPath;
    
    NSDictionary *dic = [[self.finalArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    IDSSMTabBarViewController *tabController = (IDSSMTabBarViewController *)[story instantiateViewControllerWithIdentifier:@"TabBarController"];
            tabController.userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
    tabController.latitude = [dic[@"lat"] floatValue];
    tabController.longitude = [dic[@"lng"] floatValue];
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:dic[@"lat"] forKey:@"llll"];
    [user setObject:dic[@"lng"] forKey:@"gggg"];
    [self.navigationController pushViewController:tabController animated:YES];
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
