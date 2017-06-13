//
//  DSForecastModel.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 12.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSModel.h"

@interface DSForecastModel : DSModel

@property (strong, nonatomic) NSString* maxTemp;
@property (strong, nonatomic) NSString* minTemp;
@property (strong, nonatomic) NSURL* dayWeatherIcon;

@end
