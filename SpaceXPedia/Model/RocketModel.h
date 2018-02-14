//
//  RocketModel.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface RocketModel : JSONModel
@property (nonatomic) NSString *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;
@property (nonatomic) NSInteger stages;
@property (nonatomic) NSInteger boosters;
@property (nonatomic) NSInteger costPerLaunch;
@property (nonatomic) NSInteger successRatePct;
@property (nonatomic) NSString *firstFlight;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *company;
@property (readwrite, nonatomic) NSString *description;
+(NSMutableArray *) parseData:(NSData *) data;
@end

@interface EngineModel: JSONModel
    @property (nonatomic) NSInteger number;
    @property (nonatomic) NSString *type;
    @property (nonatomic) NSString *version;
    @property (nonatomic) NSString *layout;
    @property (nonatomic) NSString *propellant1;
    @property (nonatomic) NSString *propellant2;
    @property (nonatomic) NSInteger engineLossMax;
@end
