//
//  LabColor.m
//  Lab Color Space Explorer
//
//  Created by Daniel Eggert on 01/12/2013.
//  Copyright (c) 2013 objc.io. All rights reserved.
//

#import "LabColor.h"

@interface LabColor ()

@property (nonatomic, readonly) double xComponent;
@property (nonatomic, readonly) double yComponent;
@property (nonatomic, readonly) double zComponent;

@end

static double inverseF(double const t);
static double D65TristimulusValues[3] = {95.047, 100.0, 108.883};

@implementation LabColor

- (id)init
{
    self = [super init];
    if (self) {
        self.lComponent = 75 + (arc4random_uniform(200) * 0.1 - 10.);
        self.aComponent = 0 + (arc4random_uniform(200) * 0.1 - 10.);
        self.bComponent = 0 + (arc4random_uniform(200) * 0.1 - 10.);
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {%g, %g, %g}", [self class], self, self.lComponent, self.aComponent, self.bComponent];
}


- (NSString *)rgbDescription
{
    return [NSString stringWithFormat:@"%g, %g, %g", self.redComponent, self.greenComponent, self.blueComponent];
}

+ (NSSet *)keyPathsForValuesAffectingXComponent
{
    return [NSSet setWithObjects:@"aComponent", @"yComponent", nil];
}

- (double)xComponent
{
    double x = (self.aComponent / 500) + self.yComponent;
    x = [self labToXyzConvertVar:x] * D65TristimulusValues[0];
  //  return x;
    
    return D65TristimulusValues[1] * inverseF(1./116. * (self.lComponent + 16) + 1./500.*self.aComponent);

}

+ (NSSet *)keyPathsForValuesAffectingYComponent
{
    return [NSSet setWithObject:@"lComponent"];
}

- (double)yComponent
{
    double y = (self.lComponent + 16.) / 116.;
    y = [self labToXyzConvertVar:y] * D65TristimulusValues[1];
    //return y;
    
    return D65TristimulusValues[0] * inverseF(1./116. * (self.lComponent + 16));

}

+ (NSSet *)keyPathsForValuesAffectingZComponent
{
    return [NSSet setWithObjects:@"bComponent", @"yComponent", nil];
}

- (double)zComponent
{
    double z = self.yComponent - (self.bComponent / 200.);
    z = [self labToXyzConvertVar:z] * D65TristimulusValues[2];
    //return z;
    
    return D65TristimulusValues[2] * inverseF(1./116. * (self.lComponent + 16) - 1./200.*self.bComponent);

}

- (double)labToXyzConvertVar:(double)var
{
    double convertedVar =
    (var * var * var > 0.008856) ?
    var*var*var :
    ( var - 16. / 116. ) / 7.787;
    return convertedVar;
}

- (double)xyzToRgbConvertVar:(double)var
{
    double convertedVar =
    (var > 0.0031308) ?
    1.055 * ( pow(var, 1. / 2.4) ) - 0.055 :
    12.92 * var;
    return convertedVar;
}

+ (NSSet *)keyPathsForValuesAffectingRedComponent
{
    return [NSSet setWithObjects:@"xComponent", @"yComponent", @"zComponent", nil];
}

- (double)redComponent;
{
    double x = self.xComponent / 100.;
    double y = self.yComponent / 100.;
    double z = self.zComponent / 100.;
    
    double red = x *  3.2406 + y * -1.5372 + z * -0.4986;
    red = [self xyzToRgbConvertVar:red];
    return  red;
    
    //return D65TristimulusValues[0] * inverseF(1./116. * (self.lComponent + 16));
}

+ (NSSet *)keyPathsForValuesAffectingGreenComponent
{
    return [NSSet setWithObjects:@"xComponent", @"yComponent", @"zComponent", nil];
}

- (double)greenComponent
{
    double x = self.xComponent / 100.;
    double y = self.yComponent / 100.;
    double z = self.zComponent / 100.;
    
    double green = x * -0.9689 + y *  1.8758 + z *  0.0415;
    green = [self xyzToRgbConvertVar:green];
    
    return green;
    
    //return D65TristimulusValues[1] * inverseF(1./116. * (self.lComponent + 16) + 1./500.*self.aComponent);
}

+ (NSSet *)keyPathsForValuesAffectingBlueComponent
{
    return [NSSet setWithObjects:@"xComponent", @"yComponent", @"zComponent", nil];
}

- (double)blueComponent
{
    double x = self.xComponent / 100.;
    double y = self.yComponent / 100.;
    double z = self.zComponent / 100.;
    
    double blue = x *  0.0557 + y * -0.2040 + z *  1.0570;
    blue = [self xyzToRgbConvertVar:blue];
    
    return blue;
    
    //return D65TristimulusValues[2] * inverseF(1./116. * (self.lComponent + 16) - 1./200.*self.bComponent);
}

+ (NSSet *)keyPathsForValuesAffectingColor
{
    return [NSSet setWithObjects:@"redComponent", @"greenComponent", @"blueComponent", nil];
}

- (UIColor *)color
{
    return [UIColor colorWithRed:self.redComponent /* * 0.01 */ green:self.greenComponent /* * 0.01 */ blue:self.blueComponent /* * 0.01 */ alpha:1.];
}

@end

static double inverseF(double const t)
{
    return ((t > 6./29.) ?
            t*t*t :
            3.*(6./29.)*(6./29.)*(t-4./29.));
}
