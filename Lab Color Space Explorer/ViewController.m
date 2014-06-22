//
//  ViewController.m
//  Lab Color Space Explorer
//
//  Created by Daniel Eggert on 01/12/2013.
//  Copyright (c) 2013 objc.io. All rights reserved.
//

#import "ViewController.h"

#import "LabColor.h"
#import "KeyValueObserver.h"



@interface ViewController ()

@property (nonatomic, strong) LabColor *labColor;
@property (nonatomic, strong) id colorObserveToken;
@property (weak, nonatomic) IBOutlet UISlider *lSlider;
@property (weak, nonatomic) IBOutlet UISlider *aSlider;
@property (weak, nonatomic) IBOutlet UISlider *bSlider;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *lLabel;
@property (weak, nonatomic) IBOutlet UILabel *bLabel;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;


@end


@implementation ViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
	self.labColor = [[LabColor alloc] init];
}

- (void)setLabColor:(LabColor *)labColor
{
    _labColor = labColor;
    self.colorObserveToken = [KeyValueObserver observeObject:labColor keyPath:@"color" target:self selector:@selector(colorDidChange:) options:NSKeyValueObservingOptionInitial];
    self.lSlider.value = self.labColor.lComponent;
    self.aSlider.value = self.labColor.aComponent;
    self.bSlider.value = self.labColor.bComponent;
}

- (IBAction)updateLComponent:(UISlider *)sender
{
    self.labColor.lComponent = sender.value;
    LabColor *sliderColor = [LabColor new];
    sliderColor.lComponent = sender.value;
    sliderColor.aComponent = 0;
    sliderColor.bComponent = 0;
    sender.tintColor = sliderColor.color;
    self.lLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
}

- (IBAction)updateAComponent:(UISlider *)sender
{
    self.labColor.aComponent = sender.value;
    LabColor *sliderColor = [LabColor new];
    sliderColor.lComponent = 50;
    sliderColor.aComponent = sender.value;
    sliderColor.bComponent = 0;
    sender.tintColor = sliderColor.color;
    self.aLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
}

- (IBAction)updateBComponent:(UISlider *)sender
{
    self.labColor.bComponent = sender.value;
    LabColor *sliderColor = [LabColor new];
    sliderColor.lComponent = 50;
    sliderColor.aComponent = 0;
    sliderColor.bComponent = sender.value;
    sender.tintColor = sliderColor.color;
    self.bLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
}

- (void)colorDidChange:(NSDictionary *)change
{
    //NSLog(@"%@", [self.labColor rgbDescription]);
    self.colorView.backgroundColor = self.labColor.color;
    [self refreshRGBLabels];
}

- (void)refreshRGBLabels
{
    float r; float g; float b;
    [self.labColor.color getRed:&r green:&g blue:&b alpha:nil];
    self.redLabel.text = [NSString stringWithFormat:@"%.2f", r];
    self.redLabel.textColor = (r > 0 && r < 1) ? [UIColor blackColor] : [UIColor redColor];
    self.greenLabel.text = [NSString stringWithFormat:@"%0.2f", g];
    self.greenLabel.textColor = (g > 0 && g < 1) ? [UIColor blackColor] : [UIColor redColor];
    self.blueLabel.text = [NSString stringWithFormat:@"%0.2f", b];
    self.blueLabel.textColor = (b > 0 && b < 1) ? [UIColor blackColor] : [UIColor redColor];
}

@end
