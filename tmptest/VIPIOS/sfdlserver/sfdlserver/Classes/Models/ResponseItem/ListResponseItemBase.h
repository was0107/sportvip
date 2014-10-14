//
//  ListResponseItemBase.h
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListResponseItemBase : NSObject

/**
 *  @brief  init from NSDictionary
 *
 *  @param [in]  N/A    dictionary
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
- (id) initWithDictionary:(const NSDictionary *) dictionary;

/**
 *  @brief  stringObject from NSDictionary
 *
 *  @param [in]  N/A    dictionary  key
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
-(NSString *)stringObjectFrom:(const NSDictionary *)dictionary withKey:(NSString *)key;

/**
 *  @brief  integerValue from NSDictionary
 *
 *  @param [in]  N/A    dictionary   key
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
-(NSInteger)integerValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key;


/**
 *  @brief  floatValue from NSDictionary
 *
 *  @param [in]  N/A    dictionary   key
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
-(CGFloat)floatValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key;

/**
 *  @brief  boolValue from NSDictionary
 *
 *  @param [in]  N/A    dictionary   key
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
-(BOOL)boolValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key;

/**
 *  @brief  dateValue from NSDictionary
 *
 *  @param [in]  N/A    dictionary   key
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
-(NSDate *)dateObjectFrom:(const NSDictionary *)dictionary withKey:(NSString *)key;

@end
