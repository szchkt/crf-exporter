//
//  NSXMLElement+Extensions.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 28/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXMLElement (Extensions)

- (NSXMLElement *)elementForName:(NSString *)name attributeName:(NSString *)attribute value:(NSString *)value;

@end
