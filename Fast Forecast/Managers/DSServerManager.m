//
//  DSServerManager.m
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSServerManager.h"
#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>
#import "DSWeatherModel.h"
#import "DSForecastModel.h"

@interface DSServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;

@end

@implementation DSServerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* baseURL = [[NSURL alloc]
                          initWithString:@"https://api.worldweatheronline.com/premium/v1/"];
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        
    }
    return self;
}

+(DSServerManager*)sharedManager{
    
    static DSServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DSServerManager alloc] init];
    });
    
    return manager;
    
}


-(void)getCurrentWeatherConditionFromLocation:(CLLocation*) location
                                    onSuccess:(void(^)(DSWeatherModel* weather, NSArray* forecast))success
                                    onFailure:(void(^)())failure{
    
    NSString* coordinates = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys: @"4fc04403a123417c842171159170906",  @"key",
                                                                                                coordinates,    @"q",
                                                                                                @"json",        @"format",
                                                                                                @"ru",          @"lang",
                                                                                                @"14",           @"num_of_days", nil];
    
    [self.sessionManager GET:@"weather.ashx" parameters:parameters progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
             NSDictionary* conditionResponse = [[responseObject valueForKeyPath:@"data.current_condition"] firstObject];

             NSArray* forecastResponse = [responseObject valueForKeyPath:@"data.weather"];
             
             NSMutableArray* daysArray = [NSMutableArray array];
             
             DSWeatherModel* weather = [[DSWeatherModel alloc] initWithServerResponse:conditionResponse];

             for (NSDictionary* dayResponce in forecastResponse) {
                 
                 DSForecastModel* dayForecast = [[DSForecastModel alloc] initWithServerResponse:dayResponce];
                 [daysArray addObject:dayForecast];
             }
             
             if (success) {
                 success(weather, daysArray);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             if (failure) {
                 NSLog(@"%@", error.localizedDescription);
                 failure(error);
             }
         }];
}



@end

