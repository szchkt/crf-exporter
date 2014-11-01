//
//  Variable.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Variable : NSObject

@property (nonatomic) NSString *UUID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger columnIndex;
@property (nonatomic) NSString *measure;
@property (nonatomic) NSString *unit;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
