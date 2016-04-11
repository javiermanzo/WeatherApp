//
//  EmptyCityViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/10/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "EmptyCityViewController.h"

@interface EmptyCityViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation EmptyCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addButton.layer.borderWidth = 2.0f;
    self.addButton.layer.borderColor= [[UIColor colorWithRed:52.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1] CGColor];
    self.addButton.layer.cornerRadius = self.addButton.frame.size.height/2;
    self.addButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCityAction:(id)sender {
    [self.delegate addCityWeather];
}

@end
