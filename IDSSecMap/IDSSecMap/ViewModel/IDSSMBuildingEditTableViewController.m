//
//  IDSSMBuildingEditTableViewController.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/20.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMBuildingEditTableViewController.h"
#import "NetworkManager.h"
#import "JSONKit.h"
#import "IDSSMRisk.h"
#import "IDSSMLocationViewController.h"
#import "MBProgressHUD.h"
@interface IDSSMBuildingEditTableViewController ()<UIScrollViewDelegate,UITextFieldDelegate,returnAddress,MBProgressHUDDelegate,reloadView,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, strong)NSMutableArray *orderArray;
@property (nonatomic, strong)NSMutableArray *mutaRisks;
@end

@implementation IDSSMBuildingEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   // self.tableView.delegate = self;
  //  self.tableView.dataSource = self;
   // self.indexPath = [[NSIndexPath alloc]init];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.text = @"建筑基本信息 ";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    self.sfczzdhzyh = 0;
   // self.buildingName.text = self.name;
    if (!self.addr )
    {self.addr = @"建筑地址(具体到路，号)";
    }
    if (!self.wydw)
    {
        self.wydw = @"";
    }
    self.buildingAddress.text = self.addr;
    self.tableView.tableHeaderView = label;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddressClick)];
    [self.buildingAddress addGestureRecognizer:tap];
    UITapGestureRecognizer *tapTime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTimeShow:)];
    [self.jgsjF addGestureRecognizer:tapTime];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    NSArray *districtsArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"districtsArray"];
    NSArray *districts = [[NSUserDefaults standardUserDefaults]objectForKey:@"districts"];
    NSMutableArray *dis = [NSMutableArray arrayWithArray:districts];
    self.orderArray = [NSMutableArray array];
    self.orderArray = [self orderByDistance:dis];
    for (UIView *button in self.ssxqContentView.subviews)
    {
        
        if (![districtsArray containsObject:@(button.tag-100)]&&button.tag!=0)
            button.hidden = YES;
       
    }
    if(self.ssxq==0)
    {
        self.ssxqL.text = @"选择辖区";

    }
    else
    {
        for(NSDictionary *dicc in districts)
        {
            if([dicc[@"id"] integerValue]== self.ssxq)
                self.ssxqL.text = dicc[@"name"];
        }
    }
    
    UITapGestureRecognizer *tapSS = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ssxqClick:)];
    [self.ssxqL addGestureRecognizer:tapSS];
    
}
- (NSArray *)orderByDistance:(NSMutableArray *)array
{
    
    float userLat = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userLat"] floatValue];
    float userLng = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userLng"] floatValue];
    CLLocation *user = [[CLLocation alloc]initWithLatitude:userLat longitude:userLng];
    
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *firstDic = obj1;
        NSDictionary *secondDic = obj2;
    
        CLLocation *firstLocation = [[CLLocation alloc]initWithLatitude:[firstDic[@"lat"] floatValue] longitude:[firstDic[@"lng"]floatValue]];
        CLLocationDistance distance1 = [firstLocation distanceFromLocation:user];
        CLLocation *secondLocation = [[CLLocation alloc]initWithLatitude:[secondDic[@"lat"] floatValue] longitude:[secondDic[@"lng"]floatValue]];
        CLLocationDistance distance2 = [secondLocation distanceFromLocation:user];
        
        
        if (distance1 < distance2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];

    return result;
//    for (int i = 0; i<array.count-1 ; i++)
//    {
//        NSDictionary *firstDic = [NSDictionary dictionaryWithDictionary:[array objectAtIndex:i]];
//        CLLocation *tempLocation = [[CLLocation alloc]initWithLatitude:[firstDic[@"lat"] floatValue] longitude:[firstDic[@"lng"] floatValue]];
//        for(int j=i+1 ; j<array.count ; j++)
//    {
//        NSDictionary *districtsDic = [NSDictionary dictionaryWithDictionary:[array objectAtIndex:j]];
//        CLLocation *anotherLocation = [[CLLocation alloc]initWithLatitude:[districtsDic[@"lat"] floatValue] longitude:[districtsDic[@"lng"] floatValue]];
//        if([anotherLocation distanceFromLocation:user]<[tempLocation distanceFromLocation:user])
//        {
//            NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[array objectAtIndex:i]];
//            [array replaceObjectAtIndex:i withObject:districtsDic];
//            [array replaceObjectAtIndex:j withObject:tempDic];
//            
//            
//        }
//    }
//        
//    }
//    for(int i = 0 ; i<array.count ; i++)
//    {
//        NSDictionary *dic = [array objectAtIndex:i];
//        CLLocation *n = [[CLLocation alloc]initWithLatitude:[dic[@"lat"] floatValue] longitude:[dic[@"lng"] floatValue]];
//        NSLog(@"----%f",[n distanceFromLocation:user]);
//    }
//    return array;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.orderArray count];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *name = [[self.orderArray objectAtIndex:row] objectForKey:@"name"];
    self.ssxqL.text = name;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *name = [[self.orderArray objectAtIndex:row] objectForKey:@"name"];
    return name;
}
- (void)ssxqClick:(UITapGestureRecognizer*)tap {
    
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, 250, 100)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择辖区" message:@" \n\n\n\n    \n\n     " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       // self.jgsjF.text = [matter stringFromDate:datePicker.date];
       // self.jgsj = [datePicker.date timeIntervalSince1970];
     NSDictionary *dic = [self.orderArray objectAtIndex:[picker selectedRowInComponent:0]];
        
        self.ssxqL.text = dic[@"name"];
        self.ssxq = [dic[@"id"] integerValue];
    }];
    [alert addAction:cancel];
    [alert.view addSubview:picker];
    
    [self presentViewController:alert animated:YES completion:nil];

    
}

- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  makrk - 上传回调
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
- (void)tapTimeShow:(UITapGestureRecognizer *)tap
{
   // DateShowViewController *datePicker = [[DateShowViewController alloc]init];
   // [self.navigationController pushViewController: datePicker animated:YES];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.frame = CGRectMake(0, 30, 260, 100);
    datePicker.datePickerMode = UIDatePickerModeDate;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择时间" message:@" \n\n\n\n\n \n\n    \n\n                          " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter *matter = [[NSDateFormatter alloc]init];
        matter.dateFormat = @"YYYY-MM-dd";
        
        self.jgsjF.text = [matter stringFromDate:datePicker.date];
        self.jgsj = [datePicker.date timeIntervalSince1970];
    }];
    [alert addAction:cancel];
    [alert.view addSubview:datePicker];
    alert.view.translatesAutoresizingMaskIntoConstraints = NO;
  //  datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [alert.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[datePicker]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(datePicker)]];
    
    [alert.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[datePicker]-40-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(datePicker)]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.buildingName.text = self.name;
    self.buildingAddress.text = self.addr;

    self.buildingAddress.textColor = [UIColor blackColor];
    self.buildingHeight.text = [NSString stringWithFormat:@"%.2f",self.jzgd];
    self.numberOfUnits.text = [NSString stringWithFormat:@"%ld",(long)self.rzdws];
    self.jzcsdsF.text = [NSString stringWithFormat:@"%ld",(long)self.jzcsds];
    self.jzcsdx.text = [NSString stringWithFormat:@"%ld",(long)self.jzcsdxA];
    self.jzmjds.text = [NSString stringWithFormat:@"%.2f",self.jzmjdsA];
    self.jzmjdx.text = [NSString stringWithFormat:@"%.2f",self.jzmjdxA];
    for (UIButton *button in self.ssxqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag-100==self.ssxq)
            button.selected = YES;
    }
    for (UIButton *button in self.buildingTypeContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.type)
            button.selected = YES;
    }
    for (UIButton *button in self.gclxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.gclx+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.cqqkContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.cqqk+1000)
            button.selected = YES;
    }
    self.cqdwF.text = self.cqdw;
    self.cqdwlxrF.text = self.cqdwlxr;
    self.cqdwlxdh.text = self.cqdwlxdhA;
    self.wydwF.text = self.wydw;
    self.wydwlxrF.text = self.wydwlxr;
    self.wydwlxdhF.text = self.wydwlxdh;
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    forma.dateFormat = @"YYYY-MM-dd";
    if(self.jgsj!=0)
    self.jgsjF.text = [forma stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.jgsj]];
    
    for (UIButton *button in self.xfspsxContenView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.xfspsx+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.xfkzsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.xfkzs+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.hzzdbjxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.hzzdbjxt+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.snxhsxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.snxhsxt+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.zdpsmhxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.zdpsmhxt+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.mhqContenView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.mhq+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.qtxfqcContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.qtxfssqc+1000)
            button.selected = YES;
    }
    for (UIButton *button in self.sfczzdhzyhContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.tag==self.sfczzdhzyh+1000)
            button.selected = YES;
    }
}
- (void)AddressClick
{
    [self readyToSummit];
    IDSSMLocationViewController *locationManager = [[IDSSMLocationViewController alloc]init];
    locationManager.addressDelegate = self;
    [self.navigationController pushViewController:locationManager animated:YES];
}

- (void)getAddress:(NSString *)address latitude:(double)latitude longitude:(double)longitude
{
    self.addr = address;
    self.lat = latitude;
    self.lng = longitude;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.row = indexPath.row;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 50;
- (IBAction)summitClick:(id)sender {
    [self readyToSummit];
    if(self.ssxq==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选择辖区" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.label.text = NSLocalizedString(@"正在上传数据...", @"完成");
    hud.minSize = CGSizeMake(150.f, 100.f);
    hud.minShowTime = 1.f;
    
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @(self.lng),@"lng",
                                       @(self.lat),@"lat",
                                       self.buildingName.text,@"name",
                                       self.buildingAddress.text,@"addr",
                                       @(self.type),@"type",
                                       @(self.jzgd),@"jzgd",
                                       @(self.rzdws),@"rzdws",
                                       @(self.jzcsds),@"jzcsds",
                                       @(self.jzcsdxA),@"jzcsdx",
                                       @(self.gclx),@"gclx",
                                       @(self.cqqk),@"cqqk",
                                       self.cqdwF.text,@"cqdw",
                                       self.cqdwlxrF.text,@"cqdwlxr",
                                       self.cqdwlxdh.text,@"cqdwlxdh",
                                       self.wydwlxrF.text,@"wydwlxr",
                                       self.wydwlxdhF.text,@"wydwlxdh",
                                       @(self.xfspsx),@"xfspsx",
                                       @(self.xfkzs),@"xfkzs",
                                       @(self.hzzdbjxt),@"hzzdbjxt",
                                       @(self.snxhsxt),@"snxhsxt",
                                       @(self.zdpsmhxt),@"zdpsmhxt",
                                       @(self.mhq),@"mhq",
                                       @(self.qtxfssqc),@"qtxfssqc",
                                       self.mutaRisks,@"risks",
                                       
               self.wydw,@"wydw",nil];
    
        [dictionary setObject:@(self.ssxq) forKey:@"districtId"];
    if(self.jgsj!=0)
        [dictionary setObject: [NSNumber numberWithLong:self.jgsj*1000] forKey:@"jgsj"];
    NSString *string = [dictionary JSONString];
    
    
    NSString *userSn = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSn"];
    NetworkManager *manager = [[NetworkManager alloc]init];
    manager.reloadDelegate = self;
    if (self.isAddOrUpdate)
    { [manager addBuilding:string userSn:userSn];
    }
    else
    {
        [dictionary setObject:@(self.cellId) forKey:@"id"];
        string = [dictionary JSONString];
        [manager updateBuilding:string userSn:userSn];
        
    }

}

- (void)summitEditingBuilding
{
    }
- (void)readyToSummit
{
    for (UIButton *button in self.ssxqContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.ssxq = button.tag - 100;
    }
    for (UIButton *button in self.buildingTypeContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.type = button.tag  ;
    }
    self.gclx = 0;
    for (UIButton *button in self.gclxContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.gclx = button.tag - 1000;
    }
    for (UIButton *button in self.cqqkContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.cqqk = button.tag - 1000;
    }
    for (UIButton *button in self.xfspsxContenView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.xfspsx = button.tag - 1000;

    }
    for (UIButton *button in self.xfkzsContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.xfkzs = button.tag - 1000;
    }
    for (UIButton *button in self.hzzdbjxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.hzzdbjxt = button.tag - 1000;
    }
    for (UIButton *button in self.snxhsxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.snxhsxt = button.tag - 1000;
    }
    for (UIButton *button in self.zdpsmhxtContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.zdpsmhxt = button.tag - 1000;
    }
    for (UIButton *button in self.mhqContenView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.mhq = button.tag - 1000;
    }
    for (UIButton *button in self.qtxfqcContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
        self.qtxfssqc = button.tag - 1000;
    }
    for (UIButton *button in self.sfczzdhzyhContentView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]&&button.selected)
            self.sfczzdhzyh = button.tag - 1000;
    }
    self.name = self.buildingName.text;
    self.jzgd = [self.buildingHeight.text floatValue];
    self.rzdws = [self.numberOfUnits.text integerValue];
    self.jzcsds = [self.jzcsdsF.text integerValue];
    self.jzcsdxA = [self.jzcsdx.text integerValue];
    self.jzmjdsA = [self.jzmjds.text floatValue];
    self.jzmjdxA = [self.jzmjdx.text floatValue];
    
    self.mutaRisks = [NSMutableArray array];
    if(self.risks.count!=0)
    {
        for(IDSSMRisk *risk in self.risks)
        {
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(risk.state),@"state",@(risk.priority),@"priority",risk.brief,@"brief",risk.detail,@"detail",@(risk.cellId),@"cellId", nil];
//            
//            [self.mutaRisks addObject:dic];
        }
    }
    if(self.sfczzdhzyh != 0)
    {
        if (self.sfczzdhzyh == 1)
        {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(self.sfczzdhzyh),@"priority",@(0),@"state",self.yhqkF.text,@"detail",nil];
        [self.mutaRisks addObject:dict];
        }
        else
        {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(self.sfczzdhzyh),@"priority",@(1),@"state",self.yhqkF.text,@"detail",nil];
            [self.mutaRisks addObject:dict];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [super tableView:self numberOfRowsInSection:section];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [super tableView:self cellForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
