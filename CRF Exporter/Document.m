//
//  Document.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 25/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "Document.h"

#import "Variable.h"
#import "Row.h"
#import "NSObject+Extensions.h"

static NSString *const kSourceFilePathKey = @"sourcePath";
static NSString *const kPartyProfileFilePathKey = @"profilePath";
static NSString *const kVariablesKey = @"variables";
static NSString *const kRowsKey = @"rows";
static NSString *const kWorksheetsKey = @"worksheets";
static NSString *const kSelectedWorksheetIndexKey = @"worksheetIndex";
static NSString *const kYearRowIndexKey = @"yearRowIndex";
static NSString *const kYearColumnIndexKey = @"yearColumnIndex";
static NSString *const kRowCountKey = @"rowCount";

@interface Document ()

@end

@implementation Document

- (instancetype)init
{
    self = [super init];
    if (self) {
        _variables = [[NSMutableArray alloc] init];
        _rows = [[NSMutableArray alloc] init];
        _worksheets = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (void)makeWindowControllers
{
    // Override to return the Storyboard file name of the document.
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    NSArray *arrangedVariables = self.variables;
    NSMutableArray *variables = [[NSMutableArray alloc] initWithCapacity:[arrangedVariables count]];

    for (Variable *variable in arrangedVariables) {
        [variables addObject:[variable dictionaryRepresentation]];
    }

    NSArray *arrangedRows = self.rows;
    NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:[arrangedRows count]];

    for (Row *row in arrangedRows) {
        [rows addObject:[row dictionaryRepresentation]];
    }

    NSDictionary *document = @{kSourceFilePathKey: self.sourceFilePath ?: [NSNull null],
                               kPartyProfileFilePathKey: self.partyProfileFilePath ?: [NSNull null],
                               kVariablesKey: variables,
                               kRowsKey: rows,
                               kWorksheetsKey: self.worksheets,
                               kSelectedWorksheetIndexKey: @(self.selectedWorksheetIndex),
                               kYearRowIndexKey: @(self.yearRowIndex),
                               kYearColumnIndexKey: @(self.yearColumnIndex),
                               kRowCountKey: @(self.rowCount)};

    return [NSJSONSerialization dataWithJSONObject:document options:NSJSONWritingPrettyPrinted error:outError];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    NSDictionary *document = [NSJSONSerialization JSONObjectWithData:data options:0 error:outError];
    if (![document isKindOfClass:[NSDictionary class]]) {
        return NO;
    }

    self.sourceFilePath = [document[kSourceFilePathKey] nonNullValue];
    self.partyProfileFilePath = [document[kPartyProfileFilePathKey] nonNullValue];

    NSMutableArray *variables = [self mutableArrayValueForKey:@"variables"];
    [variables removeAllObjects];
    NSMutableArray *rows = [self mutableArrayValueForKey:@"rows"];
    [rows removeAllObjects];

    for (NSDictionary *variableDictionary in document[kVariablesKey]) {
        Variable *variable = [[Variable alloc] initWithDictionary:variableDictionary];
        [variables addObject:variable];
    }

    for (NSDictionary *rowDictionary in document[kRowsKey]) {
        Row *row = [[Row alloc] initWithDictionary:rowDictionary];
        [rows addObject:row];
    }

    NSMutableArray *worksheets = [self mutableArrayValueForKey:@"worksheets"];
    [worksheets removeAllObjects];
    [worksheets addObjectsFromArray:document[kWorksheetsKey]];

    self.selectedWorksheetIndex = [document[kSelectedWorksheetIndexKey] unsignedIntegerValue];

    self.yearRowIndex = [document[kYearRowIndexKey] unsignedIntegerValue];
    self.yearColumnIndex = [document[kYearColumnIndexKey] unsignedIntegerValue];

    self.rowCount = [document[kRowCountKey] unsignedIntegerValue];

    return YES;
}

@end
