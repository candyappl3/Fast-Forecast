//
//  DSLocationManager.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlock)(CLLocation* responce, NSString* cityName);


@interface DSLocationManager : CLLocation <CLLocationManagerDelegate>

+ (DSLocationManager*)sharedLocation;

- (void)getCurrentLocationInfo:(void(^)(CLLocation* location, NSString* cityName)) successLocation
                     onFailure:(void(^)(NSString* error)) failure;

@end
