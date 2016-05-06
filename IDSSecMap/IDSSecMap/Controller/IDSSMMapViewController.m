//
//  ViewController.m
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMCell.h"
#import "IDSSMCustomAnnotation.h"
#import "IDSSMMapViewController.h"
#import "IDSSMTabBarViewController.h"
#import "IDSSMUnit.h"
#import "NetworkManager.h"
#import <AFNetworking.h>
#import "IDSSMRisk.h"
#import "IDSSMListViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "IDSSMCustomAnnotationView.h"

@interface IDSSMMapViewController () <MAMapViewDelegate, setCellsArray,CLLocationManagerDelegate,MAAnnotation,IDSSMAnnotationViewDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)CLLocation *location;
@property (nonatomic, assign)NSInteger flag;
@end

@implementation IDSSMMapViewController
-(instancetype)init
{
    if (self= [super init])
    {
        _cellsArray = [NSMutableArray array];
        _location = [[CLLocation alloc]init];
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",[NSBundle mainBundle].bundleIdentifier);
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"地图" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goleft) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView setCenterCoordinate:self.coordinate animated:YES];
    NSLog(@"333%f",self.coordinate.latitude);
    self.tabBarItem  = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"map_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"map_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.37, 0, -5.37, 0);
    self.tabBarController.selectedIndex = 0;
    self.mapView.zoomLevel = 16;
    ;
        MACircle *circle = [MACircle circleWithCenterCoordinate:self.coordinate radius:300];
    [self.mapView addOverlay:circle];

    if(self.cellsArray.count!=0)
    {
    [self annotationEditing];
    }
    UIButton *shcsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shcsButton setTitle:@"涉会场馆" forState:UIControlStateNormal];
    shcsButton.frame = CGRectMake(0, 80, 70, 35);
    [shcsButton addTarget:self action:@selector(backToDepartments) forControlEvents:UIControlEventTouchUpInside];
    shcsButton.backgroundColor = [UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1];
    [shcsButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:shcsButton];

    UIButton *loca = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loca setImage:[UIImage imageNamed:@"pointA"] forState:UIControlStateNormal];
    
    loca.frame = CGRectMake(5, 350, 20, 20);
    [loca addTarget:self action:@selector(showLocation) forControlEvents:UIControlEventTouchUpInside];

}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
        NSLog(@"lat:--%f,lng:--%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
}
- (void)showLocation
{
//    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
//    [self.mapView isUserLocationVisible];
    NSLog(@"%@",self.mapView.userLocation);
    self.mapView.showsUserLocation = YES;
   // self.mapView.isUserLocationVisible = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
}
- (void)backToDepartments
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goleft
{
    self.tabBarController.selectedIndex = 0;
}
- (void)setCellsArray:(NSMutableArray *)cellsArray
{
    if (!_cellsArray)
    {
        _cellsArray = [NSMutableArray array];
    }
    _cellsArray = cellsArray;
}
- (void)viewDidAppear:(BOOL)animated
{
   // [self annotationEditing];
    
}
- (void)viewWillAppear:(BOOL)animated {
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"地图";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = label;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(goResetPassword)];
    [item setTintColor:[UIColor whiteColor]];
    self.tabBarController.navigationItem.leftBarButtonItem = item;
    [self annotationEditing];
    self.mapView.delegate = self;
    
    
    self.mapView.zoomLevel = 15;
    
  //  [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.25,120.21) animated:YES];
    if(self.cellsArray.count!=0)
    {
        IDSSMCell *cell = [self.cellsArray objectAtIndex:0];
        if(cell.imageString)
        {
            [self annotationEditing];
        }
        
    }
    float lat = [[[NSUserDefaults standardUserDefaults]objectForKey:@"llll"] floatValue];
    float lng = [[[NSUserDefaults standardUserDefaults]objectForKey:@"gggg"] floatValue];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, lng);
    [self.mapView setCenterCoordinate:coor animated:YES];
  
}
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc]initWithCircle:overlay];
     //   circleView.lineWidth = 5.f;
      //  circleView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleView.fillColor = [UIColor colorWithRed:0.0 green:0.01 blue:0.2 alpha:0.15];
        return circleView;
    }
    return nil;
}
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
{
    if(wasUserAction)
    {
    NSLog(@"%f",self.mapView.zoomLevel);
    if(self.mapView.zoomLevel<15)
        self.mapView.zoomLevel = 15;
    }
  
}
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{
    if(self.mapView.zoomLevel<15)
        self.mapView.zoomLevel = 15;
}

- (void)regionChangedCallback:(MAMapView *)mapView
{
    float lat0 = ((IDSSMTabBarViewController *)self.tabBarController).latitude;
    float lng0 = ((IDSSMTabBarViewController *)self.tabBarController).longitude;
    CLLocation *before = [[CLLocation alloc]initWithLatitude:lat0 longitude:lng0];
    
    CLLocationCoordinate2D coordi = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
    CLLocation *current = [[CLLocation alloc]initWithLatitude:coordi.latitude longitude:coordi.longitude];
    CLLocationDistance distance = [current distanceFromLocation:before];
    NSLog(@"%f",distance);
    if(distance>400)
    {
        float lat1 = current.coordinate.latitude;
        float lng1 = current.coordinate.longitude;
        
        float lat = lat0 + 400 * (lat1 - lat0) / distance;
        float lng = lng0 + 400 * (lng1 - lng0) / distance;
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:lat longitude:lng];
        
        [self.mapView setCenterCoordinate:location.coordinate animated: YES];
        
    }
}


- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self regionChangedCallback:mapView];
}

- (void)goResetPassword
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [story instantiateViewControllerWithIdentifier:@"reset"];
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - 地图显示

- (void)annotationEditing {
    for (int i = 0 ; i< self.cellsArray.count ; i++) {
        IDSSMCell *cell = [self.cellsArray objectAtIndex:i];

        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(cell.lat.doubleValue, cell.lng.doubleValue);
        IDSSMCustomAnnotation *annotation = [[IDSSMCustomAnnotation alloc] initWithLocation:coordinate];
        annotation.imageString = cell.imageString;
        annotation.title = [self stringFrom:cell];
        annotation.subtitle =[self subStringFrom:cell];
        annotation.cell = cell;
        annotation.index = i;
        [self.mapView addAnnotation:annotation];
    }
  
    
   
    
  
}
- (NSAttributedString *)stringFrom:(IDSSMCell *)cell
{
    int i = 0;
    
    for(IDSSMUnit *unit in cell.units)
    {
        if(unit.sfsyzddw== 1)
            i++;
    }
    long j = cell.units.count - i;
    NSString *string = [NSString stringWithFormat:@"重点单位   %d/%ld",i,j];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, 1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(8, 2)];
    return str;
}
- (NSAttributedString *)subStringFrom:(IDSSMCell *)cell
{
    NSString *str = cell.imageString;
    NSString *b = [str substringFromIndex:str.length-1];
    NSString *string = @"";
   
    if([b isEqualToString:@"0"])
        string = @"隐患情况 0/0/0/1";
    if([b isEqualToString:@"1"])
        string = @"隐患情况 0/0/1/0";
    if([b isEqualToString:@"2"])
        string = @"隐患情况 0/1/0/0";
    if([b isEqualToString:@"3"])
        string = @"隐患情况 1/0/0/0";
    NSMutableAttributedString *ssss = [[NSMutableAttributedString alloc]initWithString:string];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:250/255.0 green:200/255.0 blue:22/255.0 alpha:1] range:NSMakeRange(7, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(8, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(9, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(10, 1)];
    [ssss addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(11, 1)];
    return ssss;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    IDSSMCustomAnnotationView *view =(IDSSMCustomAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if (!view){
     view = [[IDSSMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    }
    
    view.annotationDelegate = self;
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
//        pre.image = [UIImage imageNamed:@"pointA"];
//        pre.lineWidth = 3;
//        pre.lineDashPattern = @[@6, @3];
//        
//        [self.mapView updateUserLocationRepresentation:pre];
//        
//        view.calloutOffset = CGPointMake(0, 0);
//        return view;  
//    } 
 //   else
 //   {
    //[view addSubview:label];
  //  view.calloutView.title = @"asdasd";
    view.canShowCallout = YES;
    NSString *string =( (IDSSMCustomAnnotation *)annotation).imageString;
    view.image = [UIImage imageNamed:string];
    view.canShowCallout = NO;
    return view;
 //   }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSString *string = ((IDSSMCustomAnnotation *)view.annotation).imageString;
    view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on",string]];
}
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    NSString *string = ((IDSSMCustomAnnotation *)view.annotation).imageString ;
    view.image = [UIImage imageNamed:string];
}
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
   
    IDSSMListViewController *listViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    self.tabBarController.selectedIndex = 1;
    listViewController.backIndex = ((IDSSMCustomAnnotation *)view.annotation).index;
    listViewController.indexPath = nil;
    [listViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:listViewController.backIndex] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}
- (void)didAnnotationViewCalloutTapped:(IDSSMCustomAnnotationView *)view
{
    IDSSMListViewController *listViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    self.tabBarController.selectedIndex = 1;
    listViewController.backIndex = ((IDSSMCustomAnnotation *)view.annotation).index;
    listViewController.indexPath = nil;
    IDSSMCell *cell = [listViewController.dataArray objectAtIndex:listViewController.backIndex];
    if(cell.units.count==0)
        return;
    
    [listViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:listViewController.backIndex] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
- (void)mapViewSetCenter:(CLLocationCoordinate2D)coordinate
{
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    NSLog(@"555%f",coordinate.latitude);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
