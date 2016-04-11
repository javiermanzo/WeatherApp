//
//  Weather.h
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentCondition.h"

@interface Weather : NSObject

@property(nonatomic,retain) CurrentCondition* currentCondition;
@property(nonatomic,retain) NSMutableArray* listDaysWeather;
@property(nonatomic,retain) NSString* cityName;
@property(nonatomic,retain) NSString* countryName;
@property(nonatomic,retain) NSString* completeName;


-(id) initFromJSON:(NSDictionary*) json;

@end
