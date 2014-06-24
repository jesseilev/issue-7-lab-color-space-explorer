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
@property (nonatomic) NSDictionary *colorDict1;

@end

@implementation LabColorTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.lColor = [LabColor new];
    self.colorDict1 = @{
                    @"l":@(76.37),  @"a":@(21.18),  @"b":@(74.94),
                    
                    @"x":@(55.925), @"y":@(50.942), @"z":@(8.041),
                    
                    @"red":@(0.99826), @"green":@(0.67160), @"blue":@(0.11850)
                        };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.lColor = nil;
    self.colorDict1 = nil;
    [super tearDown];
}

- (void)testXYZValues1
{
    self.lColor.lComponent = [self.colorDict1[@"l"] floatValue];
    self.lColor.aComponent = [self.colorDict1[@"a"] floatValue];
    self.lColor.bComponent = [self.colorDict1[@"b"] floatValue];
    float accuracy = 3.0; // 3% of range [0.0 thru 100.0]
    CGFloat xExpected = [self.colorDict1[@"x"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.xComponent, xExpected, accuracy, @"Incorrect X");
    CGFloat yExpected = [self.colorDict1[@"y"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.yComponent, yExpected, accuracy, @"Incorrect Y");
    CGFloat zExpected = [self.colorDict1[@"z"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.zComponent, zExpected, accuracy, @"Incorrect Z");
}

- (void)testRGBValues1
{
    NSLog(@"%s doing work...", __PRETTY_FUNCTION__);
    self.lColor.lComponent = [self.colorDict1[@"l"] floatValue];
    self.lColor.aComponent = [self.colorDict1[@"a"] floatValue];
    self.lColor.bComponent = [self.colorDict1[@"b"] floatValue];
    float accuracy = 0.06; //6% of range [0.0 thru 1.0]
    CGFloat rExpected = [self.colorDict1[@"red"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.redComponent, rExpected, accuracy, @"Incorrect Red");
    CGFloat gExpected = [self.colorDict1[@"green"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.greenComponent, gExpected, accuracy, @"Incorrect Green");
    CGFloat bExpected = [self.colorDict1[@"blue"] floatValue];
    XCTAssertEqualWithAccuracy(self.lColor.blueComponent, bExpected, accuracy, @"Incorrect Blue");
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
