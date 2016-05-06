//
//  IDSSMCustomAnnotationView.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/29.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@class IDSSMCustomAnnotationView;

@protocol IDSSMAnnotationViewDelegate <NSObject>

- (void)didAnnotationViewCalloutTapped:(IDSSMCustomAnnotationView *)annotation;


@end

@interface IDSSMCustomAnnotationView : MAAnnotationView
@property (nonatomic, strong) CustomCalloutView *calloutView;
@property (nonatomic, weak)id<IDSSMAnnotationViewDelegate> annotationDelegate;
@end
