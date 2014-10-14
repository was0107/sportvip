//
//  MenuViewControllerEx.m
//  sfdl
//
//  Created by micker on 14-9-15.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "MenuViewControllerEx.h"

@interface MenuViewControllerEx ()

@end

@implementation MenuViewControllerEx

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tabImageName
{
    return @"menu_black";
}

- (NSString *)tabSelectedImageName
{
    return @"menu_white";
}


@end
