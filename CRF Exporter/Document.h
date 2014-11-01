//
//  Document.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 25/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument

@property (nonatomic) NSString *sourceFilePath;
@property (nonatomic) NSString *partyProfileFilePath;

@property (nonatomic, readonly) NSMutableArray *variables;
@property (nonatomic, readonly) NSMutableArray *rows;

@property (nonatomic, readonly) NSMutableArray *worksheets;
@property (nonatomic) NSUInteger selectedWorksheetIndex;

@property (nonatomic) NSUInteger yearRowIndex;
@property (nonatomic) NSUInteger yearColumnIndex;

@property (nonatomic) NSUInteger rowCount;

@end
