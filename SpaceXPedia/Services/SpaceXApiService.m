//
//  SpaceXApiService.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "SpaceXApiService.h"
#import "HTTPRequest.h"

@implementation SpaceXApiService

NSString *spaceXApiHost = @"https://api.spacexdata.com/v2";

+(NSString *) buildFullURL:(NSString *) suffix {
    return [NSString stringWithFormat:@"%@/%@", spaceXApiHost, suffix];
}

+ (void) getRocketDataAsModelList:(NSString *) rocketName
                    success:(void (^)(NSMutableArray *models)) success
                    failure:(void (^)(NSError *error)) failure {
    
    NSString *url = [SpaceXApiService buildFullURL:@"rockets"];
    [HTTPRequest makeHTTPGetRequest:url
                            success:^(NSData *responseData) {
                                success([RocketModel parseData:responseData]);
                            }
     
                            failure:^(NSError *error) {
                                NSLog(@"Caught Error");
                                failure(error);
                            }];
}

+ (void) getRocketData:(NSString *) rocketName
                          success:(void (^)(NSArray *array)) success
                          failure:(void (^)(NSError *error)) failure {
    
    NSString *url = [SpaceXApiService buildFullURL:[NSString stringWithFormat:@"rockets/%@", rocketName]];
    [SpaceXApiService genericApiRequest:url
                                success:^(NSArray *array) {
                                    success(array);
                                } failure:^(NSError *error) {
                                    failure(error);
                                }];
}

+ (void) getCapsuleData:(NSString *) capsule
               success:(void (^)(NSArray *models)) success
               failure:(void (^)(NSError *error)) failure {
    
    NSString *url = [SpaceXApiService buildFullURL:@"capsules"];
    [SpaceXApiService genericApiRequest:url
                                success:^(NSArray *array) {
                                    success(array);
                                } failure:^(NSError *error) {
                                    failure(error);
                                }];
}

+ (void) getUpcomingLaunches:(NSString *) rocket
                success:(void (^)(NSArray *models)) success
                failure:(void (^)(NSError *error)) failure {
    
    NSString *rocketQuery;
    if (rocket == nil) {
        rocketQuery = @"";
    } else {
        rocketQuery = [NSString stringWithFormat:@"?rocket_id=%@", rocket];
    }
    
    NSString *url = [SpaceXApiService buildFullURL:[NSString stringWithFormat:@"launches/upcoming%@", rocketQuery]];
    [SpaceXApiService genericApiRequest:url
                                success:^(NSArray *array) {
                                    success(array);
                                } failure:^(NSError *error) {
                                    failure(error);
                                }];
}

+ (void) getPastLaunches:(NSString *) launchYear
                 success:(void (^)(NSArray *models)) success
                 failure:(void (^)(NSError *error)) failure {

    NSString *queryFilter;
    if (launchYear == nil) {
        queryFilter = @"";
    } else {
        queryFilter = [NSString stringWithFormat:@"?launch_year=%@", launchYear];
    }
    
    NSString *url = [SpaceXApiService buildFullURL:[NSString stringWithFormat:@"launches%@", queryFilter]];
    [SpaceXApiService genericApiRequest:url
                                success:^(NSArray *array) {
                                    success(array);
                                } failure:^(NSError *error) {
                                    failure(error);
                                }];
}

+ (void) genericApiRequest:(NSString *) url
                          success:(void (^)(NSArray *models)) success
                          failure:(void (^)(NSError *error)) failure {
    
    [HTTPRequest makeHTTPGetRequest:url
                            success:^(NSData *responseData) {
                                NSError *error;
                                NSArray *arrayOfDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                                success(arrayOfDict);
                            }
     
                            failure:^(NSError *error) {
                                NSLog(@"Caught Error");
                                failure(error);
                            }];
}

@end
