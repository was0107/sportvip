//
//  ViewEnquiryViewContrller.m
//  sfdl
//
//  Created by boguang on 14-7-28.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "ViewEnquiryViewContrller.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "CreateObject.h"
#import "UIKeyboardAvoidingScrollView.h"

@interface ViewEnquiryViewContrller()<UITextViewDelegate>
@property (nonatomic, retain) ViewEnquiryRequest           *request;
@property (nonatomic, retain) ViewEnquiryResponse          *response;

@end

@implementation ViewEnquiryViewContrller

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_item);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showRight] setTitleContent:@"INQUIRY DETAIL"];
    [self sendRequestToServer];
}

- (IBAction)rightButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
            cell.contentView.backgroundColor = kWhiteColor;
            cell.topLabel.frame              = CGRectMake(5, 4, 70, 36);
            cell.topLabel.textColor          = kLightGrayColor;
            cell.topLabel.numberOfLines      = 1;
            cell.topLabel.textAlignment      = NSTextAlignmentRight;
            cell.topLabel.font               = HTFONTSIZE(kFontSize15);
            
            cell.subLabel.frame              = CGRectMake(80, 4, 230, 36);
            cell.subLabel.textColor          = kBlackColor;
            cell.subLabel.numberOfLines      = 0;
            cell.subLabel.font               = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
        }
        
        EnquiryItem *item = [blockSelf.response item];
        NSString *value = [item.valuesArray objectAtIndex:indexPath.row];
        CGSize size = [value sizeWithFont:HTFONTSIZE(14) forWidth:230 lineBreakMode:NSLineBreakByCharWrapping];
        [cell.subLabel setFrame:CGRectMake(80, 4, 230, size.height <= 36 ? 36 : size.height)];
        cell.topLabel.text = [item.keysArray objectAtIndex:indexPath.row];
        cell.subLabel.text = value;
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        EnquiryItem *item = [blockSelf.response item];
        NSString *value = [item.valuesArray objectAtIndex:indexPath.row];
        CGSize size = [value sizeWithFont:HTFONTSIZE(14) forWidth:230 lineBreakMode:NSLineBreakByCharWrapping];
//        CGRect rect = [value boundingRectWithSize:CGSizeMake(230, 20000) options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil];
        return  size.height <= 36 ? 44 : (size.height + 8);
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response.item.keysArray count];
    };
    
    [self.view addSubview:self.tableView];
}


- (void)sendRequestToServer
{
    __block typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.response = [[[ViewEnquiryResponse alloc] initWithJsonString:content] autorelease];
        [safeSelf.tableView reloadData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    if (!self.request) {
        self.request = [[[ViewEnquiryRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    self.request.enquiryId = self.item.enquiryId;
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


@end
