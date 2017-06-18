//
//  ViewController.m
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSCurrentConditionViewController.h"
#import "DSWeatherModel.h"


@interface DSCurrentConditionViewController () 

@end

@implementation DSCurrentConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBlurEffect* blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = self.detailsBlackView.bounds;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.detailsBlackView addSubview:effectView];
    [self.detailsBlackView sendSubviewToBack:effectView];

    
    
    self.cityNameLabel.text = self.cityName;
    
    self.dateLabel.text = self.currentWeather.date;
    self.currentTempLabel.text = self.currentWeather.temperature;
    self.descriptionLabel.text = self.currentWeather.weatherDescription;
    self.feelsLikeLabel.text = self.currentWeather.feelsLike;
    self.cloudsLabel.text = self.currentWeather.cloudCover;
    self.humidityLabel.text = self.currentWeather.humidity;
    self.windSpeedLabel.text = self.currentWeather.windSpeed;
    self.adviceLabel.text = self.currentWeather.advice;
    
}




@end
