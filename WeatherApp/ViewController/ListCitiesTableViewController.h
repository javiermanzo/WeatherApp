//
//  LIstCitiesTableViewController.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/27/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationSearchResultsTableViewController.h"
#import "SuggestedLocation.h"

@protocol ListCitiesTableViewControllerDelegate
-(void)refreshListWeather:(NSMutableArray*)listWeather;
@end

@interface ListCitiesTableViewController : UITableViewController <UISearchResultsUpdating,UISearchBarDelegate,LocationSearchResultsTableViewControllerDelegate>

@property (retain, nonatomic) NSMutableArray* listWeather;
@property (nonatomic,retain) id<ListCitiesTableViewControllerDelegate> delegate;

@end
