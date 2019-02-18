//
//  CityID.m
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import "CityID.h"


NSString *const kCityIDWoeid = @"woeid";
NSString *const kCityIDTitle = @"title";
NSString *const kCityIDLocationType = @"location_type";
NSString *const kCityIDLattLong = @"latt_long";


@interface CityID ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityID

@synthesize woeid = _woeid;
@synthesize title = _title;
@synthesize locationType = _locationType;
@synthesize lattLong = _lattLong;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.woeid = [[self objectOrNilForKey:kCityIDWoeid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kCityIDTitle fromDictionary:dict];
            self.locationType = [self objectOrNilForKey:kCityIDLocationType fromDictionary:dict];
            self.lattLong = [self objectOrNilForKey:kCityIDLattLong fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.woeid] forKey:kCityIDWoeid];
    [mutableDict setValue:self.title forKey:kCityIDTitle];
    [mutableDict setValue:self.locationType forKey:kCityIDLocationType];
    [mutableDict setValue:self.lattLong forKey:kCityIDLattLong];

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

    self.woeid = [aDecoder decodeDoubleForKey:kCityIDWoeid];
    self.title = [aDecoder decodeObjectForKey:kCityIDTitle];
    self.locationType = [aDecoder decodeObjectForKey:kCityIDLocationType];
    self.lattLong = [aDecoder decodeObjectForKey:kCityIDLattLong];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_woeid forKey:kCityIDWoeid];
    [aCoder encodeObject:_title forKey:kCityIDTitle];
    [aCoder encodeObject:_locationType forKey:kCityIDLocationType];
    [aCoder encodeObject:_lattLong forKey:kCityIDLattLong];
}

- (id)copyWithZone:(NSZone *)zone {
    CityID *copy = [[CityID alloc] init];
    
    
    
    if (copy) {

        copy.woeid = self.woeid;
        copy.title = [self.title copyWithZone:zone];
        copy.locationType = [self.locationType copyWithZone:zone];
        copy.lattLong = [self.lattLong copyWithZone:zone];
    }
    
    return copy;
}


@end
