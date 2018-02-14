//
//  AbstractTableViewController.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/11/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "AbstractTableViewController.h"
#import "AFMInfoBanner.h"

@interface AbstractTableViewController ()

@end

@implementation AbstractTableViewController

bool busyIndicatorOn;
UILabel *strLabel;
UIActivityIndicatorView *activityIndicator;
UIVisualEffectView *effectView;

#pragma mark Core Foundation Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    busyIndicatorOn = false;
    activityIndicator = [[UIActivityIndicatorView alloc] init];
    effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    strLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 160, 46)];
    [strLabel setText:@"Please wait.."];
    [strLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    [strLabel setTextColor:[UIColor colorWithWhite:0.9 alpha:0.7]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Activity Indicator
-(void) showBusyIndicator {
    if (!busyIndicatorOn) {
        busyIndicatorOn = true;
        
        if (strLabel != nil) {
            [strLabel removeFromSuperview];
            [activityIndicator removeFromSuperview];
            [effectView removeFromSuperview];
        }
        
        [effectView setFrame:CGRectMake((self.view.frame.size.width - self.view.frame.origin.x)/2 - strLabel.frame.size.width/2,
                                        (self.view.frame.size.height -  self.view.frame.origin.y)/2 - strLabel.frame.size.height/2,
                                        160,
                                        46)];
        
        [activityIndicator setFrame:CGRectMake(0, 0, 46, 46)];
        [activityIndicator startAnimating];
        [[effectView contentView] addSubview:activityIndicator];
        [[effectView contentView] addSubview:strLabel];
        [self.view addSubview:effectView];
    }
}

-(void) hideBusyIndicator {
    if (busyIndicatorOn) {
        busyIndicatorOn = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            [effectView removeFromSuperview];
        });
    }
}

#pragma mark Banner messages

-(void) showErrorMessage:(NSString *) message {
    NSLog(@"%@", message);
    dispatch_async(dispatch_get_main_queue(), ^{
        [AFMInfoBanner showWithText:message style:AFMInfoBannerStyleError andHideAfter:2.0];
    });
}

-(void) showGenericError {
    [self showErrorMessage:@"Error occured, please check your network connection"];
}

@end
