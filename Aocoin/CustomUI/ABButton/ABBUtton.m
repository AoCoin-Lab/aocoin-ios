
//ABButton.m
//ABWallet
//
//Created by 邢现庆 on 2019/8/8.
//Copyright © 2019 Xing. All rights reserved.


#import "ABBUtton.h"

@interface HVGradientColor : NSObject
/*
 **
 *  Array of UIColor
 */
@property (nonatomic, strong, readonly) NSArray *colors;

/**
 *  初始化渐变色对象
 *
 *  @param colors 颜色数组，从左到右的顺序
 *
 *  @return 渐变色对象
 */
+ (instancetype)gradientColorWithColors:(NSArray *)colors;

@end

@interface HVGradientColor ()

- (void)setColors:(NSArray *)colors;

@end

@implementation HVGradientColor

+ (instancetype)gradientColorWithColors:(NSArray *)colors{
    HVGradientColor *gradientColor = [[HVGradientColor alloc] init];
    [gradientColor setColors:colors];
    return gradientColor;
}

- (void)setColors:(NSArray *)colors{
    _colors = colors;
}

@end


@implementation ABButton{
    NSMutableDictionary *_dictBgColor;
    NSMutableDictionary *_dictGradientColor;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (void)initSetup{
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = THEME_GREEN;
//    [self updateBackGroundColorToGradientColor];
}

//渐变背景颜色
-(void)updateBackGroundColorToGradientColor{
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:BUTTON_BG_START_COLOR,BUTTON_BG_END_COLOR,nil]] forState:UIControlStateNormal];
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:BUTTON_BG_START_COLOR,BUTTON_BG_END_COLOR,nil]] forState:UIControlStateHighlighted];
}

//灰色背景颜色
-(void)updateBackGroundColorToGrayColor{
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:(id)TIPS_COLOR,nil]] forState:UIControlStateNormal];
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:(id)TIPS_COLOR,nil]] forState:UIControlStateHighlighted];

}

-(void)updateBackGroundColorToGrayColor:(UIColor*)color{
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:(id)color,nil]] forState:UIControlStateNormal];
    [self setGradientColor:[HVGradientColor gradientColorWithColors:[NSArray arrayWithObjects:(id)color,nil]] forState:UIControlStateHighlighted];
    
}

// ----------------- gradientColor
- (void)setGradientColor:(HVGradientColor *)gradientColor forState:(UIControlState)state{
    if (!_dictGradientColor) {
        _dictGradientColor = [NSMutableDictionary dictionary];
        self.backgroundColor = TIPS_COLOR;
    }
    if (!gradientColor) {
        gradientColor = [HVGradientColor gradientColorWithColors:@[TIPS_COLOR, TIPS_COLOR]];
    }
    _dictGradientColor[@(state)] = gradientColor;
    [self setNeedsDisplay];
}

- (HVGradientColor *)gradientColorForState:(UIControlState)state{
    HVGradientColor *gradientColor = nil;
    do {
        NSArray *keys = [_dictGradientColor.allKeys sortedArrayUsingSelector:@selector(compare:)];
        for (NSNumber *key in keys) {
            UIControlState keyState = [key integerValue];
            if (state==keyState) {
                gradientColor = _dictGradientColor[key];
                break;
            }
        }
        if (gradientColor) break;
        for (NSNumber *key in _dictBgColor.allKeys) {
            UIControlState keyState = [key integerValue];
            if (keyState&state) {
                gradientColor = _dictGradientColor[key];
                break;
            }
        }
        if (gradientColor) break;
    } while (NO);
    return gradientColor;
}

#pragma mark - super methods
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    HVGradientColor *gradientColor = [self gradientColorForState:self.state];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (gradientColor) {
        NSMutableArray *arrColor = [NSMutableArray array];
        NSInteger gradientCount = gradientColor.colors.count;
        for (NSInteger i=0; i<gradientCount; i++) {
            UIColor *color = gradientColor.colors[i];
            [arrColor addObject:(id)color.CGColor];
        }
        if (arrColor.count==1) {
            [arrColor addObject:(id)((UIColor *)gradientColor.colors[0]).CGColor];
        }
        CFArrayRef arrColorRef = (__bridge CFArrayRef)arrColor;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, arrColorRef, NULL);
        //从上到下
        //CGContextDrawLinearGradient(context, gradient, CGPointMake(self.width*0.5, 0), CGPointMake(self.width*0.5, self.height), kCGGradientDrawsAfterEndLocation);
        //从左向右
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, self.frame.size.height), CGPointMake(self.frame.size.width, self.frame.size.height), kCGGradientDrawsAfterEndLocation);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }
}


@end


