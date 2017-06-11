//
//  DSAdviceAndBackgroundCast.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSAdviceAndBackgroundCast : NSObject

- (instancetype) initWithWeatherCode:(NSString*) code;

@property (strong, nonatomic) NSString* greatAdvice;
@property (strong, nonatomic) UIImage* weatherImage;

@end
