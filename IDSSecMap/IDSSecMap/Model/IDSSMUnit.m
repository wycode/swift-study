//
//  IDSSMUnit.m
//  IDSSecMap
//
//  Created by iosDevMacbookPro on 16/3/4.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMUnit.h"

@implementation IDSSMUnit
- (instancetype)init
{
    if (self = [super init])
    {
   //     _risks = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"idsMall"])
        return;
    else
        NSLog(@"unfind unit key %@",key);
}
@end
