//
//  DSWeekForecastController.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 13.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSWeekForecastController.h"
#import "DSForecastModel.h"
#import "DSDayWeatherCell.h"
#import "UIImageView+AFNetworking.h"

@interface DSWeekForecastController ()

@end

@implementation DSWeekForecastController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.daysArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DSForecastModel* dayWeather = [self.daysArray objectAtIndex:indexPath.section];
    
    static NSString* identifier = @"DayWeatherCell";
    
    DSDayWeatherCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.temperatureLabel.text = dayWeather.temperature;
    cell.maxTempLabel.text = dayWeather.maxTemp;
    cell.minTempLabel.text = dayWeather.minTemp;
    
    switch (indexPath.section) {
        case 0:
            cell.dateLabel.text = @"Today";
            break;
            
        default:
            cell.dateLabel.text = dayWeather.date;
            break;
    }

    UIBlurEffect* blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = cell.bounds;
    effectView.clipsToBounds = YES;
    effectView.layer.cornerRadius = CGRectGetHeight(effectView.bounds) / 6;
    
    cell.backgroundView = effectView;
    
    __weak UIImageView* weakImage = cell.weatherIcon;
    
    cell.weatherIcon.clipsToBounds = YES;
    cell.weatherIcon.layer.cornerRadius = CGRectGetWidth(cell.weatherIcon.frame) / 3;
    
    [cell.weatherIcon setImageWithURLRequest:[NSURLRequest requestWithURL:dayWeather.dayWeatherIcon]
                            placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                weakImage.image = image;
                            } failure:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  100.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
