//
//  Sources.h
//
//  Created by Dimitar Spasovski on 2/16/19
//  Copyright (c) 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Sources : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double crawlRate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
