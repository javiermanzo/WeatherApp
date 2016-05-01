//
//  SearchResultsTableViewController.h
//  UISearchControllerDemo
//
//  Created by Jason Hoffman on 1/13/15.
//  Copyright (c) 2015 JHM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestedLocation.h"

@protocol LocationSearchResultsTableViewControllerDelegate
-(void)addWeatherCity:(SuggestedLocation*)suggestedLocation;
@end


@interface LocationSearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *locationResults;

@property (nonatomic,retain) id<LocationSearchResultsTableViewControllerDelegate> delegate;

@end
