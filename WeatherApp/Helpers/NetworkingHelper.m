//
//  NetworkingHelper.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "NetworkingHelper.h"
#import "AFHTTPSessionManager.h"
#import "SettingsHelper.h"
#import "SuggestedLocation.h"

#define MAX_DAYS_REQUEST @"5"
#define MAX_LOCATIONS_REQUEST @"6"
#define BASE_URL_REQUEST @"http://api.worldweatheronline.com/premium/v1/weather.ashx"
#define BASE_URL_SEARCH_REQUEST @"http://api.worldweatheronline.com/premium/v1/search.ashx"

@implementation NetworkingHelper

+(void) requestWeatherWithCityName:(NSString*) cityName doingWithSuccess:(void (^)(Weather*)) successBlock andWithError:(void (^)(NSString*)) errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[SettingsHelper getApiKeyWeather] forKey:@"key"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:MAX_DAYS_REQUEST forKey:@"num_of_days"];
    [params setObject:cityName forKey:@"q"];
    
    NSURL *URL = [NSURL URLWithString:BASE_URL_REQUEST];
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *data = responseObject[@"data"];
        
        Weather* weather = [[Weather alloc]initFromJSON:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            successBlock(weather);
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        errorBlock(error.localizedDescription);
        
    }];
    
}

+(void) requestSuggestedLocationOf:(NSString*) locationText doingWithSuccess:(void (^)(NSMutableArray*)) successBlock andWithError:(void (^)(NSString*)) errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[SettingsHelper getApiKeyWeather] forKey:@"key"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:MAX_LOCATIONS_REQUEST forKey:@"num_of_results"];
    [params setObject:locationText forKey:@"q"];
    
    NSURL *URL = [NSURL URLWithString:BASE_URL_SEARCH_REQUEST];
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *data = responseObject[@"search_api"][@"result"];
        
        NSMutableArray* listSuggestedLocation = [[NSMutableArray alloc]init];
        
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SuggestedLocation* suggestedLocation = [[SuggestedLocation alloc]initFromJSON:obj];
            [listSuggestedLocation addObject:suggestedLocation];
        }];
        successBlock(listSuggestedLocation);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        errorBlock(error.localizedDescription);
        
    }];
    
}

@end
