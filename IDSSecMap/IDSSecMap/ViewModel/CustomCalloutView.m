//
//  CustomCalloutView.m
//  IDSSecMap
//
//  Created by indoorstar on 16/3/29.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import "CustomCalloutView.h"

#define kPortraitMargin     5
#define kPortraitWidth      80
#define kPortraitHeight     50

#define kTitleWidth         150
#define kTitleHeight        20
@implementation CustomCalloutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.layer.cornerRadius = 8;
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake( 15 , 5, kTitleWidth, kTitleHeight)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, kTitleHeight+5, kTitleWidth, kTitleHeight)];
    self.subtitleLabel.font = [UIFont boldSystemFontOfSize:17];

    [self addSubview:self.subtitleLabel];
}
- (void)setTitle:(NSAttributedString *)title
{
    self.titleLabel.attributedText = title;
}
- (void)setSubTitle:(NSAttributedString *)subTitle
{
    self.subtitleLabel.attributedText = subTitle;
}
@end
