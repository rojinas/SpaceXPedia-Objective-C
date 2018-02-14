//
//  UpcomingLaunchesTableViewController.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/10/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "PastLaunchesViewController.h"
#import "SpaceXApiService.h"
#import "PastLaunchesTableViewCell.h"
#import "Utilities.h"

@interface PastLaunchesViewController ()


@end

@implementation PastLaunchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_models == nil) {
        [self fetchData:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchData:(NSString *) year {
    [self showBusyIndicator];
    _models = nil;
    [SpaceXApiService getPastLaunches:year
                              success:^(NSArray *responseModel) {
                                  [self hideBusyIndicator];
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      if (responseModel != nil && [responseModel isKindOfClass:[NSArray class]] && [responseModel count] > 0) {
                                          _models = responseModel;
                                      } else {
                                          [self showErrorMessage:@"No record to display"];
                                      }
                                      
                                      [self.tableView reloadData];
                                  });
                              }
                              failure:^(NSError *error) {
                                  [self hideBusyIndicator];
                                  [self showErrorMessage:[error localizedDescription]];
                              }];
}

#pragma mark - Table view data source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PastLaunchesTableViewCell *cell = (PastLaunchesTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"PastLaunchCell"];
    if (cell == nil) {
        cell = [[PastLaunchesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"PastLaunchCell"];
    }
    
    NSDictionary *item = [_models objectAtIndex:indexPath.section];
    NSString *key = [[item allKeys] objectAtIndex:indexPath.row];
    NSString *value = [Utilities flattenDictionary:[item objectForKey:key]];
    
    [cell.lblKey setText:[Utilities formatTitle:key]];
    [cell.lblValue setText:value];
    
    [cell.lblKey setNumberOfLines:0];
    [cell.lblKey sizeToFit];
    [cell.lblValue sizeToFit];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *item = (NSDictionary *)[_models objectAtIndex:section];
    return [NSString stringWithFormat:@"%@", [item objectForKey:@"flight_number"]];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *item = (NSDictionary *)[_models objectAtIndex:section];
    return [[item allKeys] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_models != nil) {
        return [_models count];
    } else {
        return 0;
    }
}

- (IBAction)btnMoreClicked:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Date Filter"
                                                                             message:@"Select a Year or Date Range"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Filter Year eg 2017";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Date Range";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Filter"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   UITextField *txtYear = alertController.textFields.firstObject;
                                   UITextField *txtDateRange = [alertController.textFields objectAtIndex:1];
                                   if (txtYear.text.length > 0) {
                                       [self fetchData:txtYear.text];
                                   } else if (txtDateRange.text.length > 0) {
                                       NSLog(@"Year Selected: %@", txtYear.text);
                                   } else {
                                       NSLog(@"Nothing to filtere");
                                   }
                                   
    }];
    
    UIAlertAction *resetAction = [UIAlertAction
                               actionWithTitle:@"Show All"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   [self fetchData:nil];
                               }];
    
    [alertController addAction:okAction];
    [alertController addAction:resetAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

