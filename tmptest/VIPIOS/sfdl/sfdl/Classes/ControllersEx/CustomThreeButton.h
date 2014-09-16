//
//  CustomThreeButton.h
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomColumButton : UIButton
@property (nonatomic, copy) NSString *imageString, *title;
@property (nonatomic, assign) id content;

@end

@interface CustomThreeButton : CustomColumButton


@end



@interface CustomTwoButton : CustomColumButton

@end