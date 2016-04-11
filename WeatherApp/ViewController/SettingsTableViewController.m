//
//  SettingsTableViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/10/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "DataHelper.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *distanceSegmentedControl;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Settings";
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if ([[DataHelper getDistanceUnit] isEqualToString:@"K"]) {
        [self.distanceSegmentedControl setSelectedSegmentIndex:0];
    } else {
        [self.distanceSegmentedControl setSelectedSegmentIndex:1];
    }
    
    if ([[DataHelper getTemperatureUnit] isEqualToString:@"C"]) {
        [self.temperatureSegmentedControl setSelectedSegmentIndex:0];
    } else {
        [self.temperatureSegmentedControl setSelectedSegmentIndex:1];
    }
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    
    if (segmentedControl == self.temperatureSegmentedControl) {
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            [DataHelper setTemperatureUnit:@"C"];
        } else{
            [DataHelper setTemperatureUnit:@"F"];
        }
    } else {
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            [DataHelper setDistanceUnit:@"K"];
        } else{
            [DataHelper setDistanceUnit:@"M"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
