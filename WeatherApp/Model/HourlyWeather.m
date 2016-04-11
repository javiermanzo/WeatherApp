//
//  HourlyWeather.m
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "HourlyWeather.h"

@implementation HourlyWeather

-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        self.time =  [json objectForKey:@"time"];
        self.tempC =  [json objectForKey:@"tempC"];
        self.tempF =  [json objectForKey:@"tempF"];
        
        self.weatherIconUrl  = [[[json objectForKey:@"weatherIconUrl"] objectAtIndex:0] objectForKey:@"value"];
        self.weatherDesc  = [[[json objectForKey:@"weatherDesc"] objectAtIndex:0] objectForKey:@"value"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.tempC forKey:@"tempC"];
    [encoder encodeObject:self.tempF forKey:@"tempF"];
    [encoder encodeObject:self.weatherIconUrl forKey:@"weatherIconUrl"];
    [encoder encodeObject:self.weatherDesc forKey:@"weatherDesc"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.time = [decoder decodeObjectForKey:@"time"];
        self.tempC = [decoder decodeObjectForKey:@"tempC"];
        self.tempF = [decoder decodeObjectForKey:@"tempF"];
        self.weatherIconUrl = [decoder decodeObjectForKey:@"weatherIconUrl"];
        self.weatherDesc = [decoder decodeObjectForKey:@"weatherDesc"];
    }
    return self;
}

@end
