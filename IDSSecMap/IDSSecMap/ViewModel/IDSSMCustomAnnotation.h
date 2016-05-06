//
//  IDSSMCustomAnnotation.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "IDSSMCell.h"
@interface IDSSMCustomAnnotation : NSObject<MAAnnotation>
{
    CLLocationCoordinate2D coordinate;
}
@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *imageString;
@property (nonatomic, strong)IDSSMCell *cell;
@property (nonatomic, copy)NSAttributedString *title;
@property (nonatomic, copy)NSAttributedString *subtitle;
@property (nonatomic, assign)NSInteger index;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;
@end
