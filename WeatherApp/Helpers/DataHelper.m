//
//  DataHelper.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/9/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper


+(NSString*) getBundleIndentifier{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    return bundleIdentifier;
}

+(NSString*) getDistanceUnit{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *distanceUnit = [defaults objectForKey:[NSString stringWithFormat:@"%@.distanceUnit",[self getBundleIndentifier]]];
    
    return distanceUnit;
}

+(BOOL) setDistanceUnit:(NSString*) distanceUnit{
    //Check if data exists
    BOOL existData = (BOOL)[self getDistanceUnit];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:distanceUnit forKey:[NSString stringWithFormat:@"%@.distanceUnit",[self getBundleIndentifier]]];
    
    [defaults synchronize];
    
    return existData;
}

+(NSString*) getTemperatureUnit{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *temperatureUnit = [defaults objectForKey:[NSString stringWithFormat:@"%@.temperatureUnit",[self getBundleIndentifier]]];
    
    return temperatureUnit;
}

+(BOOL) setTemperatureUnit:(NSString*) temperatureUnit{
    //Check if data exists
    BOOL existData = (BOOL)[self getDistanceUnit];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:temperatureUnit forKey:[NSString stringWithFormat:@"%@.temperatureUnit",[self getBundleIndentifier]]];
    
    [defaults synchronize];
    
    return existData;
}

+(NSObject*)loadDataWithName:(NSString*)dataName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:dataName];
    NSMutableArray* listWeather = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    
    return listWeather;
}

+(void)saveData:(NSObject*)data withName:(NSString*)dataName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:dataName];
    [NSKeyedArchiver archiveRootObject:data toFile:appFile];
    
}

@end
