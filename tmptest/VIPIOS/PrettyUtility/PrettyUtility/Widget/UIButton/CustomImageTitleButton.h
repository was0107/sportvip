//
//  CustomImageTitleButton.h
//  sfdl
//
//  Created by micker on 6/4/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageTitleButton : UIView
@property(nonatomic, retain)UIButton * topButton;
@property(nonatomic, retain)UILabel     * bottomTitleLabel;


- (void) setText:(NSString *) text image:(NSString *)imageName;
@end


@interface CustomRoundImageTitle : UIButton

@property(nonatomic, retain)UIImageView * topImage;
@property(nonatomic, retain)UILabel     * bottomTitleLabel;


- (void) setText:(NSString *) text image:(NSString *)imageName;
@end