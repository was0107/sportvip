//
//  WASBaseServiceFace.m
//  b5mUtility
//
//  Created by micker on 11/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseServiceFace.h"
#import "WASBaseServiceManager.h"
#import "WASASIUploadAdapter.h"

@implementation WASBaseServiceFace

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body
{
    [self serviceWithMethod:method body:body onSuc:NULL onFailed:NULL onError:NULL withCached:NO from:nil];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:NULL onError:NULL withCached:NO from:nil];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:failed onError:NULL withCached:NO  from:nil];
}

+ (void)serviceWithSF1Method:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:NULL onError:NULL withCached:NO from:@"SF1"];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:failed onError:error withCached:NO  from:nil];
}

+(void) serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error withCached:(BOOL) cached
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:failed onError:error withCached:NO from:nil];
}


+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error withCached:(BOOL) cached from:(id) SF1
{
    if (!method || 0 == method.length) {
        return;
    }
    [self cancelServiceMethod:method];
    WASBaseAdapter *adapterLog = [(WASBaseAdapter *)[[WASASILogAdatper  alloc] initWithAdapter:nil] autorelease];
    WASBaseAdapter *adapterASI = [[[WASASIAdapter alloc] initWithURL:method
                                                              method:SF1
                                                                Body:body
                                                             adatper:(WASBaseAdapter *)adapterLog] autorelease];
    
    __block WASBaseAdapter *result = adapterASI;
    voidBlock clearBlock = ^{};
    if (cached) {
        WASBaseAdapter *adapterCache = [[[WASASICacheAdapter alloc] initWithAdapter:adapterASI] autorelease];
        [[WASBaseServiceManager sharedRequestInstance] store:adapterASI forKey:method];
        result = adapterCache;
        clearBlock = ^{
            [[WASBaseServiceManager sharedRequestInstance] removeKey:method];
        };
    }
    
    // store cached ASI
    
    [result onSuccessBlock:(!success) ? NULL : ^{
        success([result contents]);
        clearBlock();
    }];
    [result onFailedBlock:(!failed) ? NULL : ^{
        failed([result contents]);
        clearBlock();
    }];
    [result onErrorBlock:(!error) ? NULL : ^{
        error(kIntToString([result statusCode]));
        clearBlock();
    }];
    
    [result startService];
    
}

+ (void)serviceUploadMethod:(NSString *) method data:(NSData *) data body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error
{
    WASBaseAdapter *adapterLog = [(WASBaseAdapter *)[[WASASILogAdatper  alloc] initWithAdapter:nil] autorelease];
    WASASIUploadAdapter *adapterASI = [[[WASASIUploadAdapter alloc] initWithURL:kUploadImageURL(method)
                                                                         method:method
                                                                           data:data
                                                                           Body:body
                                                                        adatper:(WASBaseAdapter *)adapterLog] autorelease];
    
    __block WASBaseAdapter *result = adapterASI;
    [result onSuccessBlock:(!success) ? NULL : ^{
        success([result contents]);
    }];
    [result onFailedBlock:(!failed) ? NULL : ^{
        failed([result contents]);
    }];
    [result onErrorBlock:(!error) ? NULL : ^{
        error(kIntToString([result statusCode]));
    }];
    
    [result startService];
}

+ (void)cancelServiceMethod:(NSString *) method;
{
    WASBaseAdapter *adapterASI  = [[WASBaseServiceManager sharedRequestInstance] requestForKey:method];
    if (adapterASI) {
        DEBUGLOG(@"current method = %@ ,adapterASI = %@ is being canceld", method,adapterASI);
        [adapterASI cancel];
        [[WASBaseServiceManager sharedRequestInstance] removeKey:method];
    }
}

@end
