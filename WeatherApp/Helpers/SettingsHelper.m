//
//  SettingsManager.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "SettingsHelper.h"

#define PLIST_SETTING_NAME @"Settings"

@implementation SettingsHelper


+(NSString*) getApiKeyWeather{
    
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile:
                          [[NSBundle mainBundle] pathForResource:PLIST_SETTING_NAME ofType:@"plist"]];
    NSString* apiKeyWeather = [data objectForKey:@"api_key_weather"];
    return apiKeyWeather;
}

@end
