//
//  UpcomingLaunchesTableViewController.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/10/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "UpcomingLaunchesTableViewController.h"
#import "SpaceXApiService.h"
#import "UpcomingLaunchesTableViewCell.h"
#import "Utilities.h"

@interface UpcomingLaunchesTableViewController ()

@end

@implementation UpcomingLaunchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_models == nil) {
        [self showBusyIndicator];
        [SpaceXApiService getUpcomingLaunches:nil
                                      success:^(NSArray *responseModel) {
                                          [self hideBusyIndicator];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (responseModel != nil && [responseModel isKindOfClass:[NSArray class]]) {
                                                  _models = responseModel;
                                                  [self.tableView setDelegate:self];
                                                  [self.tableView setDataSource:self];
                                                  [self.tableView reloadData];
                                              } else {
                                                  [self showErrorMessage:@"No record to display"];
                                              }
                                          });
                                      }
                                      failure:^(NSError *error) {
                                          [self hideBusyIndicator];
                                          [self showErrorMessage:[error localizedDescription]];
                                      }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UpcomingLaunchesTableViewCell *cell = (UpcomingLaunchesTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"UpcomingLaunchCell"];
    if (cell == nil) {
        cell = [[UpcomingLaunchesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"UpcomingLaunchCell"];
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
    if ([item objectForKey:@"flight_number"] != nil) {
        return [NSString stringWithFormat:@"%@", [item objectForKey:@"flight_number"]];
    }
    
    return @"Flight Number not found";
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[_models objectAtIndex:section] isKindOfClass:[NSDictionary class]]){
        NSDictionary *item = (NSDictionary *)[_models objectAtIndex:section];
        return [[item allKeys] count];
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_models != nil && [_models isKindOfClass:[NSArray class]]) {
        return [_models count];
    } else {
        return 0;
    }
}

@end
