//
//  SuggestedLocation.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/6/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "SuggestedLocation.h"

@implementation SuggestedLocation

-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        self.areaName = [[[json objectForKey:@"areaName"] objectAtIndex:0] objectForKey:@"value"];
        self.country = [[[json objectForKey:@"country"] objectAtIndex:0] objectForKey:@"value"];
        self.region = [[[json objectForKey:@"region"] objectAtIndex:0] objectForKey:@"value"];
        
    }
    
    return self;
}

@end
