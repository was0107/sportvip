//
//  SettingViewController.m
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "SettingViewController.h"
#import "CheckUpdate.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "MyTableViewCell.h"

@interface SettingViewController()
@property (nonatomic, retain) UILabel *currentVersionLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_currentVersionLabel);
    [super dealloc];
}

- (UILabel *) currentVersionLabel
{
    if (!_currentVersionLabel) {
        _currentVersionLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(200, 12, 110, 20)];
        _currentVersionLabel.backgroundColor      = kClearColor;
        _currentVersionLabel.textColor            = kLightGrayColor;
        _currentVersionLabel.font                 = HTFONTSIZE(kFontSize12);
        _currentVersionLabel.textAlignment        = UITextAlignmentRight;
        _currentVersionLabel.highlightedTextColor = kWhiteColor;
        _currentVersionLabel.text                 = [NSString stringWithFormat:@"当前版本：%@",[B5MUtility version]];
    }
    return _currentVersionLabel;
}


- (NSString *)tabImageName
{
    return @"3-1";
}

- (NSString *)tabSelectedImageName
{
    return @"3-2";
}

- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained SettingViewController *blockSelf = self;
    self.tableView.tableHeaderView = TABLE_VIEW_HEADERVIEW(20.1f);
    NSArray *titleIndexArray = @[@"意见反馈",@"给我评分",@"检查更新",@"关于我们"];
    NSArray *imageIndexArray = @[@"feedback",@"charge",@"update",@"about_us"];

    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SETTING_TABLEVIEW_CELL_IDENTIFIER";
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//            [cell.topLabel setFrame:CGRectMake(15, 10, 200, 24)];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (eSectionIndex01 == indexPath.section) {
            cell.topLabel.text = [titleIndexArray objectAtIndex:3];
            cell.leftImageView.image = [UIImage imageNamed:[imageIndexArray objectAtIndex:3]];
        } else {
            cell.topLabel.text = [titleIndexArray objectAtIndex:indexPath.row];
            cell.leftImageView.image = [UIImage imageNamed:[imageIndexArray objectAtIndex:indexPath.row ]];
            if (indexPath.row == eTableViewRowIndex02) {
                [cell.contentView addSubview:self.currentVersionLabel];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (eSectionIndex00 == section) ? 3 : 1;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView) {
        return (NSInteger)2;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.sectionFooterHeightBlock = ^(UITableView *tableView, NSInteger section)
    {
        return 20.0f;
    };
    
    self.tableView.sectionFooterBlock = ^( UITableView *tableView, NSInteger section)
    {
        UIView *footerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)]autorelease];
        return footerView;
    };
    
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        BaseTitleViewController *controller = nil;

        if (eSectionIndex01 == indexPath.section) {
            controller = [[[AboutViewController alloc] init] autorelease];
            [controller setTitleContent:[titleIndexArray objectAtIndex:3]];
        }
        else {
            switch (indexPath.row)
            {
                    
                case eTableViewRowIndex00:
                {
                    controller = [[[FeedbackViewController alloc] init] autorelease];
                    [controller setTitleContent:[titleIndexArray objectAtIndex:0]];

                }
                    break;
                case eTableViewRowIndex01:
                {
                    [[[CheckUpdate shareInstance] appID:kAPPID] goToAppStore];

                }
                    break;
                case eTableViewRowIndex02:
                {
                    [[[CheckUpdate shareInstance] appID:kAPPID] checkUpdate];

                }
                    break;
            }

        }
        if (controller) {
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    [self.view addSubview: self.tableView];
    
}
@end
