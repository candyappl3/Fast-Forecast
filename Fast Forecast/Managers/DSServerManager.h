//
//  DSServerManager.h
//  newBlocksTest
//
//  Created by Dmitry Shadrin on 09.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class DSWeatherModel;

@interface DSServerManager : NSObject

+(DSServerManager*)sharedManager;

-(void)getCurrentWeatherConditionFromLocation:(CLLocation*) location
                                    onSuccess:(void(^)(DSWeatherModel* weather, NSArray* forecast))success
                                    onFailure:(void(^)())failure;

@end
