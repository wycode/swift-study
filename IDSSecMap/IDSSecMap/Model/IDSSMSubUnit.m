//
//  IDSSMSubUnit.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/20.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMSubUnit.h"

@implementation IDSSMSubUnit
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"subunit unfind key-%@",key);
}
@end
