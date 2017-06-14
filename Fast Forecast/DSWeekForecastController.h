//
//  DSWeekForecastController.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 13.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSWeekForecastController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* daysArray;
@property (weak, nonatomic) IBOutlet UIImageView *weatherBackground;
@property (strong, nonatomic) UIImage* strongImage;

@end
