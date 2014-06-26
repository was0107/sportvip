//
//  ProductCartViewController.m
//  sfdl
//
//  Created by allen.wang on 6/26/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductCartViewController.h"

@interface ProductCartViewController ()

@end

@implementation ProductCartViewController

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

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __block ProductCartViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCartViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(70, 10, 220, 25);
            cell.subLabel.frame = CGRectMake(70, 35, 220, 25);
            cell.leftImageView .frame = CGRectMake(10, 10, 50, 50);
            cell.rightButton.frame = CGRectMake(250, 35, 60,35);
            cell.topLabel.numberOfLines = 2;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize15);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
            [cell.contentView addSubview:cell.leftImageView];
            [cell.contentView addSubview:cell.rightButton];
        }
        ProductItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.productName;
        cell.subLabel.text = item.productDesc;
        cell.content = item;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.productImg]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
                                        cell.leftImageView.image = image1;
                                    }
                                    failure:^(NSError *error){
                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
        cell.block = ^(id content)
        {
            [[ProductCart sharedInstance] addProductItem:content];
        };
        
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return [blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  70.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        ProductItem *item = [blockSelf.response at:indexPath.row ];
//        ProductDetailViewController *controller = [[[ProductDetailViewController alloc] init] autorelease];
//        //        controller.secondTitleLabel.text = item.productName;
//        controller.productItem = item;
//        [blockSelf.navigationController hidesBottomBarWhenPushed];
//        [blockSelf.navigationController pushViewController:controller animated:YES];
        
    };
    
    [self.view addSubview:self.tableView];
}


@end
