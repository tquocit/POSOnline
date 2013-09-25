//
//  BaseTableViewController.h
//  MyBaseProject
//
//  Created by Torin on 1/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCViewController.h"

@interface BaseTableViewController : EGCViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *lblInstruction;

@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, strong) NSArray *dataArray;

- (void)deselectAllCellsAnimated:(BOOL)animated;

- (void)fadeInTableView;
- (void)fadeOutTableView;
- (void)fadeInTableViewOnCompletion:(void (^)(BOOL finished))completion;
- (void)fadeOutTableViewOnCompletion:(void (^)(BOOL finished))completion;

- (void)refreshTableViewAnimated:(BOOL)animated;
- (void)refreshTableViewOnCompletion:(void (^)(BOOL finished))completion;

@end
