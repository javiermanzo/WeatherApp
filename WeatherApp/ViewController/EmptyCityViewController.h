//
//  EmptyCityViewController.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/10/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyCityViewControllerDelegate
-(void)addCityWeather;
@end

@interface EmptyCityViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (nonatomic,retain) id<EmptyCityViewControllerDelegate> delegate;

@end
