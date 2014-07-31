//
//  CreateObject.h
//  b5mappsejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIColor+extend.h"
#import "UIImage+tintedImage.h"
#define createOBjectMarco(x)                        [[[NSClassFromString(x) alloc] init] autorelease]
#define createOBjectWithFrameMarco(x,frame)         [[[NSClassFromString(x) alloc] initWithFrame:frame] autorelease]

@interface CreateObject : NSObject
/*!
 *	@brief	create an instance of UITableView
 *
 *	@return	return the instance of UITableView object
 */
+ (UITableView *) plainTableView;

/*!
 *	@brief	create a imageView with image
 *
 *	@return	return the instance of  UIImageView object
 */
+ (UIImageView *) imageView:(NSString *) image;
+ (UIImageView *) imageView:(NSString *) image frame:(CGRect) frame first:(NSString *) first second:(NSString *) second;

/*!
 *	@brief	create a UIView object
 *
 *	@return	return the instance of  UIView object
 */
+ (UIView *) view;

/*!
 *	@brief	create a UIButton object
 *
 *	@return	return the instance of  UIButton object
 */
+ (UIButton *) button;

/*!
 *	@brief	create a UILabel object
 *
 *	@return	return the instance of  UILabel object
 */
+ (UILabel *) label;
+ (UILabel *) titleLabel;

+(UIScrollView *) scrollView;

+ (UIButton *) addTargetEfection:(UIButton *) theButton;


@end
