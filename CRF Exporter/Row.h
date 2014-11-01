//
//  Row.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;

@interface Row : NSObject

@property (nonatomic) NSString *UUID;
@property (nonatomic) NSInteger rowIndex;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *classification;
@property (nonatomic) NSString *method;
@property (nonatomic) NSString *target;
@property (nonatomic) NSString *option;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *gas;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
