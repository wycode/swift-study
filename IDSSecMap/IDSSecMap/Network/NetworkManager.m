//
//  NetworkManager.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/8.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>
#import "IDSSMRisk.h"
#import "IDSSMSubUnit.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
@implementation NetworkManager

#pragma mark - 地图cell网络请求

- (void)getCellsInMap:(CLLocationCoordinate2D)coordinate userSn:(NSString *)userSn{

    _cellsArray = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@(1), @"startTime", @(10), @"endTime", userSn, @"userSn", @(self.latitude), @"lat", @(self.longitude), @"lng", @(300), @"scale", nil];
    [manager POST:@"http://secmap.indoorstar.com:6620/secmap/listCells" parameters:dictionary progress:^(NSProgress *_Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            [self analysisJson:responseObject];
            //  [self annotationEditing];
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"failure!");
        }];
}

- (void)analysisJson:(NSDictionary *)responseObject {

    NSString *string = (NSString *)[responseObject objectForKey:@"d"];
    NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dictionary in array) {
        IDSSMCell *cell = [[IDSSMCell alloc] init];
        cell.cellId = [dictionary objectForKey:@"id"];
        cell.districtId = [[dictionary objectForKey:@"districtId"] integerValue];
        cell.lng = [dictionary objectForKey:@"lng"];
        cell.lat = [dictionary objectForKey:@"lat"];
        NSArray *unitsArray = [dictionary objectForKey:@"units"];
        for (NSDictionary *unitDictionary in unitsArray) {
            IDSSMUnit *unit = [[IDSSMUnit alloc] init];
            unit.ID = [unitDictionary[@"id"] intValue];
            unit.cellId = [unitDictionary[@"cellId"] intValue];
            unit.dwlx = [unitDictionary[@"dwlx"] intValue];
            unit.dwmc = unitDictionary[@"dwmc"];
            unit.dwdz = unitDictionary[@"dwdz"];
            unit.dwfzr = unitDictionary[@"dwfzr"];
            unit.lxr = unitDictionary[@"lxr"];
            unit.lxdh = unitDictionary[@"lxdh"];
            
            unit.sfsyzddw = [unitDictionary[@"sfsyzddw"] integerValue];
            unit.sfpdwzdwxy = [unitDictionary[@"sfpdwzdwxy"] integerValue];
            unit.sfsxfkzs = [unitDictionary[@"sfsxfkzs"] integerValue];
            unit.sfqdxfxgsx = [unitDictionary[@"sfqdxfxgsx"] integerValue];
            unit.sflsljy = [unitDictionary[@"sflsljy"] integerValue];
            unit.sfty = [unitDictionary[@"sfty"] integerValue];
            unit.csqk = unitDictionary[@"csqk"];
            unit.zgsmc = unitDictionary[@"zgsmc"];
            unit.risks = [NSMutableArray array];
            for (NSDictionary * riskDictionary in unitDictionary[@"risks"]){
                IDSSMRisk *risk = [[IDSSMRisk alloc]init];
                risk.brief = riskDictionary[@"brief"];
                risk.detail = riskDictionary[@"detail"];
                risk.ID = [riskDictionary[@"id"] integerValue];
                risk.priority = [riskDictionary[@"priority"]integerValue];
                
                NSNumber *dateNum = riskDictionary[@"recordTime"];
                NSTimeInterval time = [dateNum doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
                risk.recordTime = date;
                risk.state = [riskDictionary[@"state"] integerValue];
                risk.unitId = [riskDictionary[@"unitId"] integerValue];
                [unit.risks addObject:risk];
            }
            
               [cell.units addObject:unit];
        }
        NSString *leftString = @"";
        NSString *rightString = @"2";
        for (IDSSMUnit *unit in cell.units) {
            if (unit.sfsyzddw)
                leftString = @"icon_key_unit";
            else
                leftString = @"icon_unit";
            rightString = @"2";
            if (unit.risks.count == 0) {
                rightString = @"0";
            } else {
                BOOL k = false;
                for (int i = 0; i<unit.risks.count ;i++) {
                    IDSSMRisk *risk = [unit.risks objectAtIndex:i];
                    if (risk.state == 1)
                        k = true;
                   
                }
                if (k == false)
                    rightString = @"1";
                else
                {
                for (IDSSMRisk *risk in unit.risks) {
                    if (risk.priority==3&&risk.state ==1)
                    {
                        rightString = @"3";
                    }
                }
                }
            }
            unit.imageString = [NSString stringWithFormat:@"%@%@",leftString,rightString];
        }

        [self.cellsArray addObject:cell];
    }
   
    [self.delegate setCellsArray:self.cellsArray];
   // [self.delegate annotationEditing];

    //
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

- (NSString *)trransFromMD532ToMD516:(NSString *)MD532{
    NSString  * string;
    for (int i=0; i<24; i++) {
        string=[MD532 substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
#pragma mark - 用户登录网络请求

- (void)loginWithName:(NSString *)name password:(NSString *)password {
    
    NSString *str =  [self MD5Digest:password];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/login";
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:name,@"phone",str,@"password",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSString *string = [responseObject objectForKey:@"d"];
        if ([[responseObject objectForKey:@"m"] isEqualToString:@"获取数据失败"])
        {
            MBProgressHUD *hud = [MBProgressHUD HUDForView:((UIViewController *)self.loginDelegate).view];
            hud.minShowTime = 2;
            hud.label.text = @"账号或密码错误!";
            [hud hideAnimated:YES];
            return ;
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD HUDForView:((UIViewController *)self.loginDelegate).view];
            hud.label.text = @"登录成功!";
            hud.minShowTime = 2;
            [hud hideAnimated:YES];
        }
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSNumber *num = [responseObject objectForKey:@"s"];
        if (num.intValue == 0) {
            [self.loginDelegate resultFromNetwork:dictionary];
        }
        

    }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"why");
            MBProgressHUD *hud = [MBProgressHUD HUDForView:((UIViewController *)self.loginDelegate).view];
            hud.label.text = @"登录失败，检查网络";
            hud.minShowTime = 2;
            [hud hideAnimated:YES];
            
        //    [self.loginDelegate resultFromNetwork:nil];
        }];
}

#pragma mark - 获得单位类型网络请求


- (void)getAllGeoTypes:(NSString *)userSn
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/listAllGeoTypes";
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  [self.typesDelegate setUnitTypes];
        [self jsonWithTypes:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"getTypes Faliure!");
    }];
}

- (void)jsonWithTypes:(NSDictionary *)dictionary
{
    NSString *string = [dictionary objectForKey:@"d"];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [self.typesDelegate setUnitTypes:array];
}

#pragma mark - 更新unit

- (void)updateUnit:(NSString *)unit userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/updateUnit";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",unit,@"unit",nil];
    [manager POST:stringUrl parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}

#pragma mark - 添加unit

- (void)addUnit:(NSString *)unit userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/addUnit";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",unit,@"unit",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];

        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"add unit failure");
    }];
}
#pragma  mark - 更新隐患
- (void)updateRisk:(NSString *)userSn risk:(NSString *)risk
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/updateRisk";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",risk,@"risk",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self.reloadDelegate reloadView:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"update risk failure");
    }];
    
}
#pragma  mark - 添加隐患
- (void) addRisk:(NSString *)userSn risk:(NSString *)risk
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/addRisk";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",risk,@"risk",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"add risk failure");
    }];

}


#pragma mark - 添加建筑

- (void)addBuilding:(NSString *)building userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/addCell";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",building,@"cell",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"add building failure");
    }];
}
#pragma mark - 修改建筑
- (void)updateBuilding:(NSString *)building userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/updateCell";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",building,@"cell",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"update building failure");
    }];
}
#pragma  mark - 获取建筑列表

- (void)getBuildingList
{
    _buildingArray = [NSMutableArray array];
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/listCells";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  
    NSString *userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
   // NSDate now = [NSDate date];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long t = (long)time;
    long lastTime = t-30*24*60*60;

    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",@(self.latitude),@"lat",@(self.longitude),@"lng",userSn,@"userSn",@(300),@"scale",@(lastTime*1000),@"startTime",@(t*1000),@"endTime",nil];
    
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"d"]);
        [self jsonBuildingList:[responseObject objectForKey:@"d"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get building failure");
    }];

}
- (void)jsonBuildingList:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *buildingNameArr = [NSMutableArray array];
    for (NSDictionary *dic in arr)
    {
    IDSSMCell *cell = [[IDSSMCell alloc]init];
    cell.cellId = [dic objectForKey:@"id"];
    [cell setValuesForKeysWithDictionary:dic];
    cell.cellId = [dic objectForKey:@"id"];
    NSDictionary *nameAndIdDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:cell.cellId,@"id",cell.name,@"name", nil];
    [buildingNameArr addObject:nameAndIdDic];
    cell.jgsj = [[dic objectForKey:@"jgsj"] longValue]/1000;
        NSMutableArray *unitTempArr = [NSMutableArray arrayWithArray:dic[@"units"]];
        
        cell.units = [NSMutableArray array];
        cell.risks = [NSMutableArray array];
        for (NSDictionary *cellRisk in dic[@"risks"])
        {
            IDSSMRisk *risk = [[IDSSMRisk alloc]init];
            [risk setValuesForKeysWithDictionary:cellRisk];
            risk.ID = [cellRisk[@"id"] integerValue];
            [cell.risks addObject:risk];
        }
    for (NSDictionary *unitDic in unitTempArr)
    {
        IDSSMUnit *unit = [[IDSSMUnit alloc]init];
        [unit setValuesForKeysWithDictionary:unitDic];
        unit.risks = [NSMutableArray array];
        unit.ID = [unitDic[@"id"] integerValue];
        if ([unitDic objectForKey:@"risks"]!=NULL)
        {
            NSMutableArray *riskArr = [NSMutableArray arrayWithArray:unitDic[@"risks"]];
            
        for (NSDictionary *riskDic in riskArr)
        {
            IDSSMRisk *risk = [[IDSSMRisk alloc]init];
            [risk setValuesForKeysWithDictionary:riskDic];
            risk.ID = [riskDic[@"id"] integerValue] ;
            [unit.risks addObject:risk];
        }
        }
        unit.subUnits = [NSMutableArray array];
        if ([unitDic objectForKey:@"subUnits"]!=NULL)
        {
            NSMutableArray *subUnitsArr = [NSMutableArray arrayWithArray:unitDic[@"subUnits"]];
            for (NSDictionary *subUnitDic in subUnitsArr)
            {
                IDSSMSubUnit *subUnit = [[IDSSMSubUnit alloc]init];
                [subUnit setValuesForKeysWithDictionary:subUnitDic];
                subUnit.ID = [subUnitDic[@"id"] intValue];
                [unit.subUnits addObject:subUnit];
            }
        }
        
        [cell.units addObject:unit];
    }
        NSString *cellLeftString = @"icon_unit";
        NSString *cellRightString = @"0";
        NSString *leftString = @"";
        NSString *rightString = @"2";
        for (IDSSMUnit *unit in cell.units) {
            if (unit.sfsyzddw)
                leftString = @"icon_key_unit";
            else
                leftString = @"icon_unit";
            rightString = @"2";
            if (unit.risks.count == 0) {
                rightString = @"0";
            } else {
                BOOL k = false;
                for (int i = 0; i<unit.risks.count ;i++) {
                    IDSSMRisk *risk = [unit.risks objectAtIndex:i];
                    if (risk.state == 1)
                        k = true;
                    
                }
                if (k == false)
                    rightString = @"1";
                else
                {
                    for (IDSSMRisk *risk in unit.risks) {
                        if (risk.priority==3&&risk.state ==1)
                        {
                            rightString = @"3";
                        }
                    }
                }
            }
           
            unit.imageString = [NSString stringWithFormat:@"%@%@",leftString,rightString];
            if([leftString isEqualToString:@"icon_key_unit"])
            {    cellLeftString = @"icon_key_unit";
            }
       
        }
        for(IDSSMUnit *unit in cell.units)
        {
            if(unit.risks.count != 0)
            {
                for(IDSSMRisk *risk in unit.risks)
                {
                    if(risk.priority==3&&risk.state ==1)
                    {
                        cellRightString = @"3";
                    }
                }
            }
        }
        if(![cellRightString isEqualToString:@"3"])
        {
        for(IDSSMUnit *unit in cell.units)
        {
            if(unit.risks.count != 0)
            {
                for(IDSSMRisk *risk in unit.risks)
                {
                    if(risk.priority == 2 &&risk.state ==1)
                    {
                        cellRightString = @"2";
                    }
                }
            }
        }
        }
        if(![cellRightString isEqualToString:@"3"]&&![cellRightString isEqualToString:@"2"])
        {
            int k = 0;
            int riskCount = 0;
            for(IDSSMUnit *unit in cell.units)
            {
                
                if(unit.risks.count != 0)
                {
                    for (IDSSMRisk *risk in unit.risks)
                    {
                        if(risk.state == 1)
                            k = 1;
                    }
                    riskCount++;
                }
            }
            if(k == 0 &&riskCount!=0)
                cellRightString = @"1";
        }
        cell.imageString = [NSString stringWithFormat:@"%@%@",cellLeftString,cellRightString];
    
        [self.buildingArray addObject:cell];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSArray arrayWithArray:buildingNameArr] forKey:@"buildAr"];
   // NSLog(@"==%d",buildingNameArr.count);
    [self.delegate setCellsArray:self.buildingArray];
    [self.reloadDelegate reloadView:nil];
}
#pragma mark - 添加修改综合体内部场所
- (void)addSubUnit:(NSString *)subUnit userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/addSubUnit";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",subUnit,@"subUnit",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"update building failure");
    }];

}
- (void)updateSubUnit:(NSString *)subUnit userSn:(NSString *)userSn
{
    NSString *stringUrl = @"http://secmap.indoorstar.com:6620/secmap/updateSubUnit";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userSn,@"userSn",subUnit,@"subUnit",nil];
    [manager POST:stringUrl parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reloadDelegate reloadView:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"update building failure");
    }];

}
@end
