//
//  URLParser.h
//  taoappios
//
//  Created by Eason on 5/12/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParser : NSObject{
    NSArray *variables;
}

@property (nonatomic, retain) NSArray *variables;

- (id)initWithURLString:(NSString *)url;

- (NSString *)valueForVariable:(NSString *)varName;

@end
