//
//  RocketDataViewController.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractTableViewController.h"

@interface RocketDataViewController : AbstractTableViewController {
    
}

@property (atomic, readwrite, strong) NSMutableArray *models;

@end
