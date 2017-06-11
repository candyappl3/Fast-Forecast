//
//  DSLocationManager.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSLocationManager.h"


@interface DSLocationManager ()

@property(strong, nonatomic) CLLocationManager* locationManager;
@property(strong, nonatomic) CLLocation* currentLocation;
@property(copy, nonatomic) CityNameBlock cityName;
@property(copy, nonatomic) LocationBlock location;


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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];
    
}

#pragma mark - CLLocationManagerDelegate 

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.currentLocation = [locations lastObject];
        
        NSLog(@"rrr");
    });
    
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"%@", error.localizedDescription);
    [manager requestLocation];
    
}

#pragma mark - Location Requests

- (void)getCurrentLocationInfo:(void(^)(CLLocation* location)) successLocation
                       andInfo:(void(^)(NSString* cityName)) cityInfo
                     onFailure:(void(^)(NSString* error)) failure {
    
    self.location = ^(CLLocation *responce) {
        successLocation(responce);
    };
    
    self.cityName = ^(NSString *responce) {
        cityInfo(responce);
    };
    
}


- (void)setCurrentLocation:(CLLocation *)currentLocation {
    
    __weak CLLocation* weakLocation = currentLocation;
    
    self.location(weakLocation);    
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                       
                       CLPlacemark* placemark = [placemarks lastObject];
                       
                       NSString* cityName = placemark.locality;
                       
                       if (!cityName) {
                           cityName = placemark.administrativeArea;
                       }
                       
                       __weak NSString* weakString = cityName;
                       
                       self.cityName(weakString);
                       
                   }];
    
}

@end
