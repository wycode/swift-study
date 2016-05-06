//
//  IDSSMCustomAnnotation.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/14.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMCustomAnnotation.h"

@implementation IDSSMCustomAnnotation
- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self)
    {
        _coordinate = coord;
        _cell = [[IDSSMCell alloc]init];
    }
    return self;
}
@end
