//
//  DayWeather.m
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "DayWeather.h"
#import "HourlyWeather.h"

@implementation DayWeather

-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        self.date =  [json objectForKey:@"date"];
        self.minTempC =  [json objectForKey:@"mintempC"];
        self.minTempF =  [json objectForKey:@"mintempF"];
        self.maxTempC =  [json objectForKey:@"maxtempC"];
        self.maxTempF =  [json objectForKey:@"maxtempF"];
        
        self.astronomy = [[Astronomy alloc] initFromJSON:[[json objectForKey:@"astronomy"] objectAtIndex:0]];
        
        NSArray* hourlyArray = [json objectForKey:@"hourly"];
        self.listHourlyWeather = [NSMutableArray new];
        [hourlyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HourlyWeather* hourlyWeather = [[HourlyWeather alloc]initFromJSON:obj];
            [self.listHourlyWeather addObject:hourlyWeather];
        }];
        
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.minTempC forKey:@"minTempC"];
    [encoder encodeObject:self.minTempF forKey:@"minTempF"];
    [encoder encodeObject:self.maxTempC forKey:@"maxTempC"];
    [encoder encodeObject:self.maxTempF forKey:@"maxTempF"];
    [encoder encodeObject:self.astronomy forKey:@"astronomy"];
    [encoder encodeObject:self.listHourlyWeather forKey:@"listHourlyWeather"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.minTempC = [decoder decodeObjectForKey:@"minTempC"];
        self.minTempF = [decoder decodeObjectForKey:@"minTempF"];
        self.maxTempC = [decoder decodeObjectForKey:@"maxTempC"];
        self.maxTempF = [decoder decodeObjectForKey:@"maxTempF"];
        self.astronomy = [decoder decodeObjectForKey:@"astronomy"];
        self.listHourlyWeather = [decoder decodeObjectForKey:@"listHourlyWeather"];
    }
    return self;
}

@end
