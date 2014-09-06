//
//  LanguageViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "LanguageViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "ProductResponse.h"

@interface LanguageViewController ()
@property (nonatomic, retain) SetSurportlangRequest *setLanguageRequest;
@property (nonatomic, retain) SurportLangRequest    *request;
@property (nonatomic, retain) SurportLangResponse   *response;
@end

@implementation LanguageViewController

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
    self.secondTitleLabel.text = @"Languages";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __block LanguageViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 290, 24);
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
        }
        LanguageItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.lang_name;
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        LanguageItem *item = [blockSelf.response at:indexPath.row ];
        [self sendRequestToSetLanguase:item.lang];
    };
    
    [self.view addSubview:self.tableView];
    
    [self sendRequestToServer];
}

- (void) dealWithData
{
    [self.tableView reloadData];
}

- (void) sendRequestToSetLanguase:(NSString *)lang
{
    if ([[UserDefaultsManager userName] length] == 0) {
        [SVProgressHUD showWithOnlyStatus:@"登录之后才能设置"];
        return;
    }
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        [UserDefaultsManager saveLang:lang];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_setLanguageRequest) {
        self.setLanguageRequest = [[[SetSurportlangRequest alloc] init] autorelease];
    }
    self.setLanguageRequest.lang = lang;
    self.setLanguageRequest.username = [UserDefaultsManager userName];
    [WASBaseServiceFace serviceWithMethod:[self.setLanguageRequest URLString] body:[self.setLanguageRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
 
}

- (void) sendRequestToServer
{
    __block LanguageViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[SurportLangResponse alloc] initWithJsonString:content];
        [blockSelf dealWithData];
        
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_request) {
        self.request = [[[SurportLangRequest alloc] init] autorelease];
    }    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end
