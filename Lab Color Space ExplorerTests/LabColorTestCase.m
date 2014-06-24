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

@property (nonatomic) LabColor *lColor;
@property (nonatomic) NSArray *labValues1;
@property (nonatomic) NSArray *xyzValues1;
@property (nonatomic) NSArray *rgbValues1;

@end

@implementation LabColorTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.lColor = [LabColor new];
    self.labValues1 = @[ @(76.37), @(21.18), @(74.94) ];
    self.xyzValues1 = @[ @(55.925), @(50.942), @(8.041) ];
    self.rgbValues1 = @[ @(0.99826), @(0.67160), @(0.11850) ];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.lColor = nil;
    self.labValues1 = nil;
    self.rgbValues1 = nil;
    [super tearDown];
}

- (void)testRGBValues1
{
    NSLog(@"%s doing work...", __PRETTY_FUNCTION__);
    self.lColor.lComponent = [self.labValues1[0] floatValue];
    self.lColor.aComponent = [self.labValues1[1] floatValue];
    self.lColor.bComponent = [self.labValues1[2] floatValue];
    float accuracy = 0.06;
    CGFloat rExpected = [self.rgbValues1[0] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.redComponent, rExpected, accuracy, @"Incorrect Red");
    CGFloat gExpected = [self.rgbValues1[1] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.greenComponent, gExpected, accuracy, @"Incorrect Green");
    CGFloat bExpected = [self.rgbValues1[2] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.blueComponent, bExpected, accuracy, @"Incorrect Blue");
}

- (void)testXYZValues1
{
    self.lColor.lComponent = [self.labValues1[0] floatValue];
    self.lColor.aComponent = [self.labValues1[1] floatValue];
    self.lColor.bComponent = [self.labValues1[2] floatValue];
    float accuracy = 3.0;
    CGFloat xExpected = [self.xyzValues1[0] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.xComponent, xExpected, accuracy, @"Incorrect X");
    CGFloat yExpected = [self.xyzValues1[1] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.yComponent, yExpected, accuracy, @"Incorrect Y");
    CGFloat zExpected = [self.xyzValues1[2] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.zComponent, zExpected, accuracy, @"Incorrect Z");
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
