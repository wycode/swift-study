//
//  IDSSMLocationViewController.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol returnAddress <NSObject>

- (void)getAddress:(NSString *)address latitude:(double)latitude longitude:(double)longitude;

@end
@interface IDSSMLocationViewController : UIViewController
@property (nonatomic, strong)NSMutableArray *cellsArray;
@property (nonatomic, assign)id<returnAddress>addressDelegate;
@end
