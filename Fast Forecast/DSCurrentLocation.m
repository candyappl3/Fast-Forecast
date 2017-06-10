//
//  DSCurrentLocation.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSCurrentLocation.h"

@implementation DSCurrentLocation

+ (DSCurrentLocation*)sharedLocation {
    
    static DSCurrentLocation* location = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location
    });
    
}


@end
