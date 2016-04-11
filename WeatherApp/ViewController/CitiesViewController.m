//
//  CitiesViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "CitiesViewController.h"
#import "NetworkingHelper.h"
#import "Weather.h"
#import "SuggestedLocation.h"
#import "UIImageView+Tint.h"
#import "DataHelper.h"


@interface CitiesViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listSuggestedLocations;

@property BOOL listHasChanged;

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listSuggestedLocations = [NSMutableArray new];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = @"Cities";
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(setEditableTableView)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    self.searchBar.placeholder = @"Add a new city";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor darkGrayColor]];

    [self.searchBar setBackgroundImage:[[UIImage alloc]init]];
    
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.listSuggestedLocations count];
    } else {
        return [self.listWeather count];
        
    }
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [controller.searchResultsTableView setBackgroundColor:[UIColor whiteColor]];
    [controller.searchResultsTableView setSeparatorColor:[UIColor lightGrayColor]];
    [controller.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    controller.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([searchText length] > 1) {
        
        [NetworkingHelper requestSuggestedLocationOf:searchText doingWithSuccess:^(NSMutableArray *listLocations) {
            if([searchText length]>1){
                self.listSuggestedLocations = listLocations;
            }
            
            [self.searchDisplayController.searchResultsTableView reloadData];
        } andWithError:^(NSString *error) {
            
        }];
        
    } else {
        self.listSuggestedLocations = nil;
    }
    
}

-(void)setEditableTableView{
    [self.tableView setEditing:!self.tableView.editing];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SuggestedLocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suggested-location"]];
        [imageView setTintWithColor:[UIColor orangeColor]];
        cell.accessoryView = imageView;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        
        SuggestedLocation* suggestedLocation = (SuggestedLocation*) [self.listSuggestedLocations objectAtIndex:indexPath.row];
        cell.textLabel.text = suggestedLocation.areaName;
        cell.detailTextLabel.text = suggestedLocation.country;
        
        
        
        return cell;
        
    }else {
        Weather* weather  = [self.listWeather objectAtIndex:indexPath.row];
        cell.textLabel.text = weather.cityName;
        cell.detailTextLabel.text = weather.countryName;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        SuggestedLocation* suggestedLocation = (SuggestedLocation*) [self.listSuggestedLocations objectAtIndex:indexPath.row];
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
        
        [self.searchDisplayController setActive:NO animated:YES];
        
        [self.tableView reloadData];
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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


- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.listHasChanged) {
        [DataHelper saveData:self.listWeather withName:@"listWeather"];
        [self.delegate refreshListWeather:self.listWeather];
        
    }
    [super viewWillDisappear:animated];
    
}


@end
