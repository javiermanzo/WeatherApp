//
//  NetworkingHelper.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface NetworkingHelper : NSObject


+(void) requestWeatherWithCityName:(NSString*) cityName doingWithSuccess:(void (^)(Weather*)) successBlock andWithError:(void (^)(NSString*)) errorBlock;

+(void) requestSuggestedLocationOf:(NSString*) locationText doingWithSuccess:(void (^)(NSMutableArray*)) successBlock andWithError:(void (^)(NSString*)) errorBlock;

@end
