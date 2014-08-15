//
//  PianoKey.h
//  Son of a Pitch
//
//  Created by Philip Liao on 8/13/14.
//  Copyright (c) 2014 Philip Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kC  = -9,
    kCs = -8,
    kD  = -7,
    kDs = -6,
    kE  = -5,
    kF  = -4,
    kFs = -3,
    kG  = -2,
    kGs = -1,
    kA  =  0,
    kAs =  1,
    kB  =  2,
} Pitch;



@protocol PianoKeyDelegate

- (void)playPitch:(Pitch)pitch;
- (void)changePitch:(Pitch)pitch;
- (void)stopPitch;

- (void)showPitch:(Pitch)pitch;
- (void)hidePitch;

@end



@interface PianoKey : UIView

@property Pitch pitch;
@property CGRect originalFrame;
@property BOOL isPressed;
@property BOOL isBlack;

- (id)initWithFrame:(CGRect)frame andPitch:(Pitch)pitch;
- (void)pressAnimation;
- (void)releaseAnimation;


@end
