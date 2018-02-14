//
//  Utilities.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/10/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *) flattenDictionary:(id) input {
    
    if(input == nil) {
        return @"";
    }
    else if ( [input isKindOfClass:[NSString class]] ) {
        return input;
    } else if ( [input isKindOfClass:[NSDictionary class]] ) {
        NSDictionary *d = (NSDictionary *) input;
        NSArray *allKeys = [d allKeys];
        NSMutableArray *returnText =[[NSMutableArray alloc] init];
        for (NSString *k1 in allKeys) {
            NSString *label = [NSString stringWithFormat:@"%@: %@",
                               [Utilities formatTitle:k1],
                               [Utilities flattenDictionary:[d objectForKey:k1]]];
            [returnText addObject:label];
        }
        return [returnText componentsJoinedByString:@"\n"];
    } else if ( [input isKindOfClass:[NSArray class]]) {
        NSArray *a = (NSArray *) input;
        NSMutableArray *mutaleArray = [[NSMutableArray alloc] init];
        for (id item in a) {
            [mutaleArray addObject:[Utilities flattenDictionary:item]];
        }
        return [mutaleArray componentsJoinedByString:@","];
    } else {
        return [NSString stringWithFormat:@"%@", input];
    }
}

+(NSString *) formatTitle:(NSString *) title {
    NSString *t1 = [[title stringByReplacingOccurrencesOfString:@"_" withString:@" "] capitalizedString];
    return t1;
}

@end
