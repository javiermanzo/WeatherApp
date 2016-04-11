//
//  CurrentCondition.h
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentCondition : NSObject

@property(nonatomic,retain) NSString* observationTime;
@property(nonatomic,retain) NSString* tempC;
@property(nonatomic,retain) NSString* tempF;
@property(nonatomic,retain) NSString* feelsLikeC;
@property(nonatomic,retain) NSString* feelsLikeF;
@property(nonatomic,retain) NSString* weatherIconUrl;
@property(nonatomic,retain) NSString* weatherDesc;
@property(nonatomic,retain) NSString* windSpeedMiles;
@property(nonatomic,retain) NSString* windSpeedKmph;
@property(nonatomic,retain) NSString* windDir6Points;
@property(nonatomic,retain) NSString* humidity;
@property(nonatomic,retain) NSString* precipMM;
@property(nonatomic,retain) NSString* visibility;

-(id) initFromJSON:(NSDictionary*) json;

@end
