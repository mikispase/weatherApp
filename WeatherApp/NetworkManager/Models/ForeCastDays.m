//
//  ForeCastDays.m
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import "ForeCastDays.h"
#import "ConsolidatedWeather.h"
#import "Parent.h"
#import "Sources.h"


NSString *const kForeCastDaysLattLong = @"latt_long";
NSString *const kForeCastDaysConsolidatedWeather = @"consolidated_weather";
NSString *const kForeCastDaysSunRise = @"sun_rise";
NSString *const kForeCastDaysTime = @"time";
NSString *const kForeCastDaysParent = @"parent";
NSString *const kForeCastDaysSources = @"sources";
NSString *const kForeCastDaysTitle = @"title";
NSString *const kForeCastDaysWoeid = @"woeid";
NSString *const kForeCastDaysTimezoneName = @"timezone_name";
NSString *const kForeCastDaysSunSet = @"sun_set";
NSString *const kForeCastDaysTimezone = @"timezone";
NSString *const kForeCastDaysLocationType = @"location_type";


@interface ForeCastDays ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForeCastDays

@synthesize lattLong = _lattLong;
@synthesize consolidatedWeather = _consolidatedWeather;
@synthesize sunRise = _sunRise;
@synthesize time = _time;
@synthesize parent = _parent;
@synthesize sources = _sources;
@synthesize title = _title;
@synthesize woeid = _woeid;
@synthesize timezoneName = _timezoneName;
@synthesize sunSet = _sunSet;
@synthesize timezone = _timezone;
@synthesize locationType = _locationType;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lattLong = [self objectOrNilForKey:kForeCastDaysLattLong fromDictionary:dict];
    NSObject *receivedConsolidatedWeather = [dict objectForKey:kForeCastDaysConsolidatedWeather];
    NSMutableArray *parsedConsolidatedWeather = [NSMutableArray array];
    
    if ([receivedConsolidatedWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedConsolidatedWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedConsolidatedWeather addObject:[ConsolidatedWeather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedConsolidatedWeather isKindOfClass:[NSDictionary class]]) {
       [parsedConsolidatedWeather addObject:[ConsolidatedWeather modelObjectWithDictionary:(NSDictionary *)receivedConsolidatedWeather]];
    }

    self.consolidatedWeather = [NSArray arrayWithArray:parsedConsolidatedWeather];
            self.sunRise = [self objectOrNilForKey:kForeCastDaysSunRise fromDictionary:dict];
            self.time = [self objectOrNilForKey:kForeCastDaysTime fromDictionary:dict];
            self.parent = [Parent modelObjectWithDictionary:[dict objectForKey:kForeCastDaysParent]];
    NSObject *receivedSources = [dict objectForKey:kForeCastDaysSources];
    NSMutableArray *parsedSources = [NSMutableArray array];
    
    if ([receivedSources isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSources) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSources addObject:[Sources modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSources isKindOfClass:[NSDictionary class]]) {
       [parsedSources addObject:[Sources modelObjectWithDictionary:(NSDictionary *)receivedSources]];
    }

    self.sources = [NSArray arrayWithArray:parsedSources];
            self.title = [self objectOrNilForKey:kForeCastDaysTitle fromDictionary:dict];
            self.woeid = [[self objectOrNilForKey:kForeCastDaysWoeid fromDictionary:dict] doubleValue];
            self.timezoneName = [self objectOrNilForKey:kForeCastDaysTimezoneName fromDictionary:dict];
            self.sunSet = [self objectOrNilForKey:kForeCastDaysSunSet fromDictionary:dict];
            self.timezone = [self objectOrNilForKey:kForeCastDaysTimezone fromDictionary:dict];
            self.locationType = [self objectOrNilForKey:kForeCastDaysLocationType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.lattLong forKey:kForeCastDaysLattLong];
    NSMutableArray *tempArrayForConsolidatedWeather = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.consolidatedWeather) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForConsolidatedWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForConsolidatedWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForConsolidatedWeather] forKey:kForeCastDaysConsolidatedWeather];
    [mutableDict setValue:self.sunRise forKey:kForeCastDaysSunRise];
    [mutableDict setValue:self.time forKey:kForeCastDaysTime];
    [mutableDict setValue:[self.parent dictionaryRepresentation] forKey:kForeCastDaysParent];
    NSMutableArray *tempArrayForSources = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.sources) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSources addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSources addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSources] forKey:kForeCastDaysSources];
    [mutableDict setValue:self.title forKey:kForeCastDaysTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.woeid] forKey:kForeCastDaysWoeid];
    [mutableDict setValue:self.timezoneName forKey:kForeCastDaysTimezoneName];
    [mutableDict setValue:self.sunSet forKey:kForeCastDaysSunSet];
    [mutableDict setValue:self.timezone forKey:kForeCastDaysTimezone];
    [mutableDict setValue:self.locationType forKey:kForeCastDaysLocationType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.lattLong = [aDecoder decodeObjectForKey:kForeCastDaysLattLong];
    self.consolidatedWeather = [aDecoder decodeObjectForKey:kForeCastDaysConsolidatedWeather];
    self.sunRise = [aDecoder decodeObjectForKey:kForeCastDaysSunRise];
    self.time = [aDecoder decodeObjectForKey:kForeCastDaysTime];
    self.parent = [aDecoder decodeObjectForKey:kForeCastDaysParent];
    self.sources = [aDecoder decodeObjectForKey:kForeCastDaysSources];
    self.title = [aDecoder decodeObjectForKey:kForeCastDaysTitle];
    self.woeid = [aDecoder decodeDoubleForKey:kForeCastDaysWoeid];
    self.timezoneName = [aDecoder decodeObjectForKey:kForeCastDaysTimezoneName];
    self.sunSet = [aDecoder decodeObjectForKey:kForeCastDaysSunSet];
    self.timezone = [aDecoder decodeObjectForKey:kForeCastDaysTimezone];
    self.locationType = [aDecoder decodeObjectForKey:kForeCastDaysLocationType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_lattLong forKey:kForeCastDaysLattLong];
    [aCoder encodeObject:_consolidatedWeather forKey:kForeCastDaysConsolidatedWeather];
    [aCoder encodeObject:_sunRise forKey:kForeCastDaysSunRise];
    [aCoder encodeObject:_time forKey:kForeCastDaysTime];
    [aCoder encodeObject:_parent forKey:kForeCastDaysParent];
    [aCoder encodeObject:_sources forKey:kForeCastDaysSources];
    [aCoder encodeObject:_title forKey:kForeCastDaysTitle];
    [aCoder encodeDouble:_woeid forKey:kForeCastDaysWoeid];
    [aCoder encodeObject:_timezoneName forKey:kForeCastDaysTimezoneName];
    [aCoder encodeObject:_sunSet forKey:kForeCastDaysSunSet];
    [aCoder encodeObject:_timezone forKey:kForeCastDaysTimezone];
    [aCoder encodeObject:_locationType forKey:kForeCastDaysLocationType];
}

- (id)copyWithZone:(NSZone *)zone {
    ForeCastDays *copy = [[ForeCastDays alloc] init];
    
    
    
    if (copy) {

        copy.lattLong = [self.lattLong copyWithZone:zone];
        copy.consolidatedWeather = [self.consolidatedWeather copyWithZone:zone];
        copy.sunRise = [self.sunRise copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.parent = [self.parent copyWithZone:zone];
        copy.sources = [self.sources copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.woeid = self.woeid;
        copy.timezoneName = [self.timezoneName copyWithZone:zone];
        copy.sunSet = [self.sunSet copyWithZone:zone];
        copy.timezone = [self.timezone copyWithZone:zone];
        copy.locationType = [self.locationType copyWithZone:zone];
    }
    
    return copy;
}


@end
