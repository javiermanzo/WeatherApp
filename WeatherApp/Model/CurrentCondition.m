//
//  CurrentCondition.m
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "CurrentCondition.h"

@implementation CurrentCondition


-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        self.observationTime =  [json objectForKey:@"observation_time"];
        self.tempC =  [json objectForKey:@"temp_C"];
        self.tempF =  [json objectForKey:@"temp_F"];
        self.windSpeedKmph =  [json objectForKey:@"windspeedKmph"];
        self.windSpeedMiles =  [json objectForKey:@"windspeedMiles"];
        self.windDir6Points =  [json objectForKey:@"winddir16Point"];
        self.precipMM =  [json objectForKey:@"precipMM"];
        self.humidity =  [json objectForKey:@"humidity"];
        self.visibility =  [json objectForKey:@"visibility"];
        self.feelsLikeC =  [json objectForKey:@"FeelsLikeC"];
        self.feelsLikeF =  [json objectForKey:@"FeelsLikeF"];
        self.weatherIconUrl  = [[[json objectForKey:@"weatherIconUrl"] objectAtIndex:0] objectForKey:@"value"];
        self.weatherDesc  = [[[json objectForKey:@"weatherDesc"] objectAtIndex:0] objectForKey:@"value"];
        
        
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.observationTime forKey:@"observationTime"];
    [encoder encodeObject:self.tempC forKey:@"tempC"];
    [encoder encodeObject:self.tempF forKey:@"tempF"];
    [encoder encodeObject:self.windSpeedKmph forKey:@"windSpeedKmph"];
    [encoder encodeObject:self.windSpeedMiles forKey:@"windSpeedMiles"];
    [encoder encodeObject:self.windDir6Points forKey:@"windDir6Points"];
    [encoder encodeObject:self.precipMM forKey:@"precipMM"];
    [encoder encodeObject:self.humidity forKey:@"humidity"];
    [encoder encodeObject:self.visibility forKey:@"visibility"];
    [encoder encodeObject:self.feelsLikeC forKey:@"feelsLikeC"];
    [encoder encodeObject:self.feelsLikeF forKey:@"feelsLikeF"];
    [encoder encodeObject:self.weatherIconUrl forKey:@"weatherIconUrl"];
    [encoder encodeObject:self.weatherDesc forKey:@"weatherDesc"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.observationTime = [decoder decodeObjectForKey:@"observationTime"];
        self.tempC = [decoder decodeObjectForKey:@"tempC"];
        self.tempF = [decoder decodeObjectForKey:@"tempF"];
        self.windSpeedKmph = [decoder decodeObjectForKey:@"windSpeedKmph"];
        self.windSpeedMiles = [decoder decodeObjectForKey:@"windSpeedMiles"];
        self.windDir6Points = [decoder decodeObjectForKey:@"windDir6Points"];
        self.precipMM = [decoder decodeObjectForKey:@"precipMM"];
        self.humidity = [decoder decodeObjectForKey:@"humidity"];
        self.visibility = [decoder decodeObjectForKey:@"visibility"];
        self.feelsLikeC = [decoder decodeObjectForKey:@"feelsLikeC"];
        self.feelsLikeF = [decoder decodeObjectForKey:@"feelsLikeF"];
        self.weatherIconUrl = [decoder decodeObjectForKey:@"weatherIconUrl"];
        self.weatherDesc = [decoder decodeObjectForKey:@"weatherDesc"];
    }
    return self;
}

@end
