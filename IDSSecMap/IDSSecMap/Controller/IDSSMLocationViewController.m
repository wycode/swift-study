//
//  IDSSMLocationViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMLocationViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "IDSSMCell.h"
#import "IDSSMUnit.h"
#import "simpleTableViewCell.h"
@interface IDSSMLocationViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,AMapNearbySearchManagerDelegate,AMapSearchDelegate,MAMapViewDelegate>
@property (nonatomic, strong )CLGeocoder *geocoder;
@property (nonatomic, strong)AMapSearchAPI *search;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)UIImageView *pointView;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, assign)CLLocationCoordinate2D coordi;
@end

@implementation IDSSMLocationViewController
- (instancetype)init
{
    if (self = [super init])
    {
        _cellsArray = [NSMutableArray array];
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapSearchServices sharedServices].apiKey = @"6b46ad193f002fc26541d5c5f4c9c57b";
    // Do any additional setup after loading the view from its nib.
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,(height)/2, width, (height)/2)];
//    self.view addConstraints:[NSLayoutCon
    [self.view addSubview:_mapView];
    _dataArray = [NSMutableArray array];
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    float latitude = [[userdefault objectForKey:@"llll"] floatValue];
    float longitude = [[userdefault objectForKey:@"gggg"] floatValue];
    self.coordi = CLLocationCoordinate2DMake(latitude, longitude);
    _mapView.zoomLevel = 15.4;
    _mapView.delegate = self;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude) animated:YES];
    _pointView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pointA"]];
    _pointView.frame = CGRectMake(width/2,3*(height)/4, 20, 20);
    _pointView.center = self.mapView.center;
    [self.view addSubview:_pointView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, width, (height)/2)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
   [self.view addSubview:_tableView];
    
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc]init];
    request.types = @"地名地址信息";
    request.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    request.sortrule = 0;
    request.requireExtension = YES;
    [_search AMapPOIAroundSearch:request];
    
    for (int i = 0 ; i< 10 ;i++)
    {
            if (i < self.cellsArray.count)
            {
                IDSSMCell *onecell = [self.cellsArray objectAtIndex:i];
                IDSSMUnit *unit = [onecell.units lastObject];
                [self.dataArray addObject:unit.dwdz];
            }
        
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(summitAddress)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backGo)];
    [item setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)viewDidLayoutSubviews {
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
     self.tableView.frame = CGRectMake(0, 65, width, (height)/2);
    self.mapView.frame = CGRectMake(0,(height)/2, width, (height)/2);
    self.pointView.frame =CGRectMake(width/2,3*(height)/4, 20, 20);
}

#pragma mark - mapView 代理

- (void)backGo
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    
    CLLocationCoordinate2D coordinate = self.mapView.centerCoordinate;
    self.coordi = coordinate;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    float latitude = [[userdefault objectForKey:@"userLat"] floatValue];
    float longitude = [[userdefault objectForKey:@"userLng"] floatValue];
    NSLog(@"移动前: %f,,%f",latitude,longitude);
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc]init];
    request.types = @"地名地址信息";
    request.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude   longitude:coordinate.longitude];
    request.sortrule = 0;
    request.requireExtension = YES;
    [_search AMapPOIAroundSearch:request];
    
}
- (void)summitAddress
{
    if (_indexPath)
    {
    simpleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    NSString *string = cell.nameTextField.text;
    [self.addressDelegate getAddress:string latitude:self.coordi.latitude longitude:self.coordi.longitude];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    simpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
    if (!cell)
        cell = [[[NSBundle mainBundle]loadNibNamed:@"simpleTableViewCell" owner:self options:nil] lastObject];
    if (self.indexPath != indexPath)
    cell.accessoryType = UITableViewCellAccessoryNone;
    else
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.nameTextField.userInteractionEnabled = NO;
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.nameTextField.userInteractionEnabled = YES;
    }
    if (self.dataArray.count!=0)
    {
    cell.nameTextField.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_indexPath)
    {
        _indexPath = [[NSIndexPath alloc]init];
    }
    _indexPath = indexPath;
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 根据经纬度确定地名

- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
    }];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    if (self.dataArray.count<10)
    {
    for (int i = 0 ;i<5 ;i++)
    {
        AMapPOI *p = [response.pois objectAtIndex:i];
        [self.dataArray addObject:p.name];
    }
        [self.tableView reloadData];
        return;
    }
    else
    { for (int i = 0 ;i<10 ;i++)
    {
        if(i<response.pois.count)
        {
        AMapPOI *p = [response.pois objectAtIndex:i];
        [self.dataArray replaceObjectAtIndex:i withObject:p.name];
        }
    }
        [self.tableView reloadData];

        return;
        
    }
    
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
