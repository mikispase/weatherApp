//
//  NetworkManager.h
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/15/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+(void)serverClientBaseGet:(NSString *)url params:(NSDictionary *)params blockSuccess:(void (^)(id responseObject)) successCallback
             errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode ,NSString *errorMsg)) errorCallback;
@end

NS_ASSUME_NONNULL_END
