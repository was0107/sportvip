//
//  ContactUsViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ContactUsViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "RTLabel.h"


@interface ContactUsViewController ()
@property (nonatomic, retain) CompanyInfoRequest *request;
@property (nonatomic, retain) AboutUsResponse    *response;
@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UIWebView *labelTwo;

@end

@implementation ContactUsViewController

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
    self.secondTitleLabel.text = @"Contact Us";
    [self.tableView removeFromSuperview];
//    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.labelTwo];
    [self sendRequestToServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendRequestToServer
{
    
    __unsafe_unretained ContactUsViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.response = [[[AboutUsResponse alloc] initWithJsonString:content] autorelease];
        safeSelf.labelOne.text = safeSelf.response.companyName;
        //        safeSelf.labelTwo.text = safeSelf.response.companyDes;
        [safeSelf.labelTwo loadHTMLString:safeSelf.response.companyDes baseURL:nil];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    CompanyInfoRequest *request = [[[CompanyInfoRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:kAboutLogoFrame];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _iconImageView;
}

-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(8, 44, 304, 20)];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kSystemFontSize15);
        //        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        //        _labelOne.text = version;
    }
    return _labelOne;
}

-(UIWebView *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, kContentBoundsHeight-64)];
        //        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
        //        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _labelTwo.backgroundColor = kClearColor;
        //        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
        //        _labelTwo.text = lLabelTwoString;
        //        _labelTwo.numberOfLines = 0;
        
    }
    return _labelTwo;
}

-(void)reduceMemory
{
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_labelOne);
    TT_RELEASE_SAFELY(_labelTwo);
    [super reduceMemory];
}


@end
