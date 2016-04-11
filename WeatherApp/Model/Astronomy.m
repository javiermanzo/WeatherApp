//
//  Astronomy.m
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "Astronomy.h"

@implementation Astronomy


-(id) initFromJSON:(NSDictionary*) json{
    if (self = [super init]){
        
        self.sunrise =  [json objectForKey:@"sunrise"];
        self.sunset =  [json objectForKey:@"sunset"];
        self.moonrise =  [json objectForKey:@"moonrise"];
        self.moonset =  [json objectForKey:@"moonset"];
        
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.sunrise forKey:@"sunrise"];
    [encoder encodeObject:self.sunset forKey:@"sunset"];
    [encoder encodeObject:self.moonrise forKey:@"moonrise"];
    [encoder encodeObject:self.moonset forKey:@"moonset"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.sunrise = [decoder decodeObjectForKey:@"sunrise"];
        self.sunset = [decoder decodeObjectForKey:@"sunset"];
        self.moonrise = [decoder decodeObjectForKey:@"moonrise"];
        self.moonset = [decoder decodeObjectForKey:@"moonset"];
    }
    return self;
}

@end
