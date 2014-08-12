//
//  Piano.h
//  Son of a Pitch
//
//  Created by Philip Liao on 12/15/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "ToneGenerator.h"
#import <math.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Piano : UIView

@property ToneGenerator *tonePlayer;
@property UILabel *noteName;
@property UIView *octaveUpGradient;
@property UIView *octaveDownGradient;
@property int currentRandomNote;
@property UIButton *randomButtomMirror;
@property double currentOctave;

@property UIColor * defaultColor;
@property UIColor * C4Color;
@property UIColor * Csharp4Color;
@property UIColor * D4Color;
@property UIColor * Dsharp4Color;
@property UIColor * E4Color;
@property UIColor * F4Color;
@property UIColor * Fsharp4Color;
@property UIColor * G4Color;
@property UIColor * Gsharp4Color;
@property UIColor * A4Color;
@property UIColor * Asharp4Color;
@property UIColor * B4Color;

typedef enum {
    C4=0,
    D4=1,
    E4=2,
    F4=3,
    G4=4,
    A4=5,
    B4=6,
    Csharp4=7,
    Dsharp4=8,
    Fsharp4=9,
    Gsharp4=10,
    Asharp4=11
} Notes;

@property Notes notes;

- (void)playPitch: (int) pitch;
- (void)changePitch: (int) pitch;
- (void)stopPitch;
- (void)playRandomPitch: (int) pitch;
- (void)playRandomPitchAgain;
- (void)hidePitch;
- (void)playAndShowPitch: (int) pitch;
- (void)randomPitch;

- (void) changeCurrentOctave: (int) offset;



@end
