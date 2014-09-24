//
//  AboutUsViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AboutUsViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "RTLabel.h"


@interface AboutUsViewController ()
@property (nonatomic, retain) CompanyInfoRequest *request;
@property (nonatomic, retain) AboutUsResponse    *response;
@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UIWebView *labelTwo;

@end

@implementation AboutUsViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_labelOne);
    TT_RELEASE_SAFELY(_labelTwo);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"ABOUT US"];
    [self.tableView removeFromSuperview];
//    [self.view addSubview:self.iconImageView];
//    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.labelTwo];
    [self sendRequestToServer];
}

- (void)sendRequestToServer
{
    
    __unsafe_unretained typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
         safeSelf.response = [[[AboutUsResponse alloc] initWithJsonString:content] autorelease];
        safeSelf.labelOne.text = [NSString stringWithFormat:@"公司名称：%@",safeSelf.response.companyName];
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
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kFontSize14);
//        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//        _labelOne.text = version;
    }
    return _labelOne;
}

-(UIWebView *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, kContentBoundsHeight-0)];
//        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
//        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _labelTwo.backgroundColor = kClearColor;
//        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
//        _labelTwo.text = lLabelTwoString;
//        _labelTwo.numberOfLines = 0;
        
    }
    return _labelTwo;
}

@end
