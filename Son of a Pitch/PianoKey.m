//
//  PianoKey.m
//  Son of a Pitch
//
//  Created by Philip Liao on 8/13/14.
//  Copyright (c) 2014 Philip Liao. All rights reserved.
//

#import "PianoKey.h"

@implementation PianoKey


//Likely do not need to know the color here
- (id)initWithFrame:(CGRect)frame andPitch:(Pitch)pitch
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _originalFrame = self.frame;
        _pitch = pitch;
        _isPressed = false;
        _isBlack = false;
        
    }
    return self;
}

- (void)pressAnimation
{
    if (!_isPressed)
    {
        [self resizeTo:0.95 withDuration:0.05];
        _isPressed = true;
    }
}

- (void)releaseAnimation
{
    if (_isPressed)
    {
        [self resizeTo:1.0/0.95 withDuration:0.1];
        _isPressed = false;
    }
}

-(void)resizeTo:(float)targetRatio withDuration:(float)duration {
    CGAffineTransform originalTransform = self.transform;
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformScale(originalTransform, targetRatio, targetRatio);
    }];
}

 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
