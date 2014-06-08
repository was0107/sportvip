//
//  CustomImageTitleButton.h
//  sfdl
//
//  Created by allen.wang on 6/4/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageTitleButton : UIView
@property(nonatomic, retain)UIButton * topButton;


- (void) setText:(NSString *) text image:(NSString *)imageName;
@end
