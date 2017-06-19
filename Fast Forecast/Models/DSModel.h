//
//  DSModel.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 13.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSModel : NSObject

@property (strong, nonatomic) NSString* temperature;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSString* date;

- (instancetype)initWithServerResponse:(NSDictionary*) response;

@end
