//
//  DSLocationManager.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSLocationManager.h"


@interface DSLocationManager ()

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (copy, nonatomic) LocationBlock location;
@property (assign, nonatomic) BOOL firstUpdating;


@end

@implementation DSLocationManager

+ (DSLocationManager*)sharedLocation {
    
    static DSLocationManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DSLocationManager alloc] init];
    });
    
    [manager startLocationUpdating];
    
    return manager;
}

- (void)startLocationUpdating {
    
    self.firstUpdating = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - CLLocationManagerDelegate 

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{

    if (self.firstUpdating) {
        self.currentLocation = [locations lastObject];
        self.firstUpdating = NO;
        [manager stopUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"%@", error.localizedDescription);
    [manager requestLocation];
    
}

#pragma mark - Location Requests

- (void)getCurrentLocationInfo:(void(^)(CLLocation* location, NSString* cityName)) successLocation
                     onFailure:(void(^)(NSString* error)) failure {
    
    self.location = ^(CLLocation *responce, NSString* cityName) {
        successLocation(responce, cityName);
    };
    
    
}


- (void)setCurrentLocation:(CLLocation *)currentLocation {
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                       
                       CLPlacemark* placemark = [placemarks lastObject];
                       
                       NSString* cityName = placemark.locality;
                       
                       if (!cityName) {
                           cityName = placemark.administrativeArea;
                       }
                       
                       __weak CLLocation* weakLocation = currentLocation;
                       __weak NSString* weakString = cityName;
                       
                       self.location(weakLocation, weakString);
                       
                   }];
    
}

@end
