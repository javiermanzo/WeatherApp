//
//  DayWeather.h
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Astronomy.h"

@interface DayWeather : NSObject

@property(nonatomic,retain) NSString* date;
@property(nonatomic,retain) Astronomy* astronomy;
@property(nonatomic,retain) NSString* minTempC;
@property(nonatomic,retain) NSString* minTempF;
@property(nonatomic,retain) NSString* maxTempC;
@property(nonatomic,retain) NSString* maxTempF;
@property(nonatomic,retain) NSMutableArray* listHourlyWeather;

-(id) initFromJSON:(NSDictionary*) json;

@end
