//
//  CitiesViewController.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitiesViewControllerDelegate
-(void)refreshListWeather:(NSMutableArray*)listWeather;
@end

@interface CitiesViewController : UIViewController <UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (retain, nonatomic) NSMutableArray* listWeather;


@property (nonatomic,retain) id<CitiesViewControllerDelegate> delegate;

@end
