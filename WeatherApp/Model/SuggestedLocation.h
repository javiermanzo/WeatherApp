//
//  SuggestedLocation.h
//  WeatherApp
//
//  Created by Javier Manzo on 4/6/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuggestedLocation : NSObject

@property(nonatomic,retain) NSString* areaName;
@property(nonatomic,retain) NSString* country;
@property(nonatomic,retain) NSString* region;

-(id) initFromJSON:(NSDictionary*) json;

@end
