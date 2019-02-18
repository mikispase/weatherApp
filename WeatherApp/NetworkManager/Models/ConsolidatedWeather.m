//
//  ConsolidatedWeather.m
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import "ConsolidatedWeather.h"


NSString *const kConsolidatedWeatherId = @"id";
NSString *const kConsolidatedWeatherAirPressure = @"air_pressure";
NSString *const kConsolidatedWeatherApplicableDate = @"applicable_date";
NSString *const kConsolidatedWeatherHumidity = @"humidity";
NSString *const kConsolidatedWeatherWeatherStateName = @"weather_state_name";
NSString *const kConsolidatedWeatherPredictability = @"predictability";
NSString *const kConsolidatedWeatherWindDirectionCompass = @"wind_direction_compass";
NSString *const kConsolidatedWeatherMaxTemp = @"max_temp";
NSString *const kConsolidatedWeatherWeatherStateAbbr = @"weather_state_abbr";
NSString *const kConsolidatedWeatherWindDirection = @"wind_direction";
NSString *const kConsolidatedWeatherCreated = @"created";
NSString *const kConsolidatedWeatherMinTemp = @"min_temp";
NSString *const kConsolidatedWeatherWindSpeed = @"wind_speed";
NSString *const kConsolidatedWeatherVisibility = @"visibility";
NSString *const kConsolidatedWeatherTheTemp = @"the_temp";


@interface ConsolidatedWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ConsolidatedWeather

@synthesize consolidatedWeatherIdentifier = _consolidatedWeatherIdentifier;
@synthesize airPressure = _airPressure;
@synthesize applicableDate = _applicableDate;
@synthesize humidity = _humidity;
@synthesize weatherStateName = _weatherStateName;
@synthesize predictability = _predictability;
@synthesize windDirectionCompass = _windDirectionCompass;
@synthesize maxTemp = _maxTemp;
@synthesize weatherStateAbbr = _weatherStateAbbr;
@synthesize windDirection = _windDirection;
@synthesize created = _created;
@synthesize minTemp = _minTemp;
@synthesize windSpeed = _windSpeed;
@synthesize visibility = _visibility;
@synthesize theTemp = _theTemp;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.consolidatedWeatherIdentifier = [[self objectOrNilForKey:kConsolidatedWeatherId fromDictionary:dict] doubleValue];
            self.airPressure = [[self objectOrNilForKey:kConsolidatedWeatherAirPressure fromDictionary:dict] doubleValue];
            self.applicableDate = [self objectOrNilForKey:kConsolidatedWeatherApplicableDate fromDictionary:dict];
            self.humidity = [[self objectOrNilForKey:kConsolidatedWeatherHumidity fromDictionary:dict] doubleValue];
            self.weatherStateName = [self objectOrNilForKey:kConsolidatedWeatherWeatherStateName fromDictionary:dict];
            self.predictability = [[self objectOrNilForKey:kConsolidatedWeatherPredictability fromDictionary:dict] doubleValue];
            self.windDirectionCompass = [self objectOrNilForKey:kConsolidatedWeatherWindDirectionCompass fromDictionary:dict];
            self.maxTemp = [[self objectOrNilForKey:kConsolidatedWeatherMaxTemp fromDictionary:dict] doubleValue];
            self.weatherStateAbbr = [self objectOrNilForKey:kConsolidatedWeatherWeatherStateAbbr fromDictionary:dict];
            self.windDirection = [[self objectOrNilForKey:kConsolidatedWeatherWindDirection fromDictionary:dict] doubleValue];
            self.created = [self objectOrNilForKey:kConsolidatedWeatherCreated fromDictionary:dict];
            self.minTemp = [[self objectOrNilForKey:kConsolidatedWeatherMinTemp fromDictionary:dict] doubleValue];
            self.windSpeed = [[self objectOrNilForKey:kConsolidatedWeatherWindSpeed fromDictionary:dict] doubleValue];
            self.visibility = [[self objectOrNilForKey:kConsolidatedWeatherVisibility fromDictionary:dict] doubleValue];
            self.theTemp = [[self objectOrNilForKey:kConsolidatedWeatherTheTemp fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.consolidatedWeatherIdentifier] forKey:kConsolidatedWeatherId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.airPressure] forKey:kConsolidatedWeatherAirPressure];
    [mutableDict setValue:self.applicableDate forKey:kConsolidatedWeatherApplicableDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kConsolidatedWeatherHumidity];
    [mutableDict setValue:self.weatherStateName forKey:kConsolidatedWeatherWeatherStateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.predictability] forKey:kConsolidatedWeatherPredictability];
    [mutableDict setValue:self.windDirectionCompass forKey:kConsolidatedWeatherWindDirectionCompass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.maxTemp] forKey:kConsolidatedWeatherMaxTemp];
    [mutableDict setValue:self.weatherStateAbbr forKey:kConsolidatedWeatherWeatherStateAbbr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.windDirection] forKey:kConsolidatedWeatherWindDirection];
    [mutableDict setValue:self.created forKey:kConsolidatedWeatherCreated];
    [mutableDict setValue:[NSNumber numberWithDouble:self.minTemp] forKey:kConsolidatedWeatherMinTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.windSpeed] forKey:kConsolidatedWeatherWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.visibility] forKey:kConsolidatedWeatherVisibility];
    [mutableDict setValue:[NSNumber numberWithDouble:self.theTemp] forKey:kConsolidatedWeatherTheTemp];

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

    self.consolidatedWeatherIdentifier = [aDecoder decodeDoubleForKey:kConsolidatedWeatherId];
    self.airPressure = [aDecoder decodeDoubleForKey:kConsolidatedWeatherAirPressure];
    self.applicableDate = [aDecoder decodeObjectForKey:kConsolidatedWeatherApplicableDate];
    self.humidity = [aDecoder decodeDoubleForKey:kConsolidatedWeatherHumidity];
    self.weatherStateName = [aDecoder decodeObjectForKey:kConsolidatedWeatherWeatherStateName];
    self.predictability = [aDecoder decodeDoubleForKey:kConsolidatedWeatherPredictability];
    self.windDirectionCompass = [aDecoder decodeObjectForKey:kConsolidatedWeatherWindDirectionCompass];
    self.maxTemp = [aDecoder decodeDoubleForKey:kConsolidatedWeatherMaxTemp];
    self.weatherStateAbbr = [aDecoder decodeObjectForKey:kConsolidatedWeatherWeatherStateAbbr];
    self.windDirection = [aDecoder decodeDoubleForKey:kConsolidatedWeatherWindDirection];
    self.created = [aDecoder decodeObjectForKey:kConsolidatedWeatherCreated];
    self.minTemp = [aDecoder decodeDoubleForKey:kConsolidatedWeatherMinTemp];
    self.windSpeed = [aDecoder decodeDoubleForKey:kConsolidatedWeatherWindSpeed];
    self.visibility = [aDecoder decodeDoubleForKey:kConsolidatedWeatherVisibility];
    self.theTemp = [aDecoder decodeDoubleForKey:kConsolidatedWeatherTheTemp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_consolidatedWeatherIdentifier forKey:kConsolidatedWeatherId];
    [aCoder encodeDouble:_airPressure forKey:kConsolidatedWeatherAirPressure];
    [aCoder encodeObject:_applicableDate forKey:kConsolidatedWeatherApplicableDate];
    [aCoder encodeDouble:_humidity forKey:kConsolidatedWeatherHumidity];
    [aCoder encodeObject:_weatherStateName forKey:kConsolidatedWeatherWeatherStateName];
    [aCoder encodeDouble:_predictability forKey:kConsolidatedWeatherPredictability];
    [aCoder encodeObject:_windDirectionCompass forKey:kConsolidatedWeatherWindDirectionCompass];
    [aCoder encodeDouble:_maxTemp forKey:kConsolidatedWeatherMaxTemp];
    [aCoder encodeObject:_weatherStateAbbr forKey:kConsolidatedWeatherWeatherStateAbbr];
    [aCoder encodeDouble:_windDirection forKey:kConsolidatedWeatherWindDirection];
    [aCoder encodeObject:_created forKey:kConsolidatedWeatherCreated];
    [aCoder encodeDouble:_minTemp forKey:kConsolidatedWeatherMinTemp];
    [aCoder encodeDouble:_windSpeed forKey:kConsolidatedWeatherWindSpeed];
    [aCoder encodeDouble:_visibility forKey:kConsolidatedWeatherVisibility];
    [aCoder encodeDouble:_theTemp forKey:kConsolidatedWeatherTheTemp];
}

- (id)copyWithZone:(NSZone *)zone {
    ConsolidatedWeather *copy = [[ConsolidatedWeather alloc] init];
    
    
    
    if (copy) {

        copy.consolidatedWeatherIdentifier = self.consolidatedWeatherIdentifier;
        copy.airPressure = self.airPressure;
        copy.applicableDate = [self.applicableDate copyWithZone:zone];
        copy.humidity = self.humidity;
        copy.weatherStateName = [self.weatherStateName copyWithZone:zone];
        copy.predictability = self.predictability;
        copy.windDirectionCompass = [self.windDirectionCompass copyWithZone:zone];
        copy.maxTemp = self.maxTemp;
        copy.weatherStateAbbr = [self.weatherStateAbbr copyWithZone:zone];
        copy.windDirection = self.windDirection;
        copy.created = [self.created copyWithZone:zone];
        copy.minTemp = self.minTemp;
        copy.windSpeed = self.windSpeed;
        copy.visibility = self.visibility;
        copy.theTemp = self.theTemp;
    }
    
    return copy;
}


@end
