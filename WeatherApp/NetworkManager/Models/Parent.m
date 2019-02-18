//
//  Parent.m
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import "Parent.h"


NSString *const kParentWoeid = @"woeid";
NSString *const kParentTitle = @"title";
NSString *const kParentLocationType = @"location_type";
NSString *const kParentLattLong = @"latt_long";


@interface Parent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Parent

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
            self.woeid = [[self objectOrNilForKey:kParentWoeid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kParentTitle fromDictionary:dict];
            self.locationType = [self objectOrNilForKey:kParentLocationType fromDictionary:dict];
            self.lattLong = [self objectOrNilForKey:kParentLattLong fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.woeid] forKey:kParentWoeid];
    [mutableDict setValue:self.title forKey:kParentTitle];
    [mutableDict setValue:self.locationType forKey:kParentLocationType];
    [mutableDict setValue:self.lattLong forKey:kParentLattLong];

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

    self.woeid = [aDecoder decodeDoubleForKey:kParentWoeid];
    self.title = [aDecoder decodeObjectForKey:kParentTitle];
    self.locationType = [aDecoder decodeObjectForKey:kParentLocationType];
    self.lattLong = [aDecoder decodeObjectForKey:kParentLattLong];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_woeid forKey:kParentWoeid];
    [aCoder encodeObject:_title forKey:kParentTitle];
    [aCoder encodeObject:_locationType forKey:kParentLocationType];
    [aCoder encodeObject:_lattLong forKey:kParentLattLong];
}

- (id)copyWithZone:(NSZone *)zone {
    Parent *copy = [[Parent alloc] init];
    
    
    
    if (copy) {

        copy.woeid = self.woeid;
        copy.title = [self.title copyWithZone:zone];
        copy.locationType = [self.locationType copyWithZone:zone];
        copy.lattLong = [self.lattLong copyWithZone:zone];
    }
    
    return copy;
}


@end
