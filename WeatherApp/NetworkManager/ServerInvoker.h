//
//  ServerInvoker.h
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/15/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "Constants.h"

#import "ForeCastDays.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServerInvoker : NSObject


+(NSString *)preetyJsonFormater:(id)responceObject;

+ (BOOL)connectedToInternet;

+(void)getNewForecast:(NSDictionary *)params blockSuccess:(void (^)(id forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback;

+(void)getAllForecast:(NSDictionary *)params blockSuccess:(void (^)(ForeCastDays *forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback;

+(void)getDateForecast:(NSDictionary *)params blockSuccess:(void (^)(NSArray *forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback;

@end

NS_ASSUME_NONNULL_END
