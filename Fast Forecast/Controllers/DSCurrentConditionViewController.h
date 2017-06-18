//
//  ViewController.h
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSWeatherModel.h"

@interface DSCurrentConditionViewController : UIViewController

@property (assign, nonatomic) NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UIView *detailsBlackView;

@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;

@property (strong, nonatomic) DSWeatherModel* currentWeather;
@property (strong, nonatomic) NSString* cityName;

@end

