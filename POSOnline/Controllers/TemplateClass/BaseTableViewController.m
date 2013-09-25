//
//  BaseTableViewController.m
//  MyBaseProject
//
//  Created by Torin on 1/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
@property (nonatomic, strong) UITableViewCell * activeTableViewCell;
@end

@implementation BaseTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //In case we forget linking in IB
  if (self.tableView == nil)
    for (UITableView * tableview in self.view.subviews)
      if ([tableview isKindOfClass:[UITableView class]])
        self.tableView = tableview;
  
  //In case we forget linking in IB
  if (self.tableView.delegate == nil)     self.tableView.delegate = self;
  if (self.tableView.dataSource == nil)   self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self deselectAllCellsAnimated:YES];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.dataArray count];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  self.activeTextField = textField;
  
  UIView * superview = [self.activeTextField superview];
  while (superview != nil && [superview isKindOfClass:[UITableViewCell class]] == NO)
    superview = [superview superview];
  if ([superview isKindOfClass:[UITableViewCell class]])
    self.activeTableViewCell = (UITableViewCell*)superview;
  
  //Scroll to that index
  if (self.activeTableViewCell != nil)
    [self.tableView scrollRectToVisible:self.activeTableViewCell.frame animated:YES];

  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  return YES;
}



#pragma mark - Helpers

- (void)deselectAllCellsAnimated:(BOOL)animated
{
  for (UITableViewCell *cell in self.tableView.visibleCells)
  {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
  }
}

- (void)fadeInTableView
{
  [self fadeInTableViewOnCompletion:nil];
}

- (void)fadeInTableViewOnCompletion:(void (^)(BOOL finished))completion 
{
  [UIView animateWithDuration:0.3 animations:^{
    self.tableView.alpha = 1;
  } completion:completion];
}

- (void)fadeOutTableView
{
  [self fadeOutTableViewOnCompletion:nil];
}

- (void)fadeOutTableViewOnCompletion:(void (^)(BOOL finished))completion
{
  [UIView animateWithDuration:0.3 animations:^{
    self.tableView.alpha = 0;
  } completion:completion];
}

- (void)refreshTableViewAnimated:(BOOL)animated
{
  if (animated == NO) {
    [self.tableView reloadData];
    
    if (self.dataArray != nil) {
      self.tableView.hidden = [self.dataArray count] <= 0;
      self.lblInstruction.hidden = !self.tableView.hidden;
    }
    return;
  }
  
  [self refreshTableViewOnCompletion:nil];
}

- (void)refreshTableViewOnCompletion:(void (^)(BOOL finished))completion
{
  [self fadeOutTableViewOnCompletion:^(BOOL finished) {
    [self.tableView reloadData];
    
    if (self.dataArray != nil) {
      self.tableView.hidden = [self.dataArray count] <= 0;
      self.lblInstruction.hidden = !self.tableView.hidden;
    }
    [self fadeInTableViewOnCompletion:completion];
  }];
}

@end
