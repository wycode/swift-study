//
//  IDSSMListViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/7.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMCell.h"
#import <AFNetworking.h>
#import "NetworkManager.h"
#import "IDSSMListViewController.h"
#import "IDSSMTabBarViewController.h"
#import "IDSSMUnitRisksViewController.h"
#import "IDSSMUnit.h"
#import "IDSSMCustomAnnotation.h"
#import "IDSSMBuildingEditTableViewController.h"
#import "IDSSMUnitTableViewController.h"
#import "IDSSMNormalUnitTableViewController.h"
#import "IDSSMComplexTableViewController.h"

@interface IDSSMListViewController () <UITableViewDataSource, UITableViewDelegate,getUnitTypes,UIScrollViewDelegate>
@property (nonatomic, copy)NSString *typeName;
@property (nonatomic, strong)NSMutableArray *typeArray;
@property (nonatomic ,assign)NSInteger headerSection;
@property (nonatomic, strong)IDSSMUnitTableViewCell *tempCell;
@property (nonatomic, strong)IDSSMUnitTableViewCell *vi;
@end

@implementation IDSSMListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    IDSSMTabBarViewController *viewController = (IDSSMTabBarViewController *)self.tabBarController;
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray arrayWithArray:viewController.cellsArray];
//    }
    self.typeArray = [NSMutableArray array];
    self.tempCell = nil;
    self.view.backgroundColor = [UIColor lightGrayColor];
    NetworkManager *manager = [[NetworkManager alloc]init];
    manager.typesDelegate = self;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userSn = [userdefault objectForKey:@"userSn"];
    float latitude = [[userdefault objectForKey:@"latitude"] floatValue];
    float longitude = [[userdefault objectForKey:@"longitude"] floatValue];
    
    //[manager getCellsInMap:CLLocationCoordinate2DMake(latitude, longitude) userSn:userSn];
   // [manager getAllUnitTypes:userSn];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(gotoNewEditing)];
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"list_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"list_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.37, 0, -5.37, 0);
    
    self.tabBarController.selectedIndex = 1;
}
- (void)viewWillAppear:(BOOL)animated {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = @"建筑列表";
    label.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = label;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    IDSSMCell *cella = [self.dataArray objectAtIndex:section];
    return cella.units.count;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    IDSSMUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IDSSMUnitTableViewCell" owner:self options:nil] lastObject];
    }
    if (self.indexPath == indexPath&&!self.tempCell.headerShow)
    {
        for (UIView *view in cell.contentView.subviews)
        {
            
            if(view.tag == 1000 ||view.tag == 1005)
                view.hidden = YES;
            else
            { view.hidden = NO;
                view.layer.borderColor = [UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1].CGColor;
            }
        }
      //  cell.goImageView.hidden = YES;
        cell.backgroundColor = [UIColor colorWithRed:113 green:185 blue:223 alpha:1];
        cell.selected = YES;
    }
    else{
    //    cell.goImageView.hidden = NO;
       }
    //    cell.backgroundColor = [UIColor whiteColor];
    
    IDSSMCell *cella = [_dataArray objectAtIndex:indexPath.section];
    IDSSMUnit *unit = [cella.units objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.backDelegate = self;
    cell.briefLabel.text = unit.name;
    cell.dwdzLabel.text = unit.addr;
    cell.proirityImageView.image = [UIImage imageNamed:unit.imageString];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
   
}
- (void)gotoNewEditing {
    
    
   
}



#pragma mark - cell 三个按钮的代理
- (void)backToMap:(UIView *)view
{
   // self.indexPath = [NSIndexPath indexPathForRow:0 inSection:cell.headerSection];
    IDSSMUnitTableViewCell *cellView = (IDSSMUnitTableViewCell *)view.superview.superview;
    IDSSMMapViewController *mapViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    IDSSMCell *cell = [self.dataArray objectAtIndex:self.indexPath.section];
    [mapViewController.mapView setCenterCoordinate:CLLocationCoordinate2DMake(cell.lat.floatValue, cell.lng.floatValue) animated:YES];
    for (IDSSMCustomAnnotation *annotation in mapViewController.mapView.annotations)
    {
        if(annotation.cell == cell)
        {
            [mapViewController.mapView selectAnnotation:annotation animated:YES];
        }
    }
    self.tabBarController.selectedIndex = 0;
}
- (void)changeUnit
{
    IDSSMCell *cell = [self.dataArray objectAtIndex:self.indexPath.section];
    IDSSMUnit *unit = [[IDSSMUnit alloc]init];
    if(cell.units.count!=0)
    {
     unit = [cell.units objectAtIndex:self.indexPath.row];
    }
    if (self.tempCell.headerShow)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
        IDSSMBuildingEditTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Building"];
        controller.lat = cell.lat.doubleValue;
        controller.lng = cell.lng.doubleValue;
        controller.cellId = [cell.cellId integerValue];
        controller.isAddOrUpdate = NO;
        controller.name = cell.name;
        controller.ssxq = cell.districtId;
        controller.addr = cell.addr;
        controller.jzgd = cell.jzgd;
        controller.rzdws = cell.rzdws;
        controller.jzcsds = cell.jzcsds;
        controller.jzcsdxA = cell.jzcsdx;
        controller.jzmjdsA = cell.jzmjds;
        controller.jzmjdxA = cell.jzmjdx;
        controller.type = cell.type;
        controller.jgsj = cell.jgsj;
        controller.risks = [NSMutableArray array];
        controller.risks = cell.risks;
      
        controller.gclx = cell.gclx;
        controller.cqqk = cell.cqqk;
        controller.cqdw = cell.cqdw;
        controller.cqdwlxr = cell.cqdwlxr;
        controller.cqdwlxdhA = cell.cqdwlxdh;
        controller.xfspsx = cell.xfspsx;
        controller.xfkzs = cell.xfkzs;
        controller.hzzdbjxt = cell.hzzdbjxt;
        controller.snxhsxt = cell.snxhsxt;
        controller.zdpsmhxt = cell.zdpsmhxt;
        controller.mhq = cell.mhq;
        controller.qtxfssqc = cell.qtxfssqc;
        controller.sfczzdhzyh = cell.sfczzdhzyh;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    else
    {
       NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"typesArray"];
        long groupId = 0 ;
        for (NSDictionary *dic in array)
        {
            if (unit.type == [dic[@"id"] longValue])
            {   groupId = [dic[@"group"] longValue];
                NSLog(@"type:%ld--%@",unit.type,dic[@"name"]);
            }
        }
        if (groupId ==11||groupId==12||groupId==13||groupId==14)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
            IDSSMUnitTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"unit"];
            controller.isAddOrUpdate = NO;
            controller.unitId = unit.ID;
            controller.dwmc = unit.name;
            controller.dwdz = unit.addr;
            controller.buildingName = cell.name;
            controller.fzr = unit.fzr;
            controller.ygs = unit.ygzss;
            controller.lxdh = unit.lxdh;
            controller.dwlx = unit.type;
            controller.sfsyzddw = unit.sfsyzddw;
            controller.jzmj = unit.jzmj;
            controller.sflsqjy = unit.sflsqjycs;
            controller.sfjcwxxfz = unit.sfjcwxxfz;
            controller.cfyhqk = unit.yhqkcf;
            controller.xfspsx = unit.xfspsx;
            controller.hyzl = unit.yhqkhyzl;
            controller.xfkzs = unit.xfkzs;
            controller.hzzdbj = unit.hzzdbjxt;
            controller.snxhs = unit.snxhsxt;
            controller.zdpsmh = unit.zdpsmhxt;
            controller.mhq = unit.mhq;
            controller.qtxsss = unit.qtxfssqc;
            controller.risks = [NSMutableArray array];
            controller.risks = unit.risks;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if(groupId ==15)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
            IDSSMComplexTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"zhongheti"];
            controller.subUnits = [NSMutableArray array];
        
            controller.subUnits = unit.subUnits;
            controller.isAddOrUpdate = NO;
            controller.unitId = unit.ID;
            controller.buildingName = cell.name;
            controller.buildId = unit.cellId;
            controller.zhtmc = unit.name;
            controller.zgsmc = unit.zgsmc;
            controller.addr = unit.addr;
            controller.wyglmc = unit.wyglgsmc;
            controller.xfspqk = unit.xfspsx;
            controller.sflsqjy = unit.sflsqjycs;
            controller.sfjcwxxf = unit.sfjcwxxfz;
            controller.xfkzs = unit.xfkzs;
            controller.hzzzbj = unit.hzzdbjxt;
            controller.snxhs = unit.snxhsxt;
            controller.zdpsmh = unit.zdpsmhxt;
            controller.mhq = unit.mhq;
            controller.qtxfssqc = unit.qtxfssqc;
            controller.risks = [NSMutableArray array];
            controller.risks = unit.risks;
            
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Building" bundle:nil];
            IDSSMNormalUnitTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"yibancangs"];
            controller.unitId = unit.ID;
            controller.buildingName = cell.name;
            controller.address = unit.addr;
            controller.csmc = unit.name;
            controller.zzxqhs = unit.zzxqhs;
            controller.jzmj = unit.jzmj;
            controller.ygzss = unit.ygzss;
            controller.fzr = unit.fzr;
            controller.lxdh = unit.lxdh;
            controller.cslx = unit.type;
            controller.yhqkcf = unit.yhqkcf;
            controller.hyzl = unit.yhqkhyzl;
            controller.xfspsx = unit.xfspsx;
            controller.sfczshy = unit.sfczshy;
            controller.sfwgzr = unit.sfwgzr;
            controller.sffhssyq = unit.sffhssyq;
            controller.sfwgcfyhq = unit.sfwgcfyhq;
            controller.sfpbxxqc = unit.sfpbxfqc;
            controller.sfjgxcpx = unit.sfjgxcpxjy;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }


}

- (void)checkRisks
{
    IDSSMCell *cell = [self.dataArray objectAtIndex:self.indexPath.section];
    IDSSMUnit *unit = [[IDSSMUnit alloc]init];
    if(cell.units.count!=0)
      unit = [cell.units objectAtIndex:self.indexPath.row];
     IDSSMUnitRisksViewController *riskViewController = [[IDSSMUnitRisksViewController alloc]init];
    if (self.tempCell.headerShow)
    {
        riskViewController.risks = cell.risks;
        riskViewController.cellOrUnit = YES;
        riskViewController.cellId = [cell.cellId integerValue];
        [self.navigationController pushViewController:riskViewController animated:YES];
        return;
    }
    riskViewController.cellOrUnit = NO;
    riskViewController.unitId = unit.ID;
    riskViewController.risks = unit.risks;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:riskViewController animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
   // self.backIndex = -1;
    IDSSMUnitTableViewCell *cell = (IDSSMUnitTableViewCell *) [self.tableView headerViewForSection:indexPath.section];
  
    self.tempCell.headerShow = NO;
    NSLog(@"%d",cell.headerShow);
    [tableView reloadData];
  
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    IDSSMUnitTableViewCell *view = [[[NSBundle mainBundle]loadNibNamed:@"IDSSMUnitTableViewCell" owner:self options:nil] firstObject];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerClick:)];
    [view addGestureRecognizer:tap];
    view.headerSection = section;
    if(self.backIndex == section)
    {
       // self.vi = view;
      //  [self headerClick:tap];
        view.headerShow = YES;
       self.backIndex = -1;
        view.headerSection = section;
        self.tempCell = view;
        
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    }
    IDSSMCell *cell = [self.dataArray objectAtIndex:section];
    for (int i = 1 ; i<4 ;i++)
    {
        UIView *button = [view viewWithTag:1000+i];
        button.layer.borderColor = [UIColor colorWithRed:45/255.0 green:116/255.0 blue:185/255.0 alpha:1].CGColor;
    }

    view.briefLabel.text = cell.name;
        if (view.headerShow)
        {
            UIView *vi = [view viewWithTag:1000];
            vi.hidden = YES;
            UIView *vii = [view viewWithTag:1005];
            vii.hidden = YES;
            for (int i = 1 ; i<4 ;i++)
            {
                UIView *button = [view viewWithTag:1000+i];
                button.hidden = NO;
            }
        }
        else
        {
            UIView *vi = [view viewWithTag:1000];
            vi.hidden = NO;
            UIView *vii = [view viewWithTag:1005];
            vii.hidden = NO;
            for (int i = 1 ; i<4 ;i++)
            {
                UIView *button = [view viewWithTag:1000+i];
                button.hidden = YES;
            }
        }
    
        
    view.proirityImageView.image = [UIImage imageNamed:@"building.jpg"];
    view.backDelegate = self;
    view.dwdzLabel.text = cell.addr;
    view.backgroundColor = [UIColor lightTextColor];
    
    
    
  
    
  //  self.indexPath = [NSIndexPath indexPathForRow:0 inSection:view.headerSection];

    return view;
}
- (void)headerClick:(UITapGestureRecognizer *)tap
{
  //  self.backIndex = -1;
    self.tempCell.headerShow = NO;
    for (int i = 1; i<4 ; i++)
    {
        UIView *button = [self.tempCell viewWithTag:1000+i];
        UIView *dwdz = [self.tempCell viewWithTag:1000];
        UIView *go = [self.tempCell viewWithTag:1005];
        if(self.tempCell.headerShow)
        {
            button.hidden = NO;
            dwdz.hidden = YES;
            go.hidden = YES;
        }
        else
        {
            button.hidden = YES;
            dwdz.hidden = NO;
            go.hidden = NO;

        }
    }

    
    IDSSMUnitTableViewCell *trueCell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    trueCell.dwdzLabel.hidden = NO;
    trueCell.goImageView.hidden = NO;
    for (int i = 1 ;i<4 ; i++)
    {
        UIView *button = [trueCell.contentView viewWithTag:1000+i];
        button.hidden = YES;
    }
    IDSSMUnitTableViewCell *cell = [[IDSSMUnitTableViewCell alloc]init];
    
    cell = (IDSSMUnitTableViewCell *)tap.view;
    
   
    cell.headerShow = !cell.headerShow;
    for (int i = 1; i<4 ; i++)
    {
        UIView *button = [cell viewWithTag:1000+i];
        UIView *dwdz = [cell viewWithTag:1000];
        UIView *vii = [cell viewWithTag:1005];

    if(cell.headerShow)
    {
        button.hidden = NO;
        dwdz.hidden = YES;
        vii.hidden = YES;
    }
    else
    {
        button.hidden = YES;
        dwdz.hidden = NO;
        vii.hidden = NO;
    }
    }
    self.tempCell = cell;

    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:cell.headerSection];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
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
