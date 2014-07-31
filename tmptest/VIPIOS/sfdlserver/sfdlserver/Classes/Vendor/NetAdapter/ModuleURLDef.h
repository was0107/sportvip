//
//  ModuleURLDef.h
//  comb5mios
//
//  Created by Allen on 5/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "URLRequestHeader.h"

#define KHostHeadURL                [NSString stringWithFormat:@"%@%@",kHostDomain,@""]

// use to compute the url 
#define kRequestURL(url)                [NSString stringWithFormat:KHostHeadURL,url]
#define kUploadImageURL(url)            [NSString stringWithFormat:@"%@%@",kHostDomain, url]