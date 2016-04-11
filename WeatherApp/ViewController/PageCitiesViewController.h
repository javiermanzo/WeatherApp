//
//  PageCitiesViewController.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/8/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesViewController.h"
#import "EmptyCityViewController.h"

@interface PageCitiesViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate,CitiesViewControllerDelegate,EmptyCityViewControllerDelegate>


@property (retain, nonatomic) NSMutableArray* listWeather;

@end
