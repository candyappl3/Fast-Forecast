//
//  DSDayWeatherCell.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 13.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSDayWeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end
