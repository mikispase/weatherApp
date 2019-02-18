//
//  Sources.m
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import "Sources.h"


NSString *const kSourcesTitle = @"title";
NSString *const kSourcesSlug = @"slug";
NSString *const kSourcesUrl = @"url";
NSString *const kSourcesCrawlRate = @"crawl_rate";


@interface Sources ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Sources

@synthesize title = _title;
@synthesize slug = _slug;
@synthesize url = _url;
@synthesize crawlRate = _crawlRate;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.title = [self objectOrNilForKey:kSourcesTitle fromDictionary:dict];
            self.slug = [self objectOrNilForKey:kSourcesSlug fromDictionary:dict];
            self.url = [self objectOrNilForKey:kSourcesUrl fromDictionary:dict];
            self.crawlRate = [[self objectOrNilForKey:kSourcesCrawlRate fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kSourcesTitle];
    [mutableDict setValue:self.slug forKey:kSourcesSlug];
    [mutableDict setValue:self.url forKey:kSourcesUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.crawlRate] forKey:kSourcesCrawlRate];

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

    self.title = [aDecoder decodeObjectForKey:kSourcesTitle];
    self.slug = [aDecoder decodeObjectForKey:kSourcesSlug];
    self.url = [aDecoder decodeObjectForKey:kSourcesUrl];
    self.crawlRate = [aDecoder decodeDoubleForKey:kSourcesCrawlRate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kSourcesTitle];
    [aCoder encodeObject:_slug forKey:kSourcesSlug];
    [aCoder encodeObject:_url forKey:kSourcesUrl];
    [aCoder encodeDouble:_crawlRate forKey:kSourcesCrawlRate];
}

- (id)copyWithZone:(NSZone *)zone {
    Sources *copy = [[Sources alloc] init];
    
    
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.slug = [self.slug copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.crawlRate = self.crawlRate;
    }
    
    return copy;
}


@end
