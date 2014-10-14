//
//  CustomThreeButton.h
//  sfdl
//
//  Created by micker on 14-9-6.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginResponse.h"

@interface CustomColumButton : UIButton
@property (nonatomic, copy) NSString *imageString, *title;
@property (nonatomic, assign) id content;
@property (nonatomic, retain) UILabel     *theLabel;

@end

@interface CustomThreeButton : CustomColumButton


@end



@interface CustomTwoButton : CustomColumButton

@end