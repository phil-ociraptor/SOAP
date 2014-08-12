//
//  OctaveSlider.m
//  Son of a Pitch
//
//  Created by Philip Liao on 12/19/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import "OctaveSlider.h"

@implementation OctaveSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)snapBack
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    float buttonHeight = (1.0/8.0)*(screenHeight-20);

    
    CGFloat originalX = (screenWidth - 2*buttonHeight)/2.0 + 2;
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = CGRectMake(originalX, buttonHeight*7+20, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    //self.frame = CGRectMake(originalX, buttonHeight*7+20, self.frame.size.width, self.frame.size.height);

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    float buttonHeight = (1.0/8.0)*(screenHeight-20);
    
    //if ([touches count] == 1) {
        CGFloat deltaX = [[touches anyObject] locationInView:self.superview].x - [[touches anyObject] previousLocationInView:self.superview].x;

        
        CGFloat newX = self.frame.origin.x + deltaX;
        
        CGFloat originalX = (screenWidth - 2*buttonHeight)/2.0 + 2;
        

        
        
        CGFloat minX = 0;
        CGFloat maxX = (screenWidth - buttonHeight/8.0);
        
        if (newX < minX) {
            newX = minX;
        }
        if (newX > maxX) {
            newX = maxX;
        }
        
        self.frame = CGRectMake(newX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    [self checkOctave];
    /*
    NSSet *allTouches = [event allTouches];
    //if ([allTouches count] == 1 ) {
    for (UITouch *touch in allTouches)
    {
        
        CGPoint location = [touch locationInView:self.superview];
        
        if( location.x > originalX) {
            [self octaveUp];
        } else if (location.x < originalX ){
            [self octaveDown];
        } else {
            [self octaveReset];
        }
    }
    //}
     */
}

- (void)checkOctave {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    float buttonHeight = (1.0/8.0)*(screenHeight-20);
    CGFloat originalX = (screenWidth - 2*buttonHeight)/2.0 + 2;

    if( self.frame.origin.x - originalX > buttonHeight-20) {
        [self octaveUp];
    } else if (self.frame.origin.x - originalX < -buttonHeight+20 ){
        [self octaveDown];
    } else {
        [self octaveReset];
    }
}

- (void)octaveDown {
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([self.delegate respondsToSelector:@selector(octaveSliderChangedOctave:)]) {
        [self.delegate octaveSliderChangedOctave: -1];
    }
}

- (void)octaveUp {
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([self.delegate respondsToSelector:@selector(octaveSliderChangedOctave:)]) {
        [self.delegate octaveSliderChangedOctave: 1];
    }
}

- (void)octaveReset {
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([self.delegate respondsToSelector:@selector(octaveSliderChangedOctave:)]) {
        [self.delegate octaveSliderChangedOctave: 0];
    }
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self snapBack];
    [self octaveReset];

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
