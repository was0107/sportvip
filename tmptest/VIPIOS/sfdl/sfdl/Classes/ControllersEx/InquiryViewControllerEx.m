//
//  InquiryViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "InquiryViewControllerEx.h"

@interface InquiryViewControllerEx ()

@end

@implementation InquiryViewControllerEx

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end