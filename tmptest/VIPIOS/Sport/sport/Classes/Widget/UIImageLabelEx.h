//
//  UIImageLabelEx.h
//  sport
//
//  Created by Erlang on 14-6-2.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageLabelEx : UILabel


- (id) setImages:(NSArray *) images origitation:(int) flag;
- (id) setImage:(NSString *) image origitation:(int) flag;


- (id) shiftPositionY:(CGFloat) flag;
- (id) shiftPositionX:(CGFloat) flag;

@end
