//
//  WASASICacheAdapter.h
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASBaseAdapter.h"
//@class WASASIAdapter;

/**
 *	@brief	This class is for cache the succeed HTTP request and response
 */
@interface WASASICacheAdapter : WASBaseAdapter
/**
 *	@brief	decorate the appoint adapter
 *
 *	@param 	adapter 	adapter needed to be decoreated
 *
 *	@return	return value self
 */
- (id) initWithAdapter:(WASBaseAdapter *)adapter;
@end
