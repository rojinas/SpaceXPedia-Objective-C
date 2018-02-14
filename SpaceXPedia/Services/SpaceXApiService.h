//
//  SpaceXApiService.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RocketModel.h"

@interface SpaceXApiService : NSObject

extern const NSString *spaceXApiHost;

+ (void) getRocketDataAsModelList:(NSString *) rocketName
               success:(void (^)(NSMutableArray *models)) success
               failure:(void (^)(NSError *error)) failure;

+ (void) getCapsuleData:(NSString *) capsule
                success:(void (^)(NSArray *models)) success
                failure:(void (^)(NSError *error)) failure;

+ (void) getUpcomingLaunches:(NSString *) rocket
                     success:(void (^)(NSArray *models)) success
                     failure:(void (^)(NSError *error)) failure;

+ (void) getPastLaunches:(NSString *) launchYear
                 success:(void (^)(NSArray *models)) success
                 failure:(void (^)(NSError *error)) failure;

@end
