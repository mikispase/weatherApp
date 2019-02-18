//
//  ServerInvoker.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/15/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "ServerInvoker.h"
#import "Reachability.h"
#import "NSString+URL.h"



@implementation ServerInvoker

+(NSString *)preetyJsonFormater:(id)responceObject
{
    NSString *preetyJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responceObject options:1 error:nil] encoding:4];
    
    return preetyJson;
}

+ (BOOL)connectedToInternet
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    
    return networkStatus != NotReachable;
}



+(void)getNewForecast:(NSDictionary *)params blockSuccess:(void (^)(id forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback {
    
    //https://www.metaweather.com/api/location/search/?query=sofia
    
    NSString *location = params[@"location"];
    location = [location stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [NetworkManager serverClientBaseGet:[NSString stringWithFormat:@"%@/%@/%@?%@=%@",SERVICE_BASE_URL,LOCATION,SEARCH,QUERY,location]
                                 params:params
                           blockSuccess:^(id responseObject)
     {
         successCallback(responseObject);
     } errorCallback:^(NSError *errorMessage, NSInteger statusCode,NSString *errorMsg) {
         errorCallback(errorMessage,statusCode,errorMsg);
     }];
}


+(void)getAllForecast:(NSDictionary *)params blockSuccess:(void (^)(ForeCastDays *forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback
{
    NSString *woeid = params[@"woeid"];
    
 //   https://www.metaweather.com/api/location/839722
    
    [NetworkManager serverClientBaseGet:[NSString stringWithFormat:@"%@/%@/%@",SERVICE_BASE_URL,LOCATION,woeid]
                                 params:params
                           blockSuccess:^(id responseObject)
     {
         
         DLog(@"%@",[ServerInvoker preetyJsonFormater:responseObject]);
         
         ForeCastDays *forecastDays = [ForeCastDays modelObjectWithDictionary:responseObject];
         
         successCallback(forecastDays);
     } errorCallback:^(NSError *errorMessage, NSInteger statusCode,NSString *errorMsg) {
         errorCallback(errorMessage,statusCode,errorMsg);
     }];
}

+(void)getDateForecast:(NSDictionary *)params blockSuccess:(void (^)(NSArray *forecast)) successCallback errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode, NSString *errorMsg )) errorCallback
{
    NSString *woeid = params[@"woeid"];
    NSString *date = params[@"date"];

    date = [date stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
//  https://www.metaweather.com/api/location/839722/2019/02/24
    
    [NetworkManager serverClientBaseGet:[NSString stringWithFormat:@"%@/%@/%@/%@",SERVICE_BASE_URL,LOCATION,woeid,date]
                                 params:params
                           blockSuccess:^(id responseObject)
     {
         successCallback(responseObject);
     } errorCallback:^(NSError *errorMessage, NSInteger statusCode,NSString *errorMsg) {
         errorCallback(errorMessage,statusCode,errorMsg);
     }];
}


@end
