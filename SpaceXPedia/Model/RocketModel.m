//
//  RocketModel.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "RocketModel.h"

@implementation RocketModel

@synthesize description;


+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}

+(NSMutableArray *) parseData:(NSData *) data {
    NSError *error;
    NSArray *arrayOfDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray *arrayofModel = [[NSMutableArray alloc] init];
    for(id object in arrayOfDict){
        error = nil;
        RocketModel *model = [[RocketModel alloc] initWithDictionary:object error:&error];
        if (error == nil) {
            [arrayofModel addObject:model];
        }
    }
    
    return arrayofModel;
}

@end
