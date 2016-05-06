//
//  IDSSMTabBarViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/7.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMTabBarViewController.h"
#import "IDSSMUnitTypeViewController.h"
#import "IDSSMListViewController.h"
#import "NetworkManager.h"
#import "IDSSMRisk.h"
#import "IDSSMBuildingEditTableViewController.h"
#import "IDSSMNormalUnitTableViewController.h"
#import "IDSSMComplexTableViewController.h"
#import "IDSSMUnitTableViewController.h"
@interface IDSSMTabBarViewController ()<CLLocationManagerDelegate,setCellsArray,UITableViewDataSource,UITableViewDelegate,getUnitTypes,reloadView>
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)NSMutableArray *selectArray;
@property (nonatomic, strong)UIView *backView;
@end

@implementation IDSSMTabBarViewController
- (instancetype)init
{
    if (self = [super init])
    {
        _cellsArray = [NSMutableArray array];
        _selectArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _selectArray = [NSMutableArray arrayWithObjects:@"建筑",@"单位或场所",@"一般场所",@"综合体建筑",nil];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, 120, 170) style:UITableViewStylePlain];
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    _imageView.frame = CGRectMake(width-120, 70, 120, 180);
    _imageView.userInteractionEnabled = YES;
    
   // [self.tableView.backgroundView addSubview:imageView];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
   // self.tableView.hidden = YES;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    IDSSMMapViewController *mapViewController = [self.viewControllers objectAtIndex:0];
    mapViewController.coordinate = coor;
    self.locationManager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]){
        NSLog(@"定位服务当前可能尚未打开，请设置打开");
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        CLLocationDistance distance = 10.0;
        self.locationManager.distanceFilter = distance;
        [self.locationManager startUpdatingLocation];
    }
    _backView = [[UIView alloc]initWithFrame:self.view.frame];
    self.backView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    
    [self.view addSubview:self.backView];

    self.imageView.hidden = YES;
    self.addCellOrUpdate = true;
    [self.view addSubview:_imageView];
    [_imageView addSubview:self.tableView];
    [self.imageView bringSubviewToFront:self.tableView];
    UIBarButtonItem *right =  [[UIBarButtonItem alloc] initWithTitle:@"+ 新增" style:UIBarButtonItemStylePlain target:self action:@selector(gotoEditing)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(gotoLeftSetting)];
    [self.tableView becomeFirstResponder];
    [item setTintColor:[UIColor whiteColor]];
  //  self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.hidesBackButton = YES;
   // [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1]];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    UITabBarItem *listItem = self.tabBar.items[1];
    listItem.imageInsets = UIEdgeInsetsMake(5.37, 0, -5.37, 0);
    listItem.image = [[UIImage imageNamed:@"list_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    self.navigationController.navigationBarHidden = NO;
  //  self.selectedIndex = 0;
}

- (void)setUnitTypes:(NSArray *)typesArray
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:typesArray forKey:@"typesArray"];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view sendSubviewToBack:self.backView];
    self.imageView.hidden = YES;
}
#pragma mark - 下拉列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell"];
    if (!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectCell"];
    cell.textLabel.text = [self.selectArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
        IDSSMBuildingEditTableViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"Building"];
        viewController.isAddOrUpdate = YES;
        viewController.name = @"";
        viewController.isAddOrUpdate = YES;
        viewController.risks = [NSMutableArray array];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if (indexPath.row == 2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
        IDSSMNormalUnitTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"yibancangs"];
    
        controller.isAddOrUpdate = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    if (indexPath.row == 3)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
        IDSSMComplexTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"zhongheti"];
        controller.isAddOrUpdate = YES;
        controller.risks = [NSMutableArray array];
        [self.navigationController pushViewController:controller animated:YES];
        return;
        
    }
    if (indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
        IDSSMUnitTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"unit"];
        controller.isAddOrUpdate = YES;
        controller.risks = [NSMutableArray array];
        [self.navigationController pushViewController:controller  animated:YES];
        return;
    }
   
}

#pragma mark - 获取cellsArray的回调

- (void)setCellsArray:(NSMutableArray *)cellsArray {
    
    self.cellsArray.array = cellsArray;
    IDSSMMapViewController *mapViewController = [self.viewControllers objectAtIndex:0];
    
    [mapViewController setCellsArray:cellsArray];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    mapViewController.coordinate = coor;

    [mapViewController annotationEditing];
    
  //  [mapViewController mapViewSetCenter:coor];
   // self.selectedIndex = 0;
    IDSSMListViewController *listViewController = [self.viewControllers objectAtIndex:1];
    listViewController.dataArray = cellsArray;
    [listViewController.tableView reloadData];
   
}

- (void)gotoLeftSetting{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"reset"];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    NetworkManager *netManager = [[NetworkManager alloc] init];
    netManager.delegate = self;
    netManager.latitude = self.latitude;
    netManager.longitude = self.longitude;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [netManager getBuildingList];
    NSString *userSn = [userDefault objectForKey:@"userSn"];
    netManager.typesDelegate = self;
    netManager.reloadDelegate = self;
    [netManager getAllGeoTypes:userSn];
    self.imageView.hidden = YES;
    [self.view sendSubviewToBack:self.backView];
    [self.imageView bringSubviewToFront:self.tableView];

    
}
- (void)reloadView:(NSDictionary *)dictionary
{
    [self.tableView reloadData];
}

- (void)gotoEditing {
    if(self.imageView.hidden == YES)
    {
        [self.view bringSubviewToFront:self.backView];
        [self.view bringSubviewToFront:self.imageView];
    }
    else
    {    [self.view sendSubviewToBack:self.backView];
        [self.view bringSubviewToFront:self.tableView];
    }
    self.imageView.hidden = !self.imageView.hidden;
   // self.tableView.hidden = !self.tableView.hidden;
  
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{

    CLLocation *location = [locations firstObject];
    self.coordinate = location.coordinate;
    
    [self.locationManager stopUpdatingLocation];
    NetworkManager *netManager = [[NetworkManager alloc] init];
    netManager.delegate = self;
    netManager.latitude = self.latitude;
    netManager.longitude = self.longitude;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(location.coordinate.latitude) forKey:@"userLat"];
    [userDefault setObject:@(location.coordinate.longitude) forKey:@"userLng"];

    NSString *userSn = [userDefault objectForKey:@"userSn"];
   // [netManager getCellsInMap:self.coordinate userSn:userSn];
    [netManager getBuildingList];
    netManager.typesDelegate = self;
    [netManager getAllGeoTypes:userSn];
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
