//
//  DSForecastModel.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 12.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSForecastModel.h"

@implementation DSForecastModel

- (instancetype)initWithServerResponse:(NSDictionary*) response
{
    self = [super init];
    if (self) {

        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate* date = [formatter dateFromString:[response valueForKey:@"date"]];
        [formatter setDateFormat:@"d MMMM"];
        self.date = [formatter stringFromDate:date];
        
        NSArray* hourlyArray = [response objectForKey:@"hourly"];
        NSDictionary* averageCondition = [hourlyArray objectAtIndex:hourlyArray.count / 2];
        
        NSArray* weatherDesc = [response objectForKey:@"weatherDesc"];
        self.weatherDescription = [[weatherDesc firstObject] valueForKey:@"value"];
        
        NSArray* weatherIconUrl = [averageCondition objectForKey:@"weatherIconUrl"];
        NSString* baseURL = [[weatherIconUrl firstObject] valueForKey:@"value"];
        self.dayWeatherIcon = [NSURL URLWithString:baseURL];
        
        self.maxTemp = [NSString stringWithFormat:@"Max: %@ºC", [response valueForKey:@"maxtempC"]];
        self.minTemp = [NSString stringWithFormat:@"Min: %@ºC", [response valueForKey:@"mintempC"]];
        self.temperature = [NSString stringWithFormat:@"%@ºC", [averageCondition valueForKey:@"tempC"]];
                
    }
    return self;
}

@end
