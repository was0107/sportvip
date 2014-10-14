//
//  NSDate+extend.h
//  comb5mios
//
//  Created by micker on 6/19/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDate (extend)
+ (NSString *) todayString;
+ (NSString *) todayStringEXA;
+ (NSString *) todayStringEX;

+ (NSDate *) stringToDate:(NSString *)dateString;

- (NSString*)formattedDateWithFormatString:(NSString*)dateFormatterString ;

- (NSString*)formattedExactRelativeDate ;
- (NSString *)relativeDateString;
@end
