//
//  CityWeatherTableViewController.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/6/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface CityWeatherTableViewController : UITableViewController

@property (retain, nonatomic) Weather* cityWeather;
@property (assign, nonatomic) NSInteger index;

-(void)refreshWeather:(Weather*)weather;

@end
