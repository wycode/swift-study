//
//  IDSSMLoginViewController.m
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMLoginViewController.h"
#import "IDSSMTabBarViewController.h"
#import "NetworkManager.h"
#import <AFNetworking.h>
#import "IDSSMListOfDepartmentViewController.h"
#import "MBProgressHUD.h"
@interface IDSSMLoginViewController () <loginDelegate>
@property (nonatomic, assign) BOOL result;

@end

@implementation IDSSMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES; 
}
- (void)resultFromNetwork:(NSDictionary *)dictionary {
    NSString *userSn = dictionary[@"userSn"];
    long departmentId = [dictionary[@"departmentId"] longValue];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long t = (long)time;
    long lastTime = t-30*24*60*60;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:userSn forKey:@"userSn"];
    [userDefault setObject:dictionary[@"name"] forKey:@"userName"];
 //  if (userSn.length != 0) {

 //   }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",@(departmentId),@"departmentId",@(lastTime*1000),@"startTime",@(t*1000),@"endTime", nil];
    NSString *url = @"http://secmap.indoorstar.com:6620/secmap/listCellsOfDepartment";
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@--",responseObject);
        NSString *string = [responseObject objectForKey:@"d"];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        IDSSMListOfDepartmentViewController *controller = [[IDSSMListOfDepartmentViewController alloc]init];
        controller.dataArray.array = array;
        
        NSDictionary *ddd = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",@(departmentId),@"departmentId",@(lastTime*1000),@"startTime",@(t*1000),@"endTime", nil];
        [manager POST:@"http://secmap.indoorstar.com:6620/secmap/listDistrictsOfLeaderDepartment" parameters:ddd progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *districtsString= [responseObject objectForKey:@"d"];
            NSData *data = [districtsString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *districtsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *arr = [NSMutableArray array];
            for(NSDictionary *dicti in districtsArray)
            {
                [arr addObject:dicti[@"id"]];
            }
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:arr forKey:@"districtsArray"];
            [userDefault setObject:districtsArray forKey:@"districts"];
            [self.navigationController pushViewController:controller animated:YES];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"ehty");
        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"aad");
    }];
    
  

}
- (void)jsonWithDepartment:(NSDictionary *)responseObject
{
    
   // [controller.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"正在登录...", @"正在加载");
    hud.minSize = CGSizeMake(150.f, 100.f);
    
    NetworkManager *manager = [[NetworkManager alloc] init];
    manager.loginDelegate = self;
    [manager loginWithName:self.nameLabel.text password:self.passwordLabel.text];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
