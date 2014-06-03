//
//  BaseGroupTableView.m
//  GoDate
//
//  Created by lei zhang on 13-8-12.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#import "BaseGroupTableView.h"

@implementation BaseGroupTableView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.delegate  =  self;
//        self.dataSource  = self;
//        self.backgroundColor = kClearColor;
//        self.backgroundView  = nil;
//
//    }
//    return self;
//}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        self.delegate  =  self;
        self.dataSource  = self;
        self.backgroundColor = kClearColor;
        self.backgroundView  = nil;
        
    }
    return self;

}

- (CGRect) tableViewFrame
{
    return kContentFrame;
}

- (NSMutableArray *) tableTitleArray
{
    if (!_tableTitleArray) {
        _tableTitleArray = [[NSMutableArray  alloc]init];
    }
    return _tableTitleArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderHeightBlock) {
        return  self.sectionHeaderHeightBlock(tableView, section);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterHeightBlock) {
        return  self.sectionFooterHeightBlock(tableView, section);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderBlock) {
        return  self.sectionHeaderBlock(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterBlock) {
        return  self.sectionFooterBlock(tableView, section);
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sectionNumberBlock) {
        return self.sectionNumberBlock(tableView);
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cellNumberBlock) {
        return self.cellNumberBlock(tableView,section);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellCreateBlock) {
        return self.cellCreateBlock(tableView,indexPath);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellSelectedBlock) {
        self.cellSelectedBlock(tableView,indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellDeSelectedBlock) {
        self.cellDeSelectedBlock(tableView,indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeightBlock) {
        return self.cellHeightBlock(tableView,indexPath);
    }
    return 44.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellEditBlock) {
        return self.cellEditBlock(tableView,indexPath);
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellEditActionBlock) {
        return self.cellEditActionBlock(tableView,editingStyle,indexPath);
    }
}


//- (void) configTableView
//{
//    NSLog(@"");
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
