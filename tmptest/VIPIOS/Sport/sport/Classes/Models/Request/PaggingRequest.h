//
//  PaggingRequest.h
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"
#import "ListRequestBase.h"

@interface PaggingRequest : ListPaggingRequestBase

@property (nonatomic, assign) double longitude,latitude;

@property (nonatomic, copy) NSString *age,*eventId,*distance;

@end



@interface GymnasiumsRequest : PaggingRequest

@end

@interface CoachesRequest : PaggingRequest

@end


@interface DetailRequest : ListRequestBase
@property (nonatomic, copy) NSString *itemId;

@end

@interface GymnasiumDetailRequest : DetailRequest
@end


@interface CoachDetailRequest : DetailRequest
@end


@interface EventsRequest : ListPaggingRequestBase

@end

@interface CitysRequest : ListRequestBase

@end



@interface CheckClassesRequest : ListPaggingRequestBase
@property (nonatomic, copy) NSString *userId;

@end


@interface CheckCoachesRequest : ListPaggingRequestBase
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) double longitude,latitude;
@property (nonatomic, copy) NSString *distance;
@end