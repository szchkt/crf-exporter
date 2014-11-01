//
//  ViewController.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 25/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, readonly) Document *document;

@property (strong) IBOutlet NSArrayController *yearsArrayController;

@property (nonatomic) NSInteger selectedYearIndex;

@property (weak) IBOutlet NSTableView *outputTableView;

- (IBAction)browse:(id)sender;

- (IBAction)updateWorksheets:(id)sender;

- (IBAction)update:(id)sender;

@end
