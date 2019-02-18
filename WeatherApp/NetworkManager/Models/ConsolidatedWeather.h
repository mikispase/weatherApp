//
//  ConsolidatedWeather.h
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsolidatedWeather.h"




@interface ConsolidatedWeather : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double consolidatedWeatherIdentifier;
@property (nonatomic, assign) double airPressure;
@property (nonatomic, strong) NSString *applicableDate;
@property (nonatomic, assign) double humidity;
@property (nonatomic, strong) NSString *weatherStateName;
@property (nonatomic, assign) double predictability;
@property (nonatomic, strong) NSString *windDirectionCompass;
@property (nonatomic, assign) double maxTemp;
@property (nonatomic, strong) NSString *weatherStateAbbr;
@property (nonatomic, assign) double windDirection;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, assign) double minTemp;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, assign) double visibility;
@property (nonatomic, assign) double theTemp;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
