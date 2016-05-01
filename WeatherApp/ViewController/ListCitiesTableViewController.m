//
//  LIstCitiesTableViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/27/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "ListCitiesTableViewController.h"
#import "NetworkingHelper.h"
#import "Weather.h"
#import "UIImageView+Tint.h"
#import "DataHelper.h"

@interface ListCitiesTableViewController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *listSuggestedLocations;
@property BOOL listHasChanged;
@end

@implementation ListCitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listSuggestedLocations = [NSMutableArray new];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = @"Cities";
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(setEditableTableView)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"NavBarLocationSearchResults"];
    

    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,
                                                       self.searchController.searchBar.frame.origin.y,
                                                       self.searchController.searchBar.frame.size.width, 44.0);
    
    self.searchController.searchBar.placeholder = @"Add a new city";
    [self.searchController.searchBar setBackgroundImage:[[UIImage alloc]init]];
    
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor lightGrayColor]];
   
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:52.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1];
     self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:52.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1];
    
 
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listWeather count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SuggestedLocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suggested-location"]];
    [imageView setTintWithColor:[UIColor orangeColor]];
    cell.accessoryView = imageView;
    Weather* weather  = [self.listWeather objectAtIndex:indexPath.row];
    cell.textLabel.text = weather.cityName;
    cell.detailTextLabel.text = weather.countryName;
    return cell;
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        [self.listWeather removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        self.listHasChanged = YES;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setEditableTableView{
    [self.tableView setEditing:!self.tableView.editing];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.listHasChanged) {
        [DataHelper saveData:self.listWeather withName:@"listWeather"];
        [self.delegate refreshListWeather:self.listWeather];
        
    }
    [super viewWillDisappear:animated];
    
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = self.searchController.searchBar.text;
    
    [NetworkingHelper requestSuggestedLocationOf:searchString doingWithSuccess:^(NSMutableArray *listLocations) {
        
        if (self.searchController.searchResultsController) {
            UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
            
            // Present SearchResultsTableViewController as the topViewController
            LocationSearchResultsTableViewController *vc = (LocationSearchResultsTableViewController *)navController.topViewController;
            vc.delegate = self;
            
            // Update searchResults
            self.listSuggestedLocations = listLocations;
            vc.locationResults = self.listSuggestedLocations;
            
            // And reload the tableView with the new data
            [vc.tableView reloadData];
        }
        
    } andWithError:^(NSString *error) {
        
    }];
    
}

-(void)addWeatherCity:(SuggestedLocation*)suggestedLocation{
    self.searchController.active = NO;
    BOOL alreadyAdded = NO;
    for (Weather* weather in self.listWeather) {
        
        if ([weather.cityName isEqualToString:suggestedLocation.areaName] && [weather.countryName isEqualToString:suggestedLocation.country]) {
            alreadyAdded = YES;
            break;
        }
    }
    if (!alreadyAdded) {
        Weather* newWeather = [Weather new];
        if (!self.listWeather) {
            self.listWeather = [NSMutableArray new];
        }
        newWeather.cityName = suggestedLocation.areaName;
        newWeather.countryName = suggestedLocation.country;
        [self.listWeather addObject: newWeather];
        self.listHasChanged = YES;
        
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

// Workaround for bug: -updateSearchResultsForSearchController: is not called when scope buttons change
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

@end
