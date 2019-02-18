//
//  ForeCastDays.h
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Parent;

@interface ForeCastDays : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *lattLong;
@property (nonatomic, strong) NSArray *consolidatedWeather;
@property (nonatomic, strong) NSString *sunRise;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) Parent *parent;
@property (nonatomic, strong) NSArray *sources;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double woeid;
@property (nonatomic, strong) NSString *timezoneName;
@property (nonatomic, strong) NSString *sunSet;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *locationType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
