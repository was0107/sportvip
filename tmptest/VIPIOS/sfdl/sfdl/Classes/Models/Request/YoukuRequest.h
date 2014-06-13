//
//  YoukuRequest.h
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"
#import "YoukuResponse.h"

@interface YoukuRequest : ListRequestBase
@property (nonatomic, copy) NSString    *originURL;
@property (nonatomic, copy) NSString    *videoID;

@end
