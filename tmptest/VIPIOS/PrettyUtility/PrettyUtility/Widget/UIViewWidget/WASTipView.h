//
//  WASTipView.h
//  comb5mios
//
//  Created by micker on 9/29/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum 
{
    eWASGoodsTip        = 0,
    eWASTuanTip         = 1<<0,
    eWASGuangTip        = 1<<1,
    eWasDailyTip        = 1<<2,
    eWasPredictTip      = 1<<3,
}eWASTipType;

@interface WASTipView : UIView
@property (nonatomic, assign) eWASTipType type;
@property (nonatomic, copy ) NSString *title;


- (void) showShareNoErr;

@end
