//
//  ViewController.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 25/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "ViewController.h"

#import "Document.h"
#import "Row.h"
#import "Variable.h"
#import "Year.h"
#import "ValueDictionary.h"
#import "NSArrayController+Extensions.h"
#import "NSXMLElement+Extensions.h"

typedef NS_ENUM(NSInteger, ViewControllerButton) {
    ViewControllerButtonBrowseSource = 1,
    ViewControllerButtonBrowsePartyProfile = 2
};

@interface ViewController () {
    NSNumberFormatter *_formatter;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _formatter = [[NSNumberFormatter alloc] init];
    _formatter.numberStyle = NSNumberFormatterDecimalStyle;
    _formatter.usesGroupingSeparator = NO;
    _formatter.maximumFractionDigits = 3;

    self.yearsArrayController.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES]];
}

+ (NSSet *)keyPathsForValuesAffectingDocument
{
    return [NSSet setWithObject:@"view.window.windowController.document"];
}

- (Document *)document
{
    return [self.view.window.windowController document];
}

- (void)setSelectedYearIndex:(NSInteger)selectedYearIndex
{
    _selectedYearIndex = selectedYearIndex;
    [self.outputTableView reloadData];
}

- (IBAction)browse:(id)sender
{
    ViewControllerButton button = [sender tag];

    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseDirectories = NO;
    openPanel.canChooseFiles = YES;

    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            switch (button) {
                case ViewControllerButtonBrowseSource:
                    self.document.sourceFilePath = [openPanel.URL path];
                    break;

                case ViewControllerButtonBrowsePartyProfile:
                    self.document.partyProfileFilePath = [openPanel.URL path];
                    break;
            }
        }
    }];
}

- (IBAction)updateWorksheets:(id)sender
{
    Document *document = self.document;
    NSError *error = nil;
    NSXMLDocument *sourceDocument = [[NSXMLDocument alloc] initWithContentsOfURL:[NSURL fileURLWithPath:document.sourceFilePath] options:0 error:&error];
    if (!sourceDocument) {
        NSLog(@"%@", error);
        return;
    }

    NSXMLElement *rootElement = [sourceDocument rootElement];

    NSUInteger selectedWorksheetIndex = document.selectedWorksheetIndex;

    NSMutableArray *worksheets = [document mutableArrayValueForKey:@"worksheets"];
    [worksheets removeAllObjects];

    for (NSXMLElement *element in [rootElement elementsForName:@"Worksheet"]) {
        NSString *worksheetName = [[element attributeForName:@"Name"] stringValue];
        if ([worksheetName length]) {
            [worksheets addObject:worksheetName];
        }
    }

    if (selectedWorksheetIndex < [worksheets count]) {
        document.selectedWorksheetIndex = selectedWorksheetIndex;
    }
}

- (IBAction)update:(id)sender
{
    Document *document = self.document;
    NSError *error = nil;
    NSXMLDocument *sourceDocument = [[NSXMLDocument alloc] initWithContentsOfURL:[NSURL fileURLWithPath:document.sourceFilePath] options:0 error:&error];
    if (!sourceDocument) {
        NSLog(@"%@", error);
        return;
    }

    NSDictionary *locale = @{NSLocaleDecimalSeparator: @"."};
    NSCharacterSet *nonDigits = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];

    [self.yearsArrayController removeAllObjects];

    NSXMLElement *rootElement = [sourceDocument rootElement];

    NSXMLElement *worksheetElement = [rootElement elementForName:@"Worksheet" attributeName:@"Name" value:document.worksheets[document.selectedWorksheetIndex]];

    NSXMLElement *tableElement = [[worksheetElement elementsForName:@"Table"] firstObject];

    NSArray *rowElements = [tableElement elementsForName:@"Row"];
    NSUInteger rowElementCount = [rowElements count];
    NSUInteger yearRowCount = document.rowCount;

    for (NSUInteger i = 0; i + yearRowCount <= rowElementCount; i += yearRowCount) {
        if (i + document.yearRowIndex >= rowElementCount)
            continue;

        NSXMLElement *yearRowElement = rowElements[i + document.yearRowIndex];
        NSArray *yearCellElements = [yearRowElement elementsForName:@"Cell"];

        if (document.yearColumnIndex >= [yearCellElements count])
            continue;

        NSXMLElement *yearDataElement = [[yearCellElements[document.yearColumnIndex] elementsForName:@"Data"] firstObject];
        if (!yearDataElement)
            continue;

        NSInteger yearValue = [[[yearDataElement stringValue] stringByTrimmingCharactersInSet:nonDigits] integerValue];
        if (!yearValue)
            continue;

        Year *year = [[Year alloc] initWithYear:yearValue];

        for (Row *row in document.rows) {
            if (i + row.rowIndex < rowElementCount) {
                NSXMLElement *rowElement = rowElements[i + row.rowIndex];
                NSArray *cellElements = [rowElement elementsForName:@"Cell"];

                ValueDictionary *values = [[ValueDictionary alloc] init];
                year[row] = values;

                for (Variable *variable in document.variables) {
                    if (variable.columnIndex < [cellElements count]) {
                        NSXMLElement *cellElement = cellElements[variable.columnIndex];
                        NSXMLElement *dataElement = [[cellElement elementsForName:@"Data"] firstObject];

                        NSString *stringValue = [dataElement stringValue];
                        if ([stringValue length]) {
                            NSNumber *value = [[NSDecimalNumber alloc] initWithString:stringValue locale:locale];
                            values[variable] = value;
                        }
                    }
                }
            }
        }
        
        [self.yearsArrayController addObject:year];
    }

    for (NSTableColumn *column in [self.outputTableView.tableColumns copy]) {
        [self.outputTableView removeTableColumn:column];
    }

    NSTableColumn *rowColumn = [[NSTableColumn alloc] initWithIdentifier:@"0"];
    rowColumn.title = NSLocalizedString(@"Row", nil);
    [self.outputTableView addTableColumn:rowColumn];

    NSTableColumn *categoryColumn = [[NSTableColumn alloc] initWithIdentifier:@"1"];
    categoryColumn.title = NSLocalizedString(@"Category", nil);
    [self.outputTableView addTableColumn:categoryColumn];

    NSTableColumn *gasColumn = [[NSTableColumn alloc] initWithIdentifier:@"2"];
    gasColumn.title = NSLocalizedString(@"Gas", nil);
    [self.outputTableView addTableColumn:gasColumn];

    NSInteger i = 3;
    for (Variable *variable in document.variables) {
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:[@(i) stringValue]];
        column.title = variable.name;
        [self.outputTableView addTableColumn:column];
        i++;
    }

    [self.outputTableView reloadData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger yearIndex = self.selectedYearIndex;
    if (yearIndex < 0 || yearIndex >= [self.yearsArrayController.content count]) {
        return 0;
    }

    return [self.document.rows count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex
{
    Row *row = self.document.rows[rowIndex];

    NSInteger column = [tableColumn.identifier integerValue];
    switch (column) {
        case 0:
            return [@(row.rowIndex) stringValue];

        case 1:
            return row.category;

        case 2:
            return row.gas;
    }

    Year *year = self.yearsArrayController.arrangedObjects[self.selectedYearIndex];
    ValueDictionary *values = year[row];
    Variable *variable = self.document.variables[column - 3];

    return [_formatter stringFromNumber:values[variable]];
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSView *view = [tableView makeViewWithIdentifier:@"Cell" owner:self];
    return view;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

@end
