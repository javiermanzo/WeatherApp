//
//  CityWeatherTableViewController.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/6/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "CityWeatherTableViewController.h"
#import "DayWeather.h"
#import "UIImageView+WebCache.h"
#import "DataHelper.h"

@interface CityWeatherTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelTempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipLabel;

@end

@implementation CityWeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fillWeatherData];
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fillWeatherData{
    
    self.title = self.cityWeather.cityName;
    
    if (self.cityWeather.currentCondition) {
        if ([[DataHelper getDistanceUnit] isEqualToString:@"K"]) {
            self.windLabel.text = [NSString stringWithFormat:@"%@ kmph", self.cityWeather.currentCondition.windSpeedKmph];
        } else {
            self.windLabel.text = [NSString stringWithFormat:@"%@ mph", self.cityWeather.currentCondition.windSpeedMiles];
        }
        
        if ([[DataHelper getTemperatureUnit] isEqualToString:@"C"]) {
            self.tempLabel.text = [NSString stringWithFormat:@"%@ºC", self.cityWeather.currentCondition.tempC];
            self.feelTempLabel.text = [NSString stringWithFormat:@"Feels like %@ºC", self.cityWeather.currentCondition.feelsLikeC];
        } else {
            self.tempLabel.text = [NSString stringWithFormat:@"%@ºF", self.cityWeather.currentCondition.tempF];
            self.feelTempLabel.text = [NSString stringWithFormat:@"Feels like %@ºF", self.cityWeather.currentCondition.feelsLikeF];
            
        }
        
        self.tempDescLabel.text = self.cityWeather.currentCondition.weatherDesc;
        
        self.windDirLabel.text = self.cityWeather.currentCondition.windDir6Points;
        self.humidityLabel.text = [NSString stringWithFormat:@"%@%%", self.cityWeather.currentCondition.humidity];
        self.precipLabel.text = [NSString stringWithFormat:@"%@ mm", self.cityWeather.currentCondition.precipMM];
        
        [self.tempImageView sd_setImageWithURL:[NSURL URLWithString:self.cityWeather.currentCondition.weatherIconUrl] placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            self.tempImageView.layer.cornerRadius = self.tempImageView.frame.size.height/2;
            self.tempImageView.layer.masksToBounds = YES;
            self.tempImageView.image =image;
            
        }];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0){
        return [super tableView:tableView numberOfRowsInSection:section];
    } else
        return self.cityWeather.listDaysWeather.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    } else {
        return 40
        ;
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"DailyWeatherCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.textLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightThin]];
            
            
            UILabel *mintTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-20, 3, 70, 18)];
            mintTempLabel.tag = 1;
            [mintTempLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightThin]];
            [cell.contentView addSubview:mintTempLabel];
            
            UILabel *maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-20, 22, 70, 18)];
            maxTempLabel.tag = 2;
            [maxTempLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightThin]];
            [cell.contentView addSubview:maxTempLabel];
            
            UIView* bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-3, self.view.frame.size.width, 1)];
            bottomBorder.backgroundColor = [UIColor lightGrayColor];
            bottomBorder.alpha = 0.5f;
            [cell.contentView addSubview:bottomBorder];
        }
        
        DayWeather* dayWeather = [self.cityWeather.listDaysWeather objectAtIndex:indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date = [dateFormatter dateFromString:dayWeather.date];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
        
        NSInteger weekday = [components weekday];
        NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
        
        cell.textLabel.text = weekdayName;
        cell.detailTextLabel.text = dayWeather.date;
        UILabel* minTempLabel = [cell viewWithTag:1];
        UILabel* maxTempLabel = [cell viewWithTag:2];
        
        if ([[DataHelper getTemperatureUnit] isEqualToString:@"C"]) {
            minTempLabel.text = [NSString stringWithFormat:@"Min %@ºC", dayWeather.minTempC];
            maxTempLabel.text = [NSString stringWithFormat:@"Max %@ºC", dayWeather.maxTempC];
        } else {
            minTempLabel.text = [NSString stringWithFormat:@"Min %@ºF", dayWeather.minTempF];
            maxTempLabel.text = [NSString stringWithFormat:@"Max %@ºF", dayWeather.maxTempF];
        }
        
        
        return cell;
        
    }
}

-(void)refreshWeather:(Weather*)weather{
    self.cityWeather = weather;
    [self fillWeatherData];
}

@end
