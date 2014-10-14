//
//  CustomLabel.h
//  comb5mios
//
//  Created by micker on 6/5/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kColorKey       @"color"

@interface CustomLabel : UILabel

@property (nonatomic, retain) UIColor   *customColor;           // custom color
@property (nonatomic, retain) NSMutableArray *colorArray;       // contain color dictionary
@end
