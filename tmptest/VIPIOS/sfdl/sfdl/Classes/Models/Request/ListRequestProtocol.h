//
//  ListRequestProtocol.h
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListRequestProtocol <NSObject>

- (BOOL) checkArray:(NSMutableArray *) array;

- (BOOL) checkString:(NSString *) string;

- (NSMutableArray *) keyArrays;

- (NSMutableArray *) valueArrays;

- (NSString *) toJsonString;

- (NSString *) methodString;

- (NSString *) hostString;

- (NSString *) URLString;
@end
