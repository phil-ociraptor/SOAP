//
//  PianoViewController.h
//  Son of a Pitch
//
//  Created by Philip Liao on 11/27/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "ToneGenerator.h"
#import "Piano.h"
#import "OctaveSlider.h"
#import <math.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


@interface PianoViewController : UIViewController <OctaveSliderDelegate>

@property AVAudioPlayer *audioPlayer;
@property ToneGenerator *tonePlayer;
@property UIView *mainView;
@property Piano *piano;
@property UILabel *noteName;
@property UIButton *randomizeButton;
@property UIButton *randomPlayAgainButton;
@property OctaveSlider *octaveSlider;

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


@property Notes notes;


- (void)octaveSliderChangedOctave:(int) value;

@end
