//
//  RSSliderView.m
//  RSSliderView
//
//  Created by Roman Simenok on 13.02.15.
//  Copyright (c) 2015 Roman Simenok. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "RSSliderViewTwo.h"

@implementation RSSliderViewTwo{
    CGFloat sliderHeight;
}

-(id)initWithFrame:(CGRect)frame andOrientation:(OrientationOne)orientation {
    if (self = [super initWithFrame:frame]) {
        [self setOrientation:orientation];
        [self initSlider];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        if (self.frame.size.width>self.frame.size.height) {
            [self setOrientation:HorizontalOne];
        }else{
            [self setOrientation:VerticalOne];
        }
        
        [self initSlider];
    }
    return self;
}


-(void)initSlider {
    isHandleHidden = NO;
    self.foregroundView = [[UIView alloc] init];
    self.handleView = [[UIView alloc] init];
    self.handleView.layer.cornerRadius = viewCornerRadius;
    self.handleView.layer.masksToBounds = YES;
    sliderHeight = self.frame.size.height - 10;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, self.frame.size.height-4, self.frame.size.height-4)];
    self.imageView.image = [UIImage imageNamed:@"Destination.png"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    switch (self.orientation) {
        case VerticalOne:
            self.label = [[UILabel alloc] init];
            [self.label setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            self.label.frame = self.bounds;
            
            break;
        case HorizontalOne:
            self.label = [[UILabel alloc] initWithFrame:self.bounds];
             self.labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(90, 05, 255, 21)];
            break;
        default:
            break;
    }
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"Helvetica" size:24];
    self.labelTwo.font= [UIFont fontWithName:@"Helvetica" size:24];
    self.labelTwo.textColor= [UIColor whiteColor];
    [self addSubview:self.label];
    [self addSubview:self.labelTwo];
    [self addSubview:self.foregroundView];
    [self addSubview:self.imageView];
    [self addSubview:self.handleView];
    
    self.layer.cornerRadius = viewCornerRadius;
    self.layer.masksToBounds = YES;
    [self.layer setBorderWidth:borderWidth];    // set defauld value for slider. Value should be between 0 and 1
    [self setValue:0.0 withAnimation:NO completion:nil];
}

#pragma mark - Set Value

-(void)setValue:(float)value {
    [self setValue:value withAnimation:NO completion:nil];
}

-(void)setValue:(float)value withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion {
    NSAssert((value >= 0.0)&&(value <= 1.0), @"Value must be between 0 and 1");
    
    if (value < 0) {
        value = 0;
    }
    
    if (value > 1) {
        value = 1;
    }
    
    CGPoint point;
    switch (self.orientation) {
        case VerticalOne:
            point = CGPointMake(0, (1-value) * self.frame.size.height);
            break;
        case HorizontalOne:
            point = CGPointMake(value * self.frame.size.width, 0);
            break;
        default:
            break;
    }
    
    if(isAnimate) {
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:animationSpeed animations:^ {
            [weakSelf changeStarForegroundViewWithPoint:point];
            
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}

#pragma mark - Other methods

-(void)setOrientation:(OrientationOne)orientation {
    _orientation = orientation;
}

-(void)setColorsForBackground:(UIColor *)bCol foreground:(UIColor *)fCol handle:(UIColor *)hCol border:(UIColor *)brdrCol {
    self.backgroundColor = bCol;
    self.foregroundView.backgroundColor = [UIColor clearColor];
    self.handleView.backgroundColor = [UIColor clearColor];
    [self.layer setBorderColor:brdrCol.CGColor];
}

-(void)removeRoundCorners:(BOOL)corners removeBorder:(BOOL)borders {
    if (corners) {
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = YES;
    }
    if (borders) {
        [self.layer setBorderWidth:0.0];
    }
}

-(void)hideHandle {
    self.handleView.hidden = YES;
    isHandleHidden = YES;
    [self.handleView removeFromSuperview];
}

#pragma mark - Touch Events

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
  
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    switch (self.orientation) {
        case VerticalOne:
            if (!(point.y < 0) && !(point.y > self.frame.size.height)) {
                [self changeStarForegroundViewWithPoint:point];
            }
            break;
        case HorizontalOne:
            if (!(point.x < 0) && !(point.x > self.frame.size.width)) {
                [self changeStarForegroundViewWithPoint:point];
            }
            break;
        default:
            break;
    }
    
    if ((point.x >= 0) && point.x <= self.frame.size.width-handleWidth) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChangedTwo:)]) {
            [self.delegate sliderValueChangedTwo:self];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:animationSpeed animations:^ {
        [weakSelf changeStarForegroundViewWithPoint:point];
    } completion:^(BOOL finished) {
        

        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChangeEndedTwo:)]) {
            [self.delegate sliderValueChangeEndedTwo:self];
        }
    }];
}

#pragma mark - Change Slider Foreground With Point

- (void)changeStarForegroundViewWithPoint:(CGPoint)point {
    CGPoint p = point;
    
    switch (self.orientation) {
        case VerticalOne: {
            if (p.y < 0) {
                p.y = 0;
            }
            
            if (p.y > self.frame.size.height) {
                p.y = self.frame.size.height;
            }
            
            self.value = 1-(p.y / self.frame.size.height);
            self.foregroundView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, p.y-self.frame.size.height);
            
            if (!isHandleHidden) {
                if (self.foregroundView.frame.origin.y <= 0) {
                    self.handleView.frame = CGRectMake(borderWidth, 0, self.frame.size.width-borderWidth*2, handleWidth);
                }else if (self.foregroundView.frame.origin.y >= self.frame.size.height) {
                    self.handleView.frame = CGRectMake(borderWidth, self.frame.size.height-handleWidth, self.frame.size.width-borderWidth*2, handleWidth);
                }else{
                    self.handleView.frame = CGRectMake(borderWidth, self.foregroundView.frame.origin.y-handleWidth/2, self.frame.size.width-borderWidth*2, handleWidth);
                }
            }
        }
            break;
        case HorizontalOne: {
            if (p.x < 0) {
                p.x = 0;
            }
            
            if (p.x > self.frame.size.width) {
                p.x = self.frame.size.width;
            }
            
            self.value = p.x / self.frame.size.width;
            self.foregroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
            
            if (!isHandleHidden) {
                if (self.foregroundView.frame.size.width <= 0) {
                    self.handleView.frame = CGRectMake(self.frame.size.height, borderWidth, handleWidth, self.foregroundView.frame.size.height-borderWidth);
                    self.imageView.frame = CGRectMake(0, borderWidth, self.frame.size.height-4, self.frame.size.height-4);
                    [self.delegate sliderValueChangedTwo:self]; // or use sliderValueChangeEnded method
                }else if (self.foregroundView.frame.size.width >= self.frame.size.width) {
                    self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width-handleWidth, borderWidth, handleWidth, self.foregroundView.frame.size.height-borderWidth*2);
                    self.imageView.frame = CGRectMake(self.handleView.frame.origin.x - self.frame.size.height, borderWidth, self.frame.size.height-4, self.frame.size.height-4);
                    [self.delegate sliderValueChangedTwo:self]; // or use sliderValueChangeEnded method
                }else{
                    self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width-handleWidth/2, borderWidth, handleWidth, self.foregroundView.frame.size.height-borderWidth*2);
                    self.imageView.frame = CGRectMake(self.handleView.frame.origin.x - self.frame.size.height, borderWidth, self.frame.size.height-4, self.frame.size.height-4);
                }
            }
        }
            break;
        default:
            break;
    }
}

@end
