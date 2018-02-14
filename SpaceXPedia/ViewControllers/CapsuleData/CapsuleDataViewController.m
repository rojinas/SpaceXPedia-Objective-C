//
//  CapsuleDataViewController.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "CapsuleDataViewController.h"
#import "SpaceXApiService.h"
#import "CapsulDataTableCell.h"
#import "Utilities.h"

@interface CapsuleDataViewController ()

@end

@implementation CapsuleDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_models == nil) {
        [self showBusyIndicator];
        [SpaceXApiService getCapsuleData:nil
                                 success:^(NSArray *responseModel) {
                                     [self hideBusyIndicator];
                                     _models = responseModel;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [self.tableView setDelegate:self];
                                         [self.tableView setDataSource:self];
                                         [self.tableView reloadData];
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

#pragma mark - UITableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CapsulDataTableCell *cell = (CapsulDataTableCell *) [tableView dequeueReusableCellWithIdentifier:@"CapsuleCell"];
    NSDictionary *item = [_models objectAtIndex:indexPath.section];
    NSString *key = [[item allKeys] objectAtIndex:indexPath.row];
    NSString *value = [Utilities flattenDictionary:[item objectForKey:key]];
    
    [cell.lblKey setText:[Utilities formatTitle:key]];
    [cell.lblValue setText:value];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *item = (NSDictionary *)[_models objectAtIndex:section];
    return [NSString stringWithFormat:@"%@ :: %@", [item objectForKey:@"name"], [item objectForKey:@"id"]];
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

@end
