//
//  AbstractTableViewController.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/11/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

// A custom parent class that provides basic features used across all UITaleViewController

@interface AbstractTableViewController : UITableViewController {
    
}

//shows a busy indicator at the center of a ViewController
-(void) showBusyIndicator;

//hides a busy indicator if it is being shown in a ViewController
-(void) hideBusyIndicator;

//show error message as banner
-(void) showErrorMessage:(NSString *) message;

//generic error message
-(void) showGenericError;

@end
