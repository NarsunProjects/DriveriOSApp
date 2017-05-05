//
//  IGNetworkManager.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 29/12/2016.
//  Copyright © 2016 Narsun. All rights reserved.
//

#import "IGNetworkManager.h"


@implementation IGNetworkManager


+(void)driverRequestLogInWithParam:(NSDictionary *)param success:(LoginSuccess)success failure:(StatusFailure)failure apiFailure:(HttpFailure)apiFailure{
        NSString *urlString = [NSString stringWithFormat:@"%@",kLoginURL];
        NSLog(@"%@", urlString);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
        [manager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            //数据请求的进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *error;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
            NSString *status = [dictionary objectForKey:@"Status"];
            if ([status isEqualToString:@"Success"]) {
                NSDictionary *dict = [dictionary objectForKey:@"data"];
                IGUser *user = [[IGUser alloc]init];
                [user fetchDataFromDictionary:dict];
                
                NSArray *request = [dictionary valueForKey:@"request"];
                
                            
                [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"DriverId"] forKey:@"CustomerId"];
                [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"latitude"] forKey:@"latitiude"];
                [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"longitude"] forKey:@"longitude"];
                
                
                success(user);
    
            }
            else{
                NSString *string = @"Invalid Email/Password";
                failure(string);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            apiFailure(error);
        }];
}


+(void)updateGCMWithParam:(NSDictionary *)param success:(StatusSuccess)success failure:(StatusFailure)failure apiFailure:(HttpFailure)apiFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@",kLoginURL];
    NSLog(@"%@", urlString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSString *status = [dictionary objectForKey:@"Status"];
        if ([status isEqualToString:@"Success"]) {
            success(status);
            
        }
        else{
            NSString *string = @"Invalid Email/Password";
            failure(string);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        apiFailure(error);
    }];
}




@end
