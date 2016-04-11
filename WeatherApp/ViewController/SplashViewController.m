//
//  SplashViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/8/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "SplashViewController.h"
#import "PageCitiesViewController.h"
#import "AppHelper.h"
#import "DataHelper.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![DataHelper getDistanceUnit]) {
        [DataHelper setDistanceUnit:@"K"];
    }
    if (![DataHelper getTemperatureUnit]) {
        [DataHelper setTemperatureUnit:@"C"];
    }
    
    NSMutableArray* listWeather = (NSMutableArray*)[DataHelper loadDataWithName:@"listWeather"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PageCitiesViewController* pageCitiesViewController  = [mainStoryboard instantiateViewControllerWithIdentifier:@"PageCitiesViewController"];
    pageCitiesViewController.listWeather = listWeather;
    
    UINavigationController * navController = [[UINavigationController alloc]init];
    
    [navController addChildViewController:pageCitiesViewController];
    
    [AppHelper changeRootViewController:navController fromViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
