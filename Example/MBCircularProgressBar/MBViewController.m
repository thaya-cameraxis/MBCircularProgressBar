//
//  MBViewController.m
//  MBCircularProgressBar
//
//  Created by Mati Bot on 07/19/2015.
//  Copyright (c) 2015 Mati Bot. All rights reserved.
//

#import "MBViewController.h"
#import <MBCircularProgressBar/AxCircularProgressBarView.h>

@interface MBViewController ()

@property (weak, nonatomic) IBOutlet AxCircularProgressBarView *progressBar;
@property (weak, nonatomic) IBOutlet UISwitch *animatedSwitch;

@end

@implementation MBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.progressBar.layer.cornerRadius = self.progressBar.frame.size.height/2.0;
    self.progressBar.backgroundColor = [UIColor whiteColor];
    
    UIColor *lightGreen = [UIColor colorWithRed:24.0f/255.0f green:233.0f/255.0f blue:183.0f/255.0f alpha:1];
    
    self.progressBar.borderPadding = 10.0;
    self.progressBar.progressLineWidth = 15.0;
    self.progressBar.emptyLineWidth = self.progressBar.progressLineWidth + 4.0;
    self.progressBar.emptyCapType = 1;
    self.progressBar.showUnitString = YES;
    self.progressBar.unitString = @"%";
    self.progressBar.valueFontSize = 80;
    self.progressBar.unitFontSize = 30;
    self.progressBar.fontColor = lightGreen;
    self.progressBar.valueFontName = @"Arial Rounded MT Bold";
    self.progressBar.unitFontName = self.progressBar.valueFontName;
    //self.progressBar.unitOffset = CGPointMake(0, 20.0);
    
    
    self.progressBar.progressColor = lightGreen;
    
    UIColor *emptyBarColor = [UIColor colorWithRed:93.0f/255.0f green:93.0f/255.0f blue:93.0f/255.0f alpha:1.0f];
    self.progressBar.emptyLineColor = emptyBarColor;
    self.progressBar.emptyLineStrokeColor = emptyBarColor;
}

- (IBAction)animate:(UIButton *)sender {
    [UIView animateWithDuration:self.animatedSwitch.on * 1.f animations:^{
        self.progressBar.value = 100.f - self.progressBar.value;
    }];
}


@end
