//
//  AxCircularProgressBarView.m
//  MBCircularProgressBar
//
//  Created by Thaya Paran on 4/2/18.
//

#import "AxCircularProgressBarView.h"
#import "AxCircularProgressBarLayer.h"

@implementation AxCircularProgressBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setUnitOffset:(CGPoint)unitOffset{
    self.progressLayer.unitOffset = unitOffset;
}

-(CGPoint)unitOffset{
    return self.progressLayer.unitOffset;
}

#pragma mark - CALayer

-(AxCircularProgressBarLayer*)progressLayer{
    AxCircularProgressBarLayer* layer = (AxCircularProgressBarLayer*) self.layer;
    return layer;
}

+ (Class) layerClass {
    return [AxCircularProgressBarLayer class];
}

@end
