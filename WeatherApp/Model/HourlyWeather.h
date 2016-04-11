//
//  HourlyWeather.h
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourlyWeather : NSObject

@property(nonatomic,retain) NSString* time;
@property(nonatomic,retain) NSString* tempC;
@property(nonatomic,retain) NSString* tempF;
@property(nonatomic,retain) NSString* weatherIconUrl;
@property(nonatomic,retain) NSString* weatherDesc;

-(id) initFromJSON:(NSDictionary*) json;

@end
