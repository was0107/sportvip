//
//  CustomSelectControl.h
//  Discount
//
//  Created by allen.wang on 7/3/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSelectControl : NSObject
@property (nonatomic,retain ) UIPickerView         *pickerView;
@property (nonatomic, assign) UIView               *belowView;
@property (nonatomic, retain) UILabel              *tipLabel;
@property (nonatomic, retain) NSMutableArray       *contentArray;
@property (nonatomic, copy  ) idBlock              block;
@property (nonatomic, copy  ) pickeCellBlock       cellBlock;
@property (nonatomic, copy  ) pickeCellViewBlock   cellViewBlock;
@property (nonatomic, copy  ) PickerComponentBlock componetBlock;
@property (nonatomic, copy  ) PickerNumberBlock    componetRowsBlock;
@property (nonatomic, copy  ) PickerWidthBlock     widthBlock;
@property (nonatomic, copy  ) PickerselectBlock    didSelectBlock;

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) int secondIndex;

- (id) initWithController:(UIViewController *) controller;

- (id) showContent:(BOOL) flag;

- (id) dissmissContent:(BOOL) flag;

- (id) selectRow:(NSInteger) row at:(NSInteger) compnent;

-(void)reloadAllComponents;

@end


@interface CustomDatePickerControl : NSObject
@property (nonatomic,retain) UIDatePicker      *pickerView;
@property (nonatomic, copy) idBlock                 block;

- (id) initWithController:(UIViewController *) controller;

- (id) showContent:(BOOL) flag;

- (id) dissmissContent:(BOOL) flag;

@end
