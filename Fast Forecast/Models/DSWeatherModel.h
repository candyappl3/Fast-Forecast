//
//  DSWeatherModel.h
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSModel.h"

@interface DSWeatherModel : DSModel

@property (strong, nonatomic) NSString* windSpeed;
@property (strong, nonatomic) NSString* feelsLike;
@property (strong, nonatomic) NSString* humidity;
@property (strong, nonatomic) NSString* advice;
@property (strong, nonatomic) NSString* cloudCover;
@property (strong, nonatomic) UIImage* weatherBackround;


@end
