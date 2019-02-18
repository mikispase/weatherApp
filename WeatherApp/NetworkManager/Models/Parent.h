//
//  Parent.h
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Parent : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double woeid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *locationType;
@property (nonatomic, strong) NSString *lattLong;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
