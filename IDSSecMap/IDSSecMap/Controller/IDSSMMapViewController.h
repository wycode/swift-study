//
//  ViewController.h
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface IDSSMMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (nonatomic, retain)NSMutableArray *cellsArray;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
- (void)mapViewSetCenter:(CLLocationCoordinate2D)coordinate ;
- (void)annotationEditing;
- (void)setCellsArray:(NSMutableArray *)cellsArray;
@end
