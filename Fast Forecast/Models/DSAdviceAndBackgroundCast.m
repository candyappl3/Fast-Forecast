//
//  DSAdviceAndBackgroundCast.m
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 10.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import "DSAdviceAndBackgroundCast.h"

@implementation DSAdviceAndBackgroundCast

static NSString* backgroundImages[] = { @"clearSky.jpeg", @"cloudy.jpeg", @"mainlyCloudy.jpeg",
                                        @"rain.jpg", @"snow.jpeg", @"storm.jpg",
                                        @"thunderstorm.jpeg", @"blizzard.jpeg"};

//
static NSString* advices[] = {@"""The weather is pretty, it's time to shake the fat.""",
    @"""— And this cloud looks like your future.\n— No there is no cloud.\n— That's it.""",
    @"""It's sad.""",
    @"""Excellent reason to wash the car.""", @"""— As in St. Petersburg weather?\n— Rain\n— Long?  — Since 1703""",
    @"""I hope the summer will be less snow.""",
    @"""Very scary!""",
    @"""You'd better stay home."""};

static NSString* codes[] = {@"113 ", @"119 116", @"248 143 122",
                            @"182 176 263 266 311 302 299 296 293 362 359 353 317",
                            @"308 365 314 305 356",
                            @"374 260 227 185 179 281 320 350 335 329 326 323 368",
                            @"395 392 389 386 200",
                            @"230 284 338 371 377"};

- (instancetype) initWithWeatherCode:(NSString*) code {
    
    self = [super init];
    if (self) {
        
        for (int i = 0; i < 8; i++) {
            
            NSArray* codesArray = [codes[i] componentsSeparatedByString:@" "];
            
            for (NSString* str in codesArray) {
                
                if ([str isEqualToString:code]) {
                    
                    self.greatAdvice = advices[i];
                    
                    UIImage* image = [UIImage imageNamed:backgroundImages[i]];
                    self.weatherImage = image;
                                        
                    break;
                }
            }
            if (self.weatherImage) {
                break;
            }
        }
    }
    return self;
}



@end
