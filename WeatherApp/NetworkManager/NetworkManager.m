//
//  NetworkManager.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/15/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+(AFHTTPSessionManager*)managerConfiguration
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    return manager;
}

+(void)serverClientBaseGet:(NSString *)url params:(NSDictionary *)params blockSuccess:(void (^)(id responseObject)) successCallback
             errorCallback:(void (^)(NSError *errorMessage, NSInteger statusCode ,NSString *errorMsg)) errorCallback{
    AFHTTPSessionManager *manager = [NetworkManager managerConfiguration];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         successCallback(responseObject);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
         
         NSDictionary *responseheaders = [httpResponse allHeaderFields];
         NSString *errorCode = responseheaders[@"errorCode"];
         NSString *errorMsg =responseheaders[@"errorMsg"];
         NSString *correctString = @"";
         if(errorMsg.length)
             correctString = [NSString stringWithCString:[errorMsg cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]?:@"";
         
         if (correctString.length == 0) {
             correctString = [error.userInfo valueForKey:NSLocalizedDescriptionKey];
             errorCode =[NSString stringWithFormat:@"%ld",(long)error.code];
             
         }
         
         
         errorCallback(error,[errorCode integerValue],correctString);
     }];
}





@end
