//
//  DSRootViewController.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 15.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSRootViewController.h"
#import "DSServerManager.h"
#import "DSWeatherModel.h"
#import "DSForecastModel.h"
#import "DSLocationManager.h"
#import "DSWeekForecastController.h"
#import "DSCurrentConditionViewController.h"
#import <RealReachability/RealReachability.h>


@interface DSRootViewController () 

@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) NSString* cityName;
@property (strong, nonatomic) UIPageViewController* pageViewController;
@property (strong, nonatomic) DSCurrentConditionViewController* currentConditionVC;
@property (strong, nonatomic) DSWeekForecastController* forecastVC;

@end

@implementation DSRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view bringSubviewToFront:self.bottomToolbar];
    self.currentConditionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DSCurrentConditionViewController"];
    self.currentConditionVC.pageIndex = 0;
    
    self.forecastVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DSWeekForecastController"];
    self.forecastVC.pageIndex = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatus:)
                                                 name:kRealReachabilityChangedNotification object:nil];
    
    [self getLocation];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:kRealReachabilityChangedNotification];
}

- (void)getLocation {
    
    [[DSLocationManager sharedLocation] getCurrentLocationInfo:^(CLLocation *location, NSString* cityName) {
        
        self.cityName = cityName;
        self.currentLocation = location;
        [self loadCurrentWeather];
        
    } onFailure:^(NSString *error) {
        
        
    }];
}

- (void)loadCurrentWeather {
    
    [[DSServerManager sharedManager] getCurrentWeatherConditionFromLocation:self.currentLocation
      onSuccess:^(DSWeatherModel *weather, NSArray* forecast) {
          
          if (weather) {
              
              self.weatherBackground.image = weather.weatherBackround;
              self.currentConditionVC.cityName = self.cityName;
              self.currentConditionVC.currentWeather = weather;
              
              self.forecastVC.daysArray = forecast;
              
              [self.pageViewController setViewControllers:@[self.currentConditionVC]
                                                direction:UIPageViewControllerNavigationDirectionForward
                                                 animated:YES completion:nil];
          }else{
              
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [self loadCurrentWeather];
              });
          }
          
          
      } onFailure:^{
          
          [self showNetworkNotReachableAlertWithMessage:@"Please check the network settings or connect to the WIFI."];
          
      }];
}


#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[DSCurrentConditionViewController class]]) {
        return nil;
    }else{
        return self.currentConditionVC;
    }
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[DSCurrentConditionViewController class]]) {
        
        return self.forecastVC;
    }else{
        return nil;
    }
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        if ([[previousViewControllers firstObject] isEqual:self.currentConditionVC]) {
            self.pageControl.currentPage = self.forecastVC.pageIndex;
        }else{
            self.pageControl.currentPage = self.currentConditionVC.pageIndex;
        }
    }
}

#pragma mark - Network error handling

- (void)showNetworkNotReachableAlertWithMessage:(NSString*) alertMessage {
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Network failure"
                                                                             message:alertMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* actionSettings = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root"]
                                               options:@{}
                                     completionHandler:nil];
    }];
    
    UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           [self getLocation];
                                       }];
    
    [alertController addAction:actionOK];
    [alertController addAction:actionSettings];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)networkStatus:(NSNotification*) notification {
    
    RealReachability* reachability = (RealReachability*)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    
    switch (status) {
        case RealStatusNotReachable:
            [self showNetworkNotReachableAlertWithMessage:@"Please check the network settings or connect to the WIFI."];
            break;
         
        case RealStatusViaWWAN:
            [self getLocation];
            break;
            
        case RealStatusViaWiFi:
            [self getLocation];
            break;
            
        default:
            break;
    }
    
}

@end
