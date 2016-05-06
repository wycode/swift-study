//
//  IDSSMUnitTableViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMUnitTableViewController.h"
#import "BuildingNameTableViewController.h"
#import "JSONKit.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"
#include "IDSSMRisk.h"
@interface IDSSMUnitTableViewController ()<nameOfBuilding,UIScrollViewDelegate,reloadView,MBProgressHUDDelegate>
@property (nonatomic, strong)NSMutableArray *mutaRisks;
@end

@implementation IDSSMUnitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!self.buildingName)
    self.buildingName = @"所在建筑名称(与表1相对应)";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getNameListOfBuilding:)];
    [self.buildL addGestureRecognizer:tap];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"单位信息";
    self.sfzzzdyh = 1;
    label.frame = CGRectMake(0, 0, 320, 40);
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
}
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 上传完成回调

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

- (IBAction)summitClick:(id)sender {
    NSArray *nameArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"buildAr"];
    for (NSDictionary *dic in nameArray)
    {
        if ([dic[@"name"] isEqualToString:self.buildL.text])
            self.buildId = [dic[@"id"]  integerValue];
    }
    for (UIButton *button in self.distanceContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.jlcg = button.tag - 1000;
    }
    for (UIButton *button in self.dwlxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.dwlx = button.tag ;
    }
    for (UIButton *button in self.sfsyzddwContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfsyzddw = button.tag - 1000;
    }
    for (UIButton *button in self.sflsqjyContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sflsqjy = button.tag - 1000;
    }
    for (UIButton *button in self.sfjcwxxfzContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfjcwxxfz = button.tag - 1000;
    }
    for (UIButton *button in self.cfyhqkContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.cfyhqk = button.tag - 1000;
    }
    for (UIButton *button in self.xfspsxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.xfspsx = button.tag - 1000;
    }
    self.hyzl = 0;

    for (UIButton *button in self.hyzlContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.hyzl = self.hyzl | (button.tag - 1000);
    }
    for (UIButton *button in self.xfkzsContenView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.xfkzs = button.tag - 1000;
    }
    for (UIButton *button in self.hzzdbjContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.hzzdbj = button.tag - 1000;
    }
    for (UIButton *button in self.snxhsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.snxhs = button.tag - 1000;
    }
    for (UIButton *button in self.zdpsmhContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.zdpsmh = button.tag - 1000;
    }
    for (UIButton *button in self.mhqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.mhq = button.tag - 1000;
    }
    for (UIButton *button in self.qtxsssContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.qtxsss = button.tag - 1000;
    }
    for (UIButton *button in self.sfzzzdyhContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfzzzdyh = button.tag - 1000;
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
    if(self.sfzzzdyh != 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(self.sfzzzdyh),@"priority",@(1),@"state",self.yhqkT.text,@"detail",nil];
        [self.mutaRisks addObject:dict];
    }
    

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
    hud.minSize = CGSizeMake(150.f, 100.f);
    hud.minShowTime = 1.f;

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.dwmcT.text,@"name",self.dwdzT.text,@"addr",@(self.buildId),@"cellId",self.fzrT.text,@"fzr",@([self.ygsT.text integerValue]),@"ygzss",self.lxdhT.text,@"lxdh",@(self.dwlx),@"type",@(self.sfsyzddw),@"sfsyzddw",@([self.jzmjT.text floatValue]),@"jzmj",@(self.sflsqjy),@"sflsqjycs",@(self.sfjcwxxfz),@"sfjcwxxfz",@(self.cfyhqk),@"yhqkcf",@(self.xfspsx),@"xfspsx",@(self.hyzl),@"yhqkhyzl",@(self.xfkzs),@"xfkzs",@(self.hzzdbj),@"hzzdbjxt",@(self.snxhs),@"snxhsxt",@(self.zdpsmh),@"zdpsmhxt",@(self.mhq),@"mhq",@(self.qtxsss),@"qtxfssqc",self.mutaRisks,@"risks", nil];
    NSString *string = [dictionary JSONString];
    if (self.isAddOrUpdate)
    {
        NetworkManager *manager = [[NetworkManager alloc]init];
        manager.reloadDelegate = self;
        [manager addUnit:string userSn:[[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"]];
    }
    else
    {
        [dictionary setObject:@(self.unitId) forKey:@"id"];
        NetworkManager *manager = [[NetworkManager alloc]init];
        manager.reloadDelegate = self;
        [manager updateUnit:[dictionary JSONString] userSn:[[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"]];
    }
    
    
}

- (void)summitEditing
{
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)getNameListOfBuilding:(UITapGestureRecognizer *)tap
{
    self.dwmc = self.dwmcT.text;
    self.dwdz = self.dwdzT.text;
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
    self.dwmcT.text = self.dwmc;
    self.dwdzT.text = self.dwdz;
    self.buildL.text = self.buildingName;
    self.fzrT.text = self.fzr;
    self.ygsT.text = [NSString stringWithFormat:@"%ld",self.ygs];
    self.lxdhT.text = self.lxdh;
    for (UIButton *button in self.dwlxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.dwlx)
            button.selected = YES;
    }
    for (UIButton *button in self.sfsyzddwContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sfsyzddw+1000)
            button.selected = YES;
    }
    self.jzmjT.text =[NSString stringWithFormat:@"%.2f",self.jzmj] ;
    for (UIButton *button in self.sflsqjyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sflsqjy+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfjcwxxfzContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sfjcwxxfz+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.cfyhqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.cfyhqk+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.xfspsxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.xfspsx+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.hyzlContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]])
        {
            NSInteger k = self.hyzl&(button.tag -1000);
            if(k != 0)
                button.selected = YES;
        }
    }
    for (UIButton *button in self.xfkzsContenView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.xfkzs+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.hzzdbjContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.hzzdbj+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.snxhsContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.snxhs+1000)
            button.selected = YES;
    }

    for (UIButton *button in self.zdpsmhContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.zdpsmh+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.mhqContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.mhq+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.qtxsssContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.qtxsss+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfzzzdyhContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == self.sfzzzdyh+1000)
            button.selected = YES;
    }


}
- (IBAction)hyzlClick:(UIButton *)sender {
    sender.selected = !sender.selected;
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
