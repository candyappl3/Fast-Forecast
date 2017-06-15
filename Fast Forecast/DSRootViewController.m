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
    [self.view bringSubviewToFront:self.splashScreen];
    [self.view insertSubview:self.pageControl belowSubview:self.splashScreen];
    
    self.currentConditionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DSCurrentConditionViewController"];
    self.currentConditionVC.pageIndex = 0;
    
    self.forecastVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DSWeekForecastController"];
    self.forecastVC.pageIndex = 1;
    
    
    
    [self getLocation];
}

- (void)getLocation {
    
    [[DSLocationManager sharedLocation] getCurrentLocationInfo:^(CLLocation *location) {
        
        self.currentLocation = location;
        [self loadCurrentWeather];
        
    } andInfo:^(NSString *cityName) {
        
        self.cityName = cityName;
        
    } onFailure:^(NSString *error) {
        
        
        
    }];
}

- (void)loadCurrentWeather {
    
    NSLog(@"%f, %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
    
    [[DSServerManager sharedManager] getCurrentWeatherConditionFromLocation:self.currentLocation
      onSuccess:^(DSWeatherModel *weather, NSArray* forecast) {
          
          [UIView animateWithDuration:0.5 animations:^{
              
              self.weatherBackground.image = weather.weatherBackround;
              
              self.currentConditionVC.currentWeather = weather;
              self.currentConditionVC.cityName = self.cityName;
              
              self.forecastVC.daysArray = forecast;
              
              [self.pageViewController setViewControllers:@[self.currentConditionVC]
                                                direction:UIPageViewControllerNavigationDirectionForward
                                                 animated:YES completion:nil];
              
              self.splashScreen.alpha = 0;
              
          } completion:^(BOOL finished) {
              [self.splashScreen removeFromSuperview];
          }];
          
          
      } onFailure:^{
          
          
          
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

- (void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        if ([[previousViewControllers firstObject] isEqual:self.currentConditionVC]) {
            self.pageControl.currentPage = self.forecastVC.pageIndex;
        }else{
            self.pageControl.currentPage = self.currentConditionVC.pageIndex;
        }
        
    }
}



@end
