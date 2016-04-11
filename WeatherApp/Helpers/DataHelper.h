//
//  DataHelper.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/9/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject


+(NSObject*)loadDataWithName:(NSString*)dataName;

+(void)saveData:(NSObject*)data withName:(NSString*)dataName;


+(NSString*) getDistanceUnit;

+(BOOL) setDistanceUnit:(NSString*) distanceUnit;

+(NSString*) getTemperatureUnit;

+(BOOL) setTemperatureUnit:(NSString*) temperatureUnit;

@end
