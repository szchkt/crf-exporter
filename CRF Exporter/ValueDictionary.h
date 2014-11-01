//
//  ValueDictionary.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 27/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;

@interface ValueDictionary : NSObject

- (NSNumber *)objectForKeyedSubscript:(Variable *)key;
- (void)setObject:(NSNumber *)value forKeyedSubscript:(Variable *)key;

@end
