
//
//  MULoaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MULoaderView.h"

@interface MULoaderView ()

@property(nonatomic,strong) CAShapeLayer *loaderLayer;

@end
@implementation MULoaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if(CGRectEqualToRect(CGRectZero, frame)) {
        frame = CGRectMake(0, 0, 24, 24);
    }
    
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    
    return self;
}

-(void)initialize {
    self.backgroundColor = [UIColor clearColor];
    
    _loaderLayer = [[CAShapeLayer alloc] init];
    _loaderLayer.frame = self.bounds;
    _loaderLayer.lineWidth = 2;
    _loaderLayer.lineCap = kCALineCapRound;
    _loaderLayer.lineJoin = kCALineJoinBevel;
    _loaderLayer.fillColor = [[UIColor clearColor] CGColor];
    _loaderLayer.strokeColor = [[self hexColor:0xe0e0e0] CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    [path addArcWithCenter:center radius:CGRectGetWidth(self.frame) / 2 - 2 startAngle:-M_PI_2 endAngle:M_PI + M_PI_2 clockwise:YES];
    _loaderLayer.path = path.CGPath;
    _loaderLayer.mask = [self maskLayer];
    [self.layer addSublayer:_loaderLayer];
}

-(CALayer*)maskLayer {
    CALayer *maskLayer = [CALayer layer];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"MULoaderResource" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"mask" ofType:@"png"];
    maskLayer.contents = (__bridge id)[[UIImage imageWithContentsOfFile:path] CGImage];
    maskLayer.frame = _loaderLayer.bounds;
    return maskLayer;
}

-(void)beginAnimation {
    
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [self.layer addAnimation:animation forKey:@"rotate"];
}

-(void)stopAnimation {
    [self.layer removeAllAnimations];
}

-(UIColor*)hexColor:(NSInteger)hexValue {
    
    CGFloat red = (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0;
    CGFloat green = (CGFloat)((hexValue & 0xFF00) >> 8) /255.0;
    CGFloat blue = (CGFloat)(hexValue & 0xFF) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}


@end
