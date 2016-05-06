//
//  SubUnitTableViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/24.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "SubUnitTableViewController.h"
#import "NetworkManager.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
@interface SubUnitTableViewController ()<reloadView,MBProgressHUDDelegate,UIScrollViewDelegate>

@end

@implementation SubUnitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!_subUnit)
    {
        _subUnit = [[IDSSMSubUnit alloc]init];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.hyzl = self.subUnit.yhqkhyzl;
    self.zycsmcT.text = self.subUnit.name;
    self.dwdzT.text = self.subUnit.addr;
    self.fzrT.text = self.subUnit.fzr;
    self.lxdhT.text = self.subUnit.lxdh;
    for(UIButton *button in self.cslxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == 1000+self.subUnit.type)
        {
            button.selected = YES;
        }
    }
    for(UIButton *button in self.xfspsxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == 1000+self.subUnit.spqk)
        {
            button.selected = YES;
        }
    }
    for(UIButton *button in self.cfyhqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == 1000+self.subUnit.yhqkcf)
        {
            button.selected = YES;
        }
    }
    for(UIButton *button in self.hyzlContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]])
        {
            NSInteger k = self.hyzl&(button.tag -1000);
            if(k != 0)
                button.selected = YES;
        }
    }
    for(UIButton *button in self.ygsfzwsgyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.tag == 1000+self.subUnit.ygsfzwsgnl)
        {
            button.selected = YES;
        }
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    for (UIButton *button in self.hyzlContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]])
        {
            NSInteger k = self.hyzl&(button.tag -1000);
            if(k != 0)
                button.selected = YES;
        }
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
    if(self.isAddOrUpdate)
        [self.delegate getNewSubUnit:self.subUnit num:0 row:1];
    else
        [self.delegate replaceSubUnit:self.subUnit row:self.updateRow];

}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)summitButton:(UIButton *)sender {
    
    for (UIButton *button in self.cslxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected == YES)
        {
            self.cslx = button.tag - 1000;
        }
    }
    for (UIButton *button in self.xfspsxContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected == YES)
        {
            self.xfspsx = button.tag - 1000;
        }
    }
    for (UIButton *button in self.cfyhqkContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected == YES)
        {
            self.cfyhqk = button.tag - 1000;
        }
    }
    self.hyzl = 0;

    for (UIButton *button in self.hyzlContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected == YES)
        {
            self.hyzl = self.hyzl | ( button.tag - 1000);
        }
    }
    for (UIButton *button in self.ygsfzwsgyContentView.subviews)
    {
        if([button isKindOfClass:[UIButton class]]&&button.selected == YES)
        {
            self.ygsfzwsgy = button.tag - 1000;
        }
    }
  
    self.subUnit.unitId = (int)self.unitId;
    self.subUnit.name = self.zycsmcT.text;
    self.subUnit.addr = self.dwdzT.text;
    self.subUnit.type = (int)self.cslx;
    self.subUnit.fzr = self.fzrT.text;
    self.subUnit.lxdh = self.lxdhT.text;
    self.subUnit.spqk = (int)self.xfspsx;
    self.subUnit.yhqkcf = (int)self.cfyhqk;
    self.subUnit.yhqkhyzl = self.hyzl;
    self.subUnit.ygsfzwsgnl = (int)self.ygsfzwsgy;
    
    if(self.unitIsAddOrUpdate)
    {
        if(self.isAddOrUpdate)
        {[self.delegate getNewSubUnit:self.subUnit num:0 row:1];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {   [self.delegate replaceSubUnit:self.subUnit row:self.updateRow];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    else if (self.isAddOrUpdate)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.delegate = self;
        hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
        hud.minSize = CGSizeMake(150.f, 100.f);
        hud.minShowTime = 1.f;
        self.subUnit.unitId = (int)self.unitId;
        self.subUnit.name = self.zycsmcT.text;
        self.subUnit.addr = self.dwdzT.text;
        self.subUnit.type = (int)self.cslx;
        self.subUnit.fzr = self.fzrT.text;
        self.subUnit.lxdh = self.lxdhT.text;
        self.subUnit.spqk = (int)self.xfspsx;
        self.subUnit.yhqkcf = (int)self.cfyhqk;
        self.subUnit.yhqkhyzl = self.hyzl;
        self.subUnit.ygsfzwsgnl = (int)self.ygsfzwsgy;
        self.subUnit.czyhqk = self.czyhqkT.text;
       // [self.delegate getNewSubUnit:self.subUnit num:0 row:0];

        NetworkManager *manager = [[NetworkManager alloc]init];
        manager.reloadDelegate = self;
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(self.unitId), @"unitId",self.zycsmcT.text,@"name",self.dwdzT.text,@"addr",@(self.cslx),@"type",self.fzrT.text,@"fzr",self.lxdhT.text,@"lxdh",@(self.xfspsx),@"spqk",@(self.cfyhqk),@"yhqkcf",@(self.hyzl),@"yhqkhyzl",@(self.ygsfzwsgy),@"ygsfzwsgnl",nil];
        NSString *userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
        [manager addSubUnit:[dic JSONString] userSn:userSn];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.delegate = self;
        hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
        hud.minSize = CGSizeMake(150.f, 100.f);
        hud.minShowTime = 1.f;
        self.subUnit.unitId = (int)self.unitId;
        self.subUnit.name = self.zycsmcT.text;
        self.subUnit.addr = self.dwdzT.text;
        self.subUnit.type = (int)self.cslx;
        self.subUnit.fzr = self.fzrT.text;
        self.subUnit.lxdh = self.lxdhT.text;
        self.subUnit.spqk = (int)self.xfspsx;
        self.subUnit.yhqkcf = (int)self.cfyhqk;
        self.subUnit.yhqkhyzl = self.hyzl;
        self.subUnit.ygsfzwsgnl = (int)self.ygsfzwsgy;
        NetworkManager *manager = [[NetworkManager alloc]init];
        manager.reloadDelegate = self;
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(self.unitId), @"unitId",self.zycsmcT.text,@"name",self.dwdzT.text,@"addr",@(self.cslx),@"type",self.fzrT.text,@"fzr",self.lxdhT.text,@"lxdh",@(self.xfspsx),@"spqk",@(self.cfyhqk),@"yhqkcf",@(self.hyzl),@"yhqkhyzl",@(self.ygsfzwsgy),@"ygsfzwsgnl",@(self.subUnit.ID),@"id", nil];
        NSString *userSn = [[NSUserDefaults standardUserDefaults]objectForKey:@"userSn"];
        [manager updateSubUnit:[dic JSONString] userSn:userSn];
    }
   

   // [self.navigationController popViewControllerAnimated:YES];
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
