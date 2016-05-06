//
//  IDSSMComplexTableViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMComplexTableViewController.h"
#import "BuildingNameTableViewController.h"
#import "NetworkManager.h"
#import "JSONKit.h"
#import "IDSSMSubUnitsViewController.h"
#import "IDSSMSubUnit.h"
#import "MBProgressHUD.h"
#import "IDSSMRisk.h"
@interface IDSSMComplexTableViewController ()<nameOfBuilding,UIScrollViewDelegate,getSubUnits,reloadView,MBProgressHUDDelegate>
@property (nonatomic, strong)NSMutableArray *mutaRisks;
@end

@implementation IDSSMComplexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if(!_subUnits)
    {
        _subUnits = [NSMutableArray array];
    }
    if(!self.buildingName)
    self.buildingName = @"所在建筑名称(与表1相对应)";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getNameListOfBuilding:)];
    [self.buildingL addGestureRecognizer:tap];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"综合体基本情况";
    label.frame = CGRectMake(0, 0, 320, 40);
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    self.sfczzdyh = 1;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
}
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)reloadView:(NSDictionary *)dictionary
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    hud.customView = imageView;
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = NSLocalizedString(@"完成", @"ok");
    [hud hideAnimated:YES afterDelay:1.f];
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (IBAction)summitClick:(id)sender {
    NSArray *nameArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"buildAr"];
    for (NSDictionary *dic in nameArray)
    {
        if ([dic[@"name"] isEqualToString:self.buildingL.text])
            self.buildId = [dic[@"id"]  integerValue];
    }
    for (UIButton *button in self.xfspqkContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.xfspqk = button.tag-1000;
        }
    }
    for (UIButton *button in self.sflsqjyContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.sflsqjy = button.tag-1000;
        }
    }
    for (UIButton *button in self.sfjcwxxfContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.sfjcwxxf = button.tag-1000;
        }
    }
    for (UIButton *button in self.xfkzsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.xfkzs = button.tag-1000;
        }
    }
    for (UIButton *button in self.hzzdbjContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.hzzzbj = button.tag-1000;
        }
    }
    for (UIButton *button in self.snxhsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.snxhs = button.tag-1000;
        }
    }
    for (UIButton *button in self.zdpsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.zdpsmh = button.tag-1000;
        }
    }
    for (UIButton *button in self.mhqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.mhq = button.tag-1000;
        }
    }
    for (UIButton *button in self.qtxfssContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.qtxfssqc = button.tag-1000;
        }
    }
    for(UIButton *button in self.sfczzdyhContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected==YES)
        {
            self.sfczzdyh = button.tag-1000;
        }
    }
    self.mutaRisks = [NSMutableArray array];
    if(self.risks.count!=0)
    {
        for(IDSSMRisk *risk in self.risks)
        {
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(risk.ID),@"id",@(risk.state),@"state",@(risk.priority),@"priority",risk.brief,@"brief",risk.detail,@"detail",@(risk.unitId),@"unitId", nil];
//            
//            [self.mutaRisks addObject:dic];
        }
    }
    if(self.sfczzdyh != 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(self.sfczzdyh),@"priority",@(1),@"state",self.czyhqkT.text,@"detail",nil];
        [self.mutaRisks addObject:dict];
    }

    
    self.type = 1500;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(self.buildId),@"cellId",self.addrT.text,@"addr"
                                       ,self.zhtmcT.text,@"name"
                                       ,@(self.type),@"type"
                                       ,self.zgsmcT.text,@"zgsmc"
                                       ,self.wyglmcT.text,@"wyglgsmc"
                                       ,@(self.xfspqk),@"xfspsx"
                                       ,@(self.sflsqjy),@"sflsqjycs"
                                       ,@(self.sfjcwxxf),@"sfjcwxxfz"
                                       ,@(self.xfkzs),@"xfkzs",
                                       @(self.hzzzbj),@"hzzdbjxt",
                                       @(self.snxhs),@"snxhsxt",
                                       @(self.zdpsmh),@"zdpsmhxt",
                                       @(self.mhq),@"mhq",
                                       self.mutaRisks,@"risks",
                                       @(self.qtxfssqc),@"qtxfssqc",nil];
    NSString *userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
    NetworkManager *manager = [[NetworkManager alloc]init];
    manager.reloadDelegate = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
    hud.minSize = CGSizeMake(150.f, 100.f);
    hud.minShowTime = 1.f;

    NSMutableArray *array = [NSMutableArray array];
    for (IDSSMSubUnit *subUnit in self.subUnits)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:subUnit.name,@"name",subUnit.addr,@"addr",subUnit.fzr,@"fzr",subUnit.lxdh,@"lxdh",@(subUnit.type),@"type",@(subUnit.spqk),@"spqk",@(subUnit.yhqkcf),@"yhqkcf",@(subUnit.yhqkhyzl),@"yhqkhyzl",@(subUnit.ygsfzwsgnl),@"ygsfzwsgnl", nil];
        [array addObject:dic];
    }
    [dictionary setObject:array forKey:@"subUnits"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
  

 //   NSString *str = [dictionary JSONString];
    if(self.isAddOrUpdate)
    {
        [manager addUnit:str  userSn:userSn];
    }
    else
    {
        
        [dictionary setObject:@(self.unitId) forKey:@"id"];
        NSData *adata = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *stru = [[NSString alloc]initWithData:adata encoding:NSUTF8StringEncoding];
        [manager updateUnit:stru userSn:userSn];
    }

}
- (void)summitEditing
{
}
- (void)getNameListOfBuilding:(UITapGestureRecognizer *)tap
{
   
    self.zhtmc = self.zhtmcT.text;
    self.zgsmc = self.zgsmcT.text;
    self.wyglmc = self.wyglmcT.text;
    self.addr = self.addrT.text;
    BuildingNameTableViewController *controller = [[BuildingNameTableViewController alloc]init];
    controller.delegate = self;
    NSArray *ar = [[NSUserDefaults standardUserDefaults] objectForKey:@"buildAr"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in ar)
    {
        if(dic[@"name"])
            [arr addObject:dic[@"name"]];
    }
    controller.listBuildingNameArr = arr;
    [self.navigationController pushViewController: controller animated:YES];
}
- (void)setLabelBuilding:(NSString *)name
{
    NSLog(@"name ___%@",name);
    self.buildingName = name;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.buildingL.text = self.buildingName;
    self.zhtmcT.text = self.zhtmc;
    self.zgsmcT.text = self.zgsmc;
    self.wyglmcT.text = self.wyglmc;
    self.addrT.text = self.addr;
    for (UIButton *button in self.xfspqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.xfspqk+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sflsqjyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sflsqjy+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfjcwxxfContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sfjcwxxf+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.xfkzsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.xfkzs+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.hzzdbjContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.hzzzbj+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.snxhsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.snxhs+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.zdpsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.zdpsmh+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.mhqContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.mhq+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.qtxfssContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.qtxfssqc+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfczzdyhContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sfczzdyh+1000)
            button.selected = YES;
    }
}
- (IBAction)toInside:(UIButton *)sender {

    self.buildingName = self.buildingL.text;
    self.zhtmc = self.zhtmcT.text;
    self.zgsmc = self.zgsmcT.text;
    self.wyglmc = self.wyglmcT.text;
    self.addr = self.addrT.text;
    for (UIButton *button in self.xfspqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.xfspqk = button.tag - 1000;
    }
    for (UIButton *button in self.sflsqjyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sflsqjy = button.tag - 1000;
    }
    
    for (UIButton *button in self.sfjcwxxfContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfjcwxxf = button.tag - 1000;
    }
    for (UIButton *button in self.hzzdbjContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.hzzzbj = button.tag - 1000;
    }
    for (UIButton *button in self.snxhsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.snxhs = button.tag - 1000;
    }
    for (UIButton *button in self.xfspqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.xfspqk = button.tag - 1000;
    }
    for (UIButton *button in self.zdpsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.zdpsmh = button.tag - 1000;
    }
    
    for (UIButton *button in self.mhqContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.mhq = button.tag - 1000;
    }
    for (UIButton *button in self.qtxfssContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.qtxfssqc = button.tag - 1000;
    }
    for (UIButton *button in self.sfczzdyhContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfczzdyh = button.tag - 1000;
    }
    self.czyhqk = self.czyhqkT.text;
    IDSSMSubUnitsViewController *controller = [[IDSSMSubUnitsViewController alloc]init];
    controller.delegate = self;
    controller.unitIsAddOrUpdate = self.isAddOrUpdate;
    controller.subUnits = self.subUnits;
    controller.unitId = self.unitId;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)setSubUnits:(NSMutableArray *)subUnits
{
    if(!_subUnits)
    {
        _subUnits = [NSMutableArray array];
    }
    _subUnits.array = subUnits;
}

- (IBAction)buttonClick:(UIButton *)sender {
    for (UIButton *button in sender.superview.subviews)
    {
        if ([button isKindOfClass:sender.class]&&sender!=button)
            button.selected = NO;
    }
    
    BOOL show = sender.selected;
    sender.selected = !show;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
