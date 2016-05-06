//
//  CustomCalloutView.h
//  IDSSecMap
//
//  Created by indoorstar on 16/3/29.
//  Copyright © 2016年 indoorstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
@property (nonatomic, copy) NSAttributedString *title;
@property (nonatomic, copy) NSAttributedString *subTitle;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *subtitleLabel;
@end
