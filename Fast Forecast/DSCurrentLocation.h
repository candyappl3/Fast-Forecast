//
//  DSCurrentLocation.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>


@interface DSCurrentLocation : CLLocation

+ (DSCurrentLocation*)sharedLocation;

- (void)getCurrentLocationOnSuccess:(void(^)(CLLocation*))location onFailure:(void(^)(NSString*)) failure;
- (void)getCurrentCityNameOnSucces:(void(^)(NSString*))cityName onFailure:(void(^)(NSString*)) failure;


@end
