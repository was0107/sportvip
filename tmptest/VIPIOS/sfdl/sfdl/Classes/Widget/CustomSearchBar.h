//
//  CustomSearchBar.h
//  sfdl
//
//  Created by micker on 6/5/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CompleteBlock)(NSString *keyword);

@interface CustomSearchBar : UIView
@property (nonatomic, retain)   UITextField      *searchField;
@property (nonatomic, copy)     CompleteBlock    completeBlok;

@end



@interface CustomSearchBarEx : UIView

@property (nonatomic, retain) UILabel *label1, *label2;

@end
