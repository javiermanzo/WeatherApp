//
//  SearchResultsTableViewController.m
//  UISearchControllerDemo
//
//  Created by Jason Hoffman on 1/13/15.
//  Copyright (c) 2015 JHM. All rights reserved.
//

#import "LocationSearchResultsTableViewController.h"
#import "UIImageView+Tint.h"

@interface LocationSearchResultsTableViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation LocationSearchResultsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return [self.locationResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suggested-location"]];
    [imageView setTintWithColor:[UIColor orangeColor]];
    cell.accessoryView = imageView;
    
    SuggestedLocation* suggestedLocation = (SuggestedLocation*) [self.locationResults objectAtIndex:indexPath.row];
    cell.textLabel.text = suggestedLocation.areaName;
    cell.detailTextLabel.text = suggestedLocation.country;
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SuggestedLocation* suggestedLocation = (SuggestedLocation*) [self.locationResults objectAtIndex:indexPath.row];
    [self.delegate addWeatherCity:suggestedLocation];
     [super viewWillDisappear:YES];
     
}


@end
