//
//  RocketDataTableCellTableViewCell.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RocketDataTableCell : UITableViewCell {
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblStages;
@property (weak, nonatomic) IBOutlet UILabel *lblBoosters;
@property (weak, nonatomic) IBOutlet UILabel *lblCostPerLaunch;
@property (weak, nonatomic) IBOutlet UILabel *lblSuccessRatePct;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end
