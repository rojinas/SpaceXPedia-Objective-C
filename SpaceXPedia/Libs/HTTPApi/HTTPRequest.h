//
//  HTTPRequest.h
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject
    
+(void) makeHTTPGetRequest:(NSString *) urlString
                    success:(void (^)(NSData *data)) success
                    failure:(void (^)(NSError *error)) failure;


@end
