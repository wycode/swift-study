//
//  IDSSMCustomAnnotationView.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/29.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "IDSSMCustomAnnotationView.h"
#define kCalloutWidth    150.0
#define kCalloutHeight   50.0
@interface IDSSMCustomAnnotationView ()

@end
@implementation IDSSMCustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(self.selected == selected)
    {
        return;
    }
    if(selected)
    {
        if(self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToDelegate)];
            [self.calloutView addGestureRecognizer:tap];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds)/2.f + self.calloutOffset.x, -CGRectGetHeight(self.calloutView.bounds)/2.f+self.calloutOffset.y);
        }
        self.calloutView.title = (NSAttributedString *)self.annotation.title;
        self.calloutView.subTitle = (NSAttributedString *) self.annotation.subtitle;
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}
- (void)goToDelegate
{
    if ([self.annotationDelegate respondsToSelector:@selector(didAnnotationViewCalloutTapped:)])
        [self.annotationDelegate didAnnotationViewCalloutTapped:self];
}
@end

