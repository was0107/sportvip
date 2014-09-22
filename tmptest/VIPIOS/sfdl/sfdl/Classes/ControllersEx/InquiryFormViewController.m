//
//  InquiryFormViewController.m
//  sfdl
//
//  Created by boguang on 14-9-22.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "InquiryFormViewController.h"

@interface InquiryFormViewController ()

@end

@implementation InquiryFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"INQUIRY FORM"];

    // Do any additional setup after loading the view.
}

- (NSString *)tabImageName
{
    return @"email_black";
}

- (NSString *)tabSelectedImageName
{
    return @"email_white";
}

@end
