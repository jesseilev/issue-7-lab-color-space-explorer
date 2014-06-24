//
//  LabColorTestCase.m
//  Lab Color Space Explorer
//
//  Created by Jesse Levine on 6/23/14.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LabColor.h"

@interface LabColorTestCase : XCTestCase

@end

@implementation LabColorTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super tearDown];
}

- (void)testLabColorRGBValues
{
    LabColor *lColor = [LabColor new];
    lColor.lComponent = 76.37;
    lColor.aComponent = 21.18;
    lColor.bComponent = 74.94;
    CGFloat r, g, b;
    [lColor.color getRed:&r green:&g blue:&b alpha:nil];
    CGFloat rExpected = 0.99826;
    CGFloat gExpected = 0.67160;
    CGFloat bExpected = 0.11850;
    XCTAssertEqualWithAccuracy(lColor.redComponent, rExpected, 0.06, "Incorrect Red");
    XCTAssertEqualWithAccuracy(lColor.greenComponent, gExpected, 0.06, "Incorrect Green");
    XCTAssertEqualWithAccuracy(lColor.blueComponent, bExpected, 0.06, "Incorrect Blue");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark Helpers

- (BOOL)compareFloat:(CGFloat)val with:(CGFloat)otherVal tolerance:(CGFloat)tolerance
{
    CGFloat dif = ABS(val - otherVal);
    return (dif <= tolerance) ? YES : NO;
}

@end
