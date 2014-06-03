//
//  ListRequestBase.h
//  b5mappsejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListRequestProtocol.h"
#import "URLMethod.h"


@interface ListRequestBase : NSObject<ListRequestProtocol>

@end


@interface ListRequestWithUserIDBase : ListRequestBase
@property (nonatomic, copy)  NSString *userID;
@property (nonatomic, copy)  NSString *token;
@end