//
//  HTTPRequest.m
//  SpaceXPedia
//
//  Created by Rojina Shrestha on 2/8/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest

+ (void) makeHTTPGetRequest:(NSString *) urlString
                    success:(void (^)(NSData *data)) success
                    failure:(void (^)(NSError *error)) failure {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (error == nil) {
                        success(data);
                    } else {
                        NSLog(@"Error in http request: %@", urlString);
                        failure(error);
                    }
    }] resume];
    
}


@end
