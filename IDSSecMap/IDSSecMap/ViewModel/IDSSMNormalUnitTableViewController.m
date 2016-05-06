//
//  IDSSMNormalUnitTableViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/21.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMNormalUnitTableViewController.h"
#import "IDSSMLocationViewController.h"
#import "BuildingNameTableViewController.h"
#import "JSONKit.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"
@interface IDSSMNormalUnitTableViewController ()<UITextFieldDelegate,UIScrollViewDelegate,nameOfBuilding,MBProgressHUDDelegate,reloadView>

@end

@implementation IDSSMNormalUnitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.addressTextfield resignFirstResponder];
    self.addressTextfield.text = self.address;
    self.addressTextfield.delegate = self;
   // self.buildingL.text = self.buildingName;
    if (!self.buildingName)
    self.buildingName = @"所在建筑名称(与表1相对应)";
    if(!self.csmc)
        self.csmc = @"";
    if(!self.fzr)
        self.fzr = @"";
    if(!self.lxdh)
        self.lxdh = @"";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getNameListOfBuilding:)];
    [self.buildingL addGestureRecognizer:tap];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"场所基本情况";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 320, 40);
    self.tableView.tableHeaderView = label;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
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

- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)summitClick:(id)sender {
    NSArray *nameArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"buildAr"];
    for (NSDictionary *dic in nameArray)
    {
        if ([dic[@"name"] isEqualToString:self.buildingL.text])
            self.buildId = [dic[@"id"]  integerValue];
    }
    for (UIButton *button in self.jlcgContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.jlcg = button.tag - 1000;
    }
    for (UIButton *button in self.cslxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.cslx = button.tag;
    }
    for (UIButton *button in self.yhqkcfContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.yhqkcf = button.tag - 1000;
    }
    
    self.hyzl = 0;
    for (UIButton *button in self.hyzlContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.hyzl = self.hyzl | (button.tag - 1000);
    }
    for (UIButton *button in self.xfspsxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.xfspsx = button.tag - 1000;
    }
    for (UIButton *button in self.sfczshyContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfczshy = button.tag - 1000;
    }
    for (UIButton *button in self.sfwgzrContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfwgzr = button.tag - 1000;
    }
    
    for (UIButton *button in self.sffhssyqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sffhssyq = button.tag - 1000;
    }
    for (UIButton *button in self.sfwgcfyhqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfwgcfyhq = button.tag - 1000;
    }
    for (UIButton *button in self.sfpbxxqcContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfpbxxqc = button.tag - 1000;
    }
    for (UIButton *button in self.sfjgxcpxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfjgxcpx = button.tag - 1000;
    }
    self.csmc = self.csmcTextfield.text;
    self.jzmj = [self.jzmjTextfield.text floatValue];
    self.address = self.addressTextfield.text ;
    
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.addressTextfield.text,@"addr",
                                       @(self.buildId),@"cellId",
                                       self.csmcTextfield.text,@"name",
                                       @([self.zzxqhsTextfield.text integerValue]),@"zzxqhs",
                                       @([self.jzmjTextfield.text floatValue]),@"jzmj",
                                       @([self.ygzssT.text integerValue]),@"ygzss",
                                       self.fzrT.text,@"fzr",
                                       self.lxdhT.text,@"lxdh",
                                       @(self.cslx),@"type",
                                       @(self.yhqkcf),@"yhqkcf",
                                       @(self.hyzl),@"yhqkhyzl",
                                       @(self.xfspsx),@"xfspsx",
                                       @(self.sfczshy),@"sfczshy",
                                       @(self.sfwgzr),@"sfwgzr",
                                       @(self.sffhssyq),@"sffhssyq",
                                       @(self.sfwgcfyhq),@"sfwgcfyhq",
                                       @(self.sfpbxxqc),@"sfpbxfqc",
                                       @(self.sfjgxcpx),@"sfjgxcpxjy", nil];
    NSString *string = [dictionary JSONString];
    NSLog(@"==%@===",string);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
    hud.minSize = CGSizeMake(150.f, 100.f);
    hud.minShowTime = 1.f;

    NetworkManager *manager = [[NetworkManager alloc]init];
    manager.reloadDelegate = self;
    if (self.isAddOrUpdate)
    {
        [manager addUnit:string userSn:[[NSUserDefaults standardUserDefaults] objectForKey:@"userSn"]];
    }
    else
    {
        [dictionary setObject:@(self.unitId) forKey:@"id"];
        [manager updateUnit:[dictionary JSONString] userSn:[[NSUserDefaults standardUserDefaults] objectForKey:@"userSn"]];
    }

}
- (void)summitEditing
{
    
}
- (void)getNameListOfBuilding:(UITapGestureRecognizer *)tap
{
    self.csmc = self.csmcTextfield.text;
    self.jzmj = [self.jzmjTextfield.text floatValue];
    self.address = self.addressTextfield.text ;
    
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
    self.addressTextfield.text = self.address;
    self.csmcTextfield.text = self.csmc;
    self.zzxqhsTextfield.text = [NSString stringWithFormat:@"%ld",self.zzxqhs];
    self.jzmjTextfield.text = [NSString stringWithFormat:@"%.3f",self.jzmj];
    self.ygzssT.text = [NSString stringWithFormat:@"%ld",self.ygzss];
    self.fzrT.text = self.fzr;
    self.lxdhT.text = self.lxdh;
    for (UIButton *button in self.cslxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.cslx == button.tag)
        button.selected = YES;
    }
    for (UIButton *button in self.yhqkcfContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.yhqkcf == button.tag-1000)
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
    for (UIButton *button in self.xfspsxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.xfspsx == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfczshyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sfczshy == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfwgzrContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sfwgzr == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sffhssyqContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sffhssyq == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfwgcfyhqContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sfwgcfyhq == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfpbxxqcContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sfpbxxqc == button.tag-1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfjgxcpxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&self.sfjgxcpx == button.tag-1000)
          button.selected = YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)getAddress:(NSString *)address latitude:(double)latitude longitude:(double)longitude
{
    NSLog(@"%@",address);
    if (_address)
    {
        _address = [[NSString alloc]init];
    }
    _address = address;
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

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
