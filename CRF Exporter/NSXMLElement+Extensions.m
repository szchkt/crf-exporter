//
//  NSXMLElement+Extensions.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 28/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "NSXMLElement+Extensions.h"

@implementation NSXMLElement (Extensions)

- (NSXMLElement *)elementForName:(NSString *)name attributeName:(NSString *)attribute value:(NSString *)value
{
    for (NSXMLElement *element in [self elementsForName:name]) {
        if ([[[element attributeForName:attribute] stringValue] isEqualToString:value]) {
            return element;
        }
    }

    return nil;
}

@end
