//
//  WASASIAdapter.m
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASASIAdapter.h"
#import "UIDevice+extend.h"
#import "NSString+extend.h"

//#import "ModuleURLDef.h"
//#import "UserDefaultsKeys.h"

@interface WASASIAdapter()
@property (nonatomic, retain)  WASBaseAdapter *adapter;
@property (nonatomic, copy)  NSString *linkURL;
@property (nonatomic, copy)  NSString *method;
@property (nonatomic, copy)  NSString *body;

/*!
 *	@brief	init request
 *
 *	@return	self
 */
- (id) initRequest;

/*!
 *	@brief	addrequest Headers info
 *
 *	@return	self
 */
- (id) addRequestHeaderInfo;

/*!
 *	@brief	add blocks
 *
 *	@return	self
 */
- (id) addBlocks;

/*!
 *	@brief	start net work
 *
 *	@return	self
 */
- (id) startNetWork;

/**
 *	@brief	encrept the headers
 *
 *	@param 	method 	method description
 *
 *	@return	return value MD5 result
 */
- (NSString *) requestHeaderHash:(NSString *) method;
@end

@implementation WASASIAdapter
@synthesize adapter = _adapter;
@synthesize body    = _body;
@synthesize method  = _method;
@synthesize linkURL = _linkURL;
//@synthesize contents = _contents;


- (id) initWithURL:(NSString *)linkURL method:(NSString *) method Body:(NSString *) body adatper:(WASBaseAdapter *)adapter
{
    self = [super init];
    if (self) {
        [self setLinkURL:linkURL];
        [self setMethod:method];
        [self setBody:body];
        [self setAdapter:adapter];
    }
    return self;
}

- (id) initRequest
{
    self.statusCode = 0;
    NSString *stringURL     = [NSString stringWithFormat:@"%@?m=%@",self.linkURL,self.method];
    NSURL *url              = [NSURL URLWithString:stringURL];            
    _request = [[ASIHTTPRequest requestWithURL:url] retain];
    _request.delegate = nil;
    _request.allowCompressedResponse = YES;
#ifdef kUseSimulateData
    _request.shouldCompressRequestBody = NO;
#endif
    NSData *postBody = [self.body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [_request appendPostData:postBody];
    
    INFOLOG(@"\nrequest URL  = %@ \nrequest BODY = %@", stringURL,self.body);
    return self;
}

- (id) addRequestHeaderInfo
{
    UIDevice *device = [UIDevice currentDevice];    
    NSString *time   = device.t;
    NSString *chnl   = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    
    static NSString *keys[] = {kDeviceIMEI,kDeviceMOB,kDeviceOS,kDeviceDEV,kDeviceVER,
        kDeviceCHNL, kDeviceTIME,kDid,kGender,kAge,kApp_key};
    NSArray *values = [NSArray arrayWithObjects:device.imei,device.mob,device.os,device.dev,device.ver,
                       chnl,time,[B5MUtility deviceID],kIntToString([B5MUtility userGender]),kIntToString([B5MUtility userAge]),
                       kApp_key_value,nil];
    
    for (int i = 0 , total = 11; i< total; i++) {
        [_request addRequestHeader:keys[i] value:[values objectAtIndex:i]];  
    }
    
    [_request addRequestHeader:kDeviceSIGN  value:[self requestHeaderHash:self.method]];  
    [_request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];
    
    return self;
}

- (id) addBlocks
{
    [_request setCompletionBlock:^{    
        [self setValue:_request.responseString forKey:kKeyValueContents];
        [B5MUtility checkResultCode:_request.responseString] ? [self success] : ([self failed] ,  ERRLOG(@"FAILED MSG = %@",_request.responseString));
    }];
    
    [_request setFailedBlock:^{
        ERRLOG(@"Network Request Error  %d", _request.responseStatusCode);
        self.statusCode = _request.responseStatusCode;
        [self error];
    } ];
    return self;
}

- (id) startNetWork
{
    [_request startAsynchronous];
    return self;
}

- (void) startASIService
{
    [[[[self initRequest] addRequestHeaderInfo] addBlocks] startNetWork];
}

- (NSString *) requestHeaderHash:(NSString *) method{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_request.requestHeaders];
    [dic setObject:method  forKey:kDeviceMETHOD];
    
    NSArray *sortedArray = [[dic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSEnumerator    *enumerator = [sortedArray objectEnumerator];;
    NSMutableString *stringCode = [[[NSMutableString alloc] initWithCapacity:12] autorelease];
    id obj;
    while(obj = [enumerator nextObject])
    {
        [stringCode appendFormat:@"%@=%@&",obj, [dic valueForKey:obj]];
    }
    [stringCode appendFormat:@"%@=%@",kApp_secret, kApp_secret_value];
    return [NSString md5:stringCode];
}


- (NSString *) hash
{
    return [NSString stringWithFormat:@"%@-%@-%@",
            kIntToString([B5MUtility userGender]),
            kIntToString([B5MUtility userAge]),
            self.body];
}

- (NSString *)contents
{
    return  [self valueForKey:@"_contents"];
}

- (void) startService
{
    [super startService];
    [_adapter startService];
    
    if ([self shouldStart]) {
        [self success];
    }else {
        [self startASIService];
    }
}

-(BOOL) shouldStart
{
    return NO;
}

- (void) success
{
    [super success];
    [_adapter success];
}

- (void) failed
{
    [super failed];
    [_adapter failed];
}

- (void) error
{
    [super error];
    [_adapter error];
}

- (void) dealloc
{
    [_linkURL release], _linkURL = nil;
    [_method release], _method = nil;
    [_body release], _body = nil;
    [_adapter release], _adapter = nil;
    [super dealloc];
}
@end
