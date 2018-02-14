//
//  RocketDataViewController.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "RocketDataViewController.h"
#import "SpaceXApiService.h"
#import "RocketDataTableCell.h"


@interface RocketDataViewController ()

@end

@implementation RocketDataViewController

- (IBAction)tableViewRefresh:(id)sender {
    [self loadData:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    if (_models == nil) {
        [self loadData:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadData:(id)sender {
    [self showBusyIndicator];
    [SpaceXApiService getRocketDataAsModelList:nil
                                       success:^(NSMutableArray *responseModel) {
                                           [self hideBusyIndicator];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (responseModel != nil && [responseModel isKindOfClass:[NSArray class]]) {
                                                   _models = responseModel;
                                                   [self.tableView setDelegate:self];
                                                   [self.tableView setDataSource:self];
                                                   [self.tableView reloadData];
                                                   [sender endRefreshing];
                                               } else {
                                                   [self showErrorMessage:@"No record to display"];
                                               }
                                           });
                                       }
                                       failure:^(NSError *error) {
                                           [self hideBusyIndicator];
                                           [sender endRefreshing];
                                           [self showErrorMessage:[error localizedDescription]];
                                       }];
}


#pragma mark - TableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RocketDataTableCell *cell = (RocketDataTableCell *) [tableView dequeueReusableCellWithIdentifier:@"RocketCell"];
    if (cell == nil) {
        cell = [[RocketDataTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RocketCell"];
    }

    RocketModel *rocketModel = (RocketModel *) [_models objectAtIndex:indexPath.section];
    [cell.lblName setText:rocketModel.id];
    [cell.lblType setText:rocketModel.type];
    [cell.lblStages setText:[NSString stringWithFormat:@"%lu", rocketModel.stages]];
    [cell.lblBoosters setText:[NSString stringWithFormat:@"%lu", rocketModel.boosters]];
    [cell.lblCostPerLaunch setText:[NSString stringWithFormat:@"%lu", rocketModel.costPerLaunch]];
    [cell.lblSuccessRatePct setText:[NSString stringWithFormat:@"%lu", rocketModel.successRatePct]];
    [cell.lblDescription setText:rocketModel.description];
    
    [cell.lblCountry setText:rocketModel.country];
    [cell.lblCompany setText:rocketModel.company];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    RocketModel *rocketModel = (RocketModel *) [_models objectAtIndex:section];
    return rocketModel.name;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_models != nil) {
        return [_models count];
    } else {
        return 0;
    }
}


@end
