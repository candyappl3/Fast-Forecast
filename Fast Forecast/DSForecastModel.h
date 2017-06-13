//
//  DSForecastModel.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 12.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSForecastModel : NSObject

@property (strong, nonatomic) NSString* dayTemperature;
@property (strong, nonatomic) NSString* maxTemp;
@property (strong, nonatomic) NSString* minTemp;
@property (strong, nonatomic) NSString* dayDate;
@property (strong, nonatomic) NSString* dayWeatherDescription;
@property (strong, nonatomic) NSURL* dayWeatherIcon;

- (instancetype)initWithServerResponse:(NSDictionary*) response;


@end
