//
//  Astronomy.h
//  Weather App
//
//  Created by Javier Manzo on 4/5/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Astronomy : NSObject

@property(nonatomic,retain) NSString* sunrise;
@property(nonatomic,retain) NSString* sunset;
@property(nonatomic,retain) NSString* moonrise;
@property(nonatomic,retain) NSString* moonset;

-(id) initFromJSON:(NSDictionary*) json;

@end
