//
//  DSLocationManager.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef void(^CityNameBlock)(NSString* responce);
typedef void(^LocationBlock)(CLLocation* responce);


@interface DSLocationManager : CLLocation <CLLocationManagerDelegate>

+ (DSLocationManager*)sharedLocation;

- (void)getCurrentLocationInfo:(void(^)(CLLocation* location)) successLocation
                       andInfo:(void(^)(NSString* cityName)) cityInfo
                     onFailure:(void(^)(NSString* error)) failure;

@end
