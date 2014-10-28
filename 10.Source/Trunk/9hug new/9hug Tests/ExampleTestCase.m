//
//  ExampleTestCase.m
//  9hug
//
//  Created by Tommy on 10/27/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ExampleTestCase : XCTestCase

@end

@implementation ExampleTestCase

- (void)setUp {
    [super setUp];
    NSLog(@"%s Start here",__PRETTY_FUNCTION__);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%s End here",__PRETTY_FUNCTION__);
    [super tearDown];
}

- (void)testExample {
    NSLog(@"%s testExample",__PRETTY_FUNCTION__);

    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    NSLog(@"%s testPerformanceExample",__PRETTY_FUNCTION__);

    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
