//
//  Weather.m
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "Weather.h"
#import "DayWeather.h"

@implementation Weather


-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        
        self.completeName  = [[[json objectForKey:@"request"] objectAtIndex:0] objectForKey:@"query"];
        
        self.cityName = [[self.completeName componentsSeparatedByString:@","] objectAtIndex:0];
        self.countryName = [[self.completeName componentsSeparatedByString:@","] objectAtIndex:1];
        
        self.countryName = [self.countryName stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
        self.cityName = [self.cityName stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        
        self.currentCondition = [[CurrentCondition alloc] initFromJSON:[[json objectForKey:@"current_condition"] objectAtIndex:0]];
        
        NSArray* daysArray = [json objectForKey:@"weather"];
        self.listDaysWeather = [NSMutableArray new];
        [daysArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DayWeather* dayWeather = [[DayWeather alloc]initFromJSON:obj];
            [self.listDaysWeather addObject:dayWeather];
        }];
        
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.completeName forKey:@"completeName"];
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.countryName forKey:@"countryName"];
    [encoder encodeObject:self.currentCondition forKey:@"currentCondition"];
    [encoder encodeObject:self.listDaysWeather forKey:@"listDaysWeather"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.completeName = [decoder decodeObjectForKey:@"completeName"];
        self.cityName = [decoder decodeObjectForKey:@"cityName"];
        self.countryName = [decoder decodeObjectForKey:@"countryName"];
        self.currentCondition = [decoder decodeObjectForKey:@"currentCondition"];
        self.listDaysWeather = [decoder decodeObjectForKey:@"listDaysWeather"];
    }
    return self;
}


@end
