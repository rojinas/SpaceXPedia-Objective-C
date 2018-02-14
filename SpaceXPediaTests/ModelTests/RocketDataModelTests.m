//
//  RocketDataModelTests.m
//  SpaceXPediaTests
//
//  Created by Rojina Shrestha on 2/11/18.
//  Copyright © 2018 NA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RocketModel.h"

@interface RocketDataModelTests : XCTestCase

@end

@implementation RocketDataModelTests

NSMutableArray *models;

- (void)setUp {
    [super setUp];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"RocketTestData" ofType:@"json"];
    XCTAssert([path length] > 5, @"File path should be more than 5 chars long");
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    XCTAssertNotNil(data, @"Cannot process empty content");
    
    models = [RocketModel parseData:data];
}

- (void)tearDown {
    [super tearDown];
}

-(void) testModelData {
    XCTAssertNotNil(models, @"Parsed model array should not be nil");
    XCTAssertEqual([models count], 3, @"Parsed model array should have exactly 3 elements");
    XCTAssert([[models objectAtIndex:0] isKindOfClass:[RocketModel class]], @"Parsed model should be an instance of RocketModel class");
   
    RocketModel *model = [models objectAtIndex:0];
    XCTAssertNotNil(model, @"Model element should not be nil");
    
    XCTAssertNotNil(model.description, @"Model description field should not be nil");
    XCTAssert([model.id isEqualToString:@"falcon1"], "@Model id value should be falcon1");
}

@end
