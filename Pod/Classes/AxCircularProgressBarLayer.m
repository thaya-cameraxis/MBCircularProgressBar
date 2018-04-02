//
//  AxCircularProgressBarLayer.m
//  MBCircularProgressBar
//
//  Created by Thaya Paran on 4/2/18.
//

#import "AxCircularProgressBarLayer.h"

@implementation AxCircularProgressBarLayer

@dynamic unitOffset;

- (void)drawEmptyBar:(CGRect)rect context:(CGContextRef)c{
    
    if(self.emptyLineWidth <= 0){
        return;
    }
    
    CGPoint center = {CGRectGetMidX(rect), CGRectGetMidY(rect)};
    CGFloat radius = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect))/2;
    if (self.progressAppearanceType == MBCircularProgressBarAppearanceTypeOverlaysEmptyLine) {
        radius = radius - MAX(self.emptyLineWidth, self.progressLineWidth)/2.f;
    } else if (self.progressAppearanceType == MBCircularProgressBarAppearanceTypeAboveEmptyLine) {
        radius = radius - self.progressLineWidth - self.emptyLineWidth/2.f;
    } else {
        radius = radius - self.emptyLineWidth/2.f;
    }
    
    CGMutablePathRef arc = CGPathCreateMutable();
    CGPathAddArc(arc, NULL,
                 center.x, center.y, radius,
                 (self.progressAngle/100.f)*M_PI-((-self.progressRotationAngle/100.f)*2.f+0.5)*M_PI,
                 -(self.progressAngle/100.f)*M_PI-((-self.progressRotationAngle/100.f)*2.f+0.5)*M_PI,
                 YES);
    
    CGPathRef strokedArc =
    CGPathCreateCopyByStrokingPath(arc, NULL,
                                   self.emptyLineWidth,
                                   (CGLineCap)self.emptyCapType,
                                   kCGLineJoinMiter,
                                   10);
    
    CGMutablePathRef bottomRound = CGPathCreateMutable();
    CGPathAddArc(bottomRound, NULL, center.x, center.y+radius,0,M_PI,-M_PI, YES);
    CGPathRef bottoumRoundstrokedArc = CGPathCreateCopyByStrokingPath(bottomRound, NULL,
                                   self.emptyLineWidth/2,
                                   (CGLineCap)self.emptyCapType,
                                   kCGLineJoinMiter,
                                   10);
    
    
    CGContextAddPath(c, strokedArc);
    CGContextAddPath(c, bottoumRoundstrokedArc);
    CGContextSetStrokeColorWithColor(c, self.emptyLineStrokeColor.CGColor);
    CGContextSetFillColorWithColor(c, self.emptyLineColor.CGColor);
    CGContextDrawPath(c, kCGPathFillStroke);
    
    CGPathRelease(arc);
    CGPathRelease(strokedArc);
    CGPathRelease(bottomRound);
    CGPathRelease(bottoumRoundstrokedArc);
}

- (void)drawText:(CGRect)rect context:(CGContextRef)c{
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    
    CGFloat valueFontSize = self.valueFontSize == -1 ? CGRectGetHeight(rect)/5 : self.valueFontSize;
    
    NSDictionary* valueFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: self.valueFontName size:valueFontSize], NSForegroundColorAttributeName: self.fontColor, NSParagraphStyleAttributeName: textStyle};
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSString *formatString = [NSString stringWithFormat:@"%%.%df", (int)self.decimalPlaces];
    
    NSString* textToPresent;
    if (self.countdown) {
        textToPresent = [NSString stringWithFormat:formatString, (self.maxValue - self.value)];
    } else {
        textToPresent = [NSString stringWithFormat:formatString, self.value];
    }
    NSAttributedString* value = [[NSAttributedString alloc] initWithString:textToPresent
                                                                attributes:valueFontAttributes];
    [text appendAttributedString:value];
    
    // set the decimal font size
    NSUInteger decimalLocation = [text.string rangeOfString:@"."].location;
    if (decimalLocation != NSNotFound){
        NSDictionary* valueDecimalFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: self.valueFontName size:self.valueDecimalFontSize == -1 ? valueFontSize : self.valueDecimalFontSize], NSForegroundColorAttributeName: self.fontColor, NSParagraphStyleAttributeName: textStyle};
        NSRange decimalRange = NSMakeRange(decimalLocation, text.length - decimalLocation);
        [text setAttributes:valueDecimalFontAttributes range:decimalRange];
    }
    
    CGSize percentSize = [text size];
    CGPoint textCenter = CGPointMake(
                                     CGRectGetMidX(rect)-percentSize.width/2 + self.textOffset.x,
                                     CGRectGetMidY(rect)-percentSize.height/2 + self.textOffset.y
                                     );
    
    // ad the unit only if specified
    if (self.showUnitString) {
        
        NSMutableAttributedString *unitText = [NSMutableAttributedString new];
        
        NSDictionary* unitFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: self.unitFontName size:self.unitFontSize == -1 ? CGRectGetHeight(rect)/7 : self.unitFontSize], NSForegroundColorAttributeName: self.fontColor, NSParagraphStyleAttributeName: textStyle};
        
        NSAttributedString* unit = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.unitString] attributes:unitFontAttributes];
        [unitText appendAttributedString:unit];
        
        CGSize unitPercentSize = [unitText size];
        CGPoint unitTextCenter = CGPointMake(
                                         CGRectGetMidX(rect) - unitPercentSize.width/2.0 + self.unitOffset.x,
                                         (CGRectGetMidY(rect) + percentSize.height/2.0) + (CGRectGetMaxY(rect) - (CGRectGetMidY(rect) + percentSize.height/2.0))/2.0 - unitPercentSize.height/2.0 - MAX(self.progressLineWidth, self.emptyLineWidth) + self.unitOffset.y
                                         );
        
        [unitText drawAtPoint:unitTextCenter];
    }
    
    [text drawAtPoint:textCenter];
}

@end
