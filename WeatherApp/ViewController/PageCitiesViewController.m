//
//  PageCitiesViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/8/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "PageCitiesViewController.h"
#import "CityWeatherTableViewController.h"
#import "SettingsTableViewController.h"
#import "Weather.h"
#import "DayWeather.h"
#import "NetworkingHelper.h"
#import "DataHelper.h"

@interface PageCitiesViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (retain, nonatomic) UIStoryboard *mainStoryboard;
@property (retain, nonatomic) NSMutableArray* listCitiesViewController;
@property (retain, nonatomic) UIBarButtonItem *refreshButton;

@end

@implementation PageCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listCitiesViewController = [NSMutableArray new];
    
    self.mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    self.pageController.delegate = self;
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self configureNavigationBar];
    [self configurePageController];
    
    [self.view bringSubviewToFront:self.pageControl];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)configureNavigationBar{
    
//    self.navigationController.navigationBar.barStyle  = UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:52.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1];
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:52.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *settingsButton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    
    self.refreshButton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refreshCurrentWeather)];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addCityWeather)];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:settingsButton, addButton, nil]];
    
}

-(void)configurePageController{
    if ([self.listWeather count] > 0) {
        [self.navigationItem setRightBarButtonItem:self.refreshButton ];
        CityWeatherTableViewController *initialViewController = [self viewControllerAtIndex:0];
        self.navigationItem.title = initialViewController.cityWeather.cityName;
        
        self.listCitiesViewController = [NSMutableArray arrayWithObject:initialViewController];
        
        [self.pageControl setHidden:NO];
        [self.pageController setViewControllers:self.listCitiesViewController direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        self.pageControl.numberOfPages = [self.listWeather count];
        
    } else {
        [self.pageControl setHidden:YES];
        [self.navigationItem setRightBarButtonItem:nil ];
        EmptyCityViewController* childViewController  = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"EmptyCityViewController"];
        childViewController.delegate = self;
        childViewController.index = 0;
        NSMutableArray* emptyCityArray = [NSMutableArray arrayWithObject:childViewController];
        [self.pageController setViewControllers:emptyCityArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CityWeatherTableViewController *)viewController index];
    
    if (index == 0 || ([self.listWeather count] < 1)) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CityWeatherTableViewController *)viewController index];
    
    index++;
    
    if ((index == [self.listWeather count]) || ([self.listWeather count] < 1)) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    CityWeatherTableViewController *pageContentView = (CityWeatherTableViewController*) pendingViewControllers[0];
    
    self.navigationItem.title = pageContentView.cityWeather.cityName;
    self.pageControl.currentPage = pageContentView.index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CityWeatherTableViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    CityWeatherTableViewController* childViewController  = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"CityWeatherTableViewController"];
    childViewController.cityWeather = (Weather*)[self.listWeather objectAtIndex:index];
    childViewController.index = index;
    BOOL reloadWeatherData = NO;
    
    if (!childViewController.cityWeather.currentCondition) {
        reloadWeatherData = YES;
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *currentDate = [formatter stringFromDate:[NSDate date]];
        
        DayWeather* day = [childViewController.cityWeather.listDaysWeather objectAtIndex:0];
        if (![day.date isEqualToString:currentDate] ) {
            reloadWeatherData = YES;
        }
    }
    
    if (reloadWeatherData) {
        [NetworkingHelper requestWeatherWithCityName:childViewController.cityWeather.cityName doingWithSuccess:^(Weather * weather) {
            
            [self.listWeather replaceObjectAtIndex:childViewController.index withObject:weather];
            [DataHelper saveData:self.listWeather withName:@"listWeather"];
            
            [childViewController refreshWeather:weather];
            
        } andWithError:^(NSString * error) {
            
        }];
    }
    
    return childViewController;
    
}


-(void)refreshCurrentWeather{
    
    CityWeatherTableViewController *viewController = [self.pageController.viewControllers lastObject];
    
    [NetworkingHelper requestWeatherWithCityName:viewController.cityWeather.cityName doingWithSuccess:^(Weather * weather) {
        
        [self.listWeather replaceObjectAtIndex:viewController.index withObject:weather];
        [DataHelper saveData:self.listWeather withName:@"listWeather"];
        
        [viewController refreshWeather:weather];
        
    } andWithError:^(NSString * error) {
        
    }];
}

-(void)addCityWeather{
    
    ListCitiesTableViewController* citiesViewController  = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"ListCitiesTableViewController"];
    citiesViewController.delegate = self;
    citiesViewController.listWeather = self.listWeather;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:citiesViewController];
    
//    [self presentViewController:navigationController animated:YES completion:nil];
    [self.navigationController pushViewController:citiesViewController animated:YES];
}

-(void)showSettings{
    SettingsTableViewController* settingsTableViewController  = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"SettingsTableViewController"];
    
    [self.navigationController pushViewController:settingsTableViewController animated:YES];
}
-(void)refreshListWeather:(NSMutableArray*)listWeather{
    self.listWeather = listWeather;
    self.pageControl.numberOfPages = [self.listWeather count];
    [self configurePageController];
    self.pageController.dataSource = nil;
    self.pageController.dataSource = self;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
