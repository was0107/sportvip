//
//  B5MNormalTableView.h
//  PrettyUtility
//
//  Created by micker on 1/5/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface B5MNormalTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray    *contentArray;


- (void) setupContentView;

@end
