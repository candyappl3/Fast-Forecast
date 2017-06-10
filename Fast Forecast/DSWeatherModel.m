//
//  DSWeatherModel.m
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSWeatherModel.h"

@implementation DSWeatherModel

-(instancetype)initWithServerResponse:(NSDictionary*) response
{
    self = [super init];
    if (self) {
        
        self.currentTemperature = [NSString stringWithFormat:@"%@ ºC", [response valueForKey:@"temp_C"]];
        self.feelsLike = [NSString stringWithFormat:@"%@ ºC", [response valueForKey:@"FeelsLikeC"]];
        self.humidity = [NSString stringWithFormat:@"%@ %%", [response valueForKey:@"humidity"]];
        self.cloudCover = [NSString stringWithFormat:@"%@ %%", [response valueForKey:@"cloudcover"]];
        self.windSpeed = [NSString stringWithFormat:@"%@ km/H", [response valueForKey:@"windspeedKmph"]];
        
        NSArray* weatherDesc = [response objectForKey:@"weatherDesc"];
        self.weatherDescription = [[weatherDesc firstObject] valueForKey:@"value"];

        NSArray* urlResponse = [response objectForKey:@"weatherIconUrl"];
        NSString* urlString = [[urlResponse firstObject] valueForKey:@"value"];
        self.weatherIcon64 = [NSURL URLWithString:urlString];

        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"d MMMM yyyy"];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        self.currentDate = [formatter stringFromDate:[NSDate date]];
        
        NSLog(@"sds");
    }
    
    return self;
}



@end
