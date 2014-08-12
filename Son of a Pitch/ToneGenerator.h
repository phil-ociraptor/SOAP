//
//  ToneGenerator.h
//  Son of a Pitch
//
//  Created by Philip Liao on 12/4/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>

#define FREQUENCY_DEFAULT 440.0f

#define SAMPLE_RATE_DEFAULT 2500.0f//44100.0f

#define AMPLITUDE_LOW 0.01f
#define AMPLITUDE_MEDIUM 0.02f
#define AMPLITUDE_HIGH 0.03f
#define AMPLITUDE_FULL 0.25f
#define AMPLITUDE_DEFAULT AMPLITUDE_MEDIUM

@interface ToneGenerator : NSObject

@property AudioComponentInstance toneUnit;

@property double frequency;
@property double amplitude;
@property double sampleRate;
@property double theta;

@property BOOL isPlaying;

- (void)play;
- (void)stop;
- (void)fadeVolumeUp;
- (void)fadeVolumeDown;


@end
