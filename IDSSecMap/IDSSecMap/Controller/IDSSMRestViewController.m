//
//  IDSSMRestViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/24.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMRestViewController.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonCrypto.h>
@interface IDSSMRestViewController ()

@end

@implementation IDSSMRestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"设置";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1]];
    self.userLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    
    //self.userLabel.text =
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *)MD5Digest:(NSString *)str
{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH ];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    char cString[digest.length + 1];
    
    [digest getCString:cString maxLength:digest.length + 1 encoding:NSASCIIStringEncoding];
    
    for(int i=0 ;i<14;i++)
    {
        char k;
        k = cString[i];
        cString[i] = cString[digest.length-i - 1];
        cString[digest.length-i - 1] = k;
        
    }
    NSString *newStr = [[[NSString alloc] initWithCString:cString encoding:NSASCIIStringEncoding] uppercaseString];
    
    return newStr;
}
- (IBAction)summitChange:(UIButton *)sender {
    
  //  changePassword?oldPassword=XXX&newPassword=XXX —> Boolean  密码为MD5加密后的值
    NSString *old = [self MD5Digest:self.oldPassword.text];
    NSString *new = [self MD5Digest:self.changedPassword.text];
    NSString *userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:old,@"oldPassword",new,@"newPassword",userSn,@"userSn",nil];
    NSString *str = @"http://secmap.indoorstar.com:6620/secmap/changePassword";
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"why");
    }];
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
