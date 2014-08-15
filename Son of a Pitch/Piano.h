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
#import "PianoKey.h"
#import <math.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Piano : UIView

@property ToneGenerator *tonePlayer;
@property UILabel *noteName;
@property Pitch currentRandomNote;
@property UIButton *randomButtomMirror;
@property double currentOctave;


@property PianoKey* C;
@property PianoKey* Cs;
@property PianoKey* D;
@property PianoKey* Ds;
@property PianoKey* E;
@property PianoKey* F;
@property PianoKey* Fs;
@property PianoKey* G;
@property PianoKey* Gs;
@property PianoKey* A;
@property PianoKey* As;
@property PianoKey* B;



@property UIColor * blackKeyColor;
@property UIColor * whiteKeyColor;
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

@property BOOL blackKeyPressed;

- (void)playPitch: (Pitch) pitch;
- (void)changePitch: (Pitch) pitch;
- (void)stopPitch;
- (void)hidePitch;
- (void)randomPitch;

- (void) changeCurrentOctave: (int) offset;



@end
