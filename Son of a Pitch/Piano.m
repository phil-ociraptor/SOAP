//
//  Piano.m
//  Son of a Pitch
//
//  Created by Philip Liao on 12/15/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import "Piano.h"

@implementation Piano

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


- (void)setup
{
    //init the tone generator
    _tonePlayer = [[ToneGenerator alloc] init];
    
    //set current octave to 1 (all other octaves are relative to 1)
    _currentOctave = 1;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    //make the keys
    CGFloat whiteSpace = 2;
    CGFloat keyHeight = (screenHeight- 20)/8.0 - whiteSpace;
    CGFloat smallKeyHeight = keyHeight - 10;
    CGFloat smallKeyWidth = 320 - 140;
    CGFloat smallKeyShift = (320 - smallKeyWidth)/2;
    _defaultColor = [UIColor colorWithRed:160.0/256.0 green:160.0/256.0 blue:160.0/256.0 alpha:1.0];
    
    //[UIColor colorWithRed:90.0/256.0 green:61.0/256.0 blue:49.0/256.0 alpha:1.0];
    
    //a grey color
    //[UIColor colorWithRed:86.0/256.0 green:81.0/256.0 blue:89.0/256.0 alpha:1.0];
    // the weird blue color I was using
    //[UIColor colorWithRed:167.0/256.0 green:219.0/256.0 blue:216.0/256.0 alpha:1.0];
    
    //large keys
    for( int i = 0; i<7; i++)
    {
        UIView * pianoKey = [[UIView alloc] initWithFrame:CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight)];
        pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:0.7];
        pianoKey.tag = i;
        
        [self addSubview: pianoKey ];
        
    }
    
    //small keys
    for( int j = 0; j < 5; j++)
    {
        if( j < 2)
        {
            UIView * pianoKey = [[UIView alloc] initWithFrame:CGRectMake(smallKeyShift, j*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight)];
            pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:1];
            pianoKey.tag = j+7;
            [self addSubview: pianoKey ];
            
        }
        //make a gap
        else if (j >= 2)
        {
            UIView * pianoKey = [[UIView alloc] initWithFrame:CGRectMake(smallKeyShift, (j+1)*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight)];
            pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:1];
            pianoKey.tag = j+7;
            [self addSubview: pianoKey ];
        }
    }
    
    
    //set the colors
    _C4Color = [UIColor colorWithRed:160.0/256.0 green:39.0/256.0 blue:150.0/256.0 alpha:1];
    _Csharp4Color = [UIColor colorWithRed:163.0/256.0 green:0/256.0 blue:50.0/256.0 alpha:1];
    _D4Color = [UIColor colorWithRed:140.0/256.0 green:35.0/256.0 blue:24.0/256.0 alpha:1];
    _Dsharp4Color = [UIColor colorWithRed:243.0/256.0 green:134.0/256.0 blue:48.0/256.0 alpha:1];
    _E4Color = [UIColor colorWithRed:248.0/256.0 green:202.0/256.0 blue:0.0/256.0 alpha:1];
    _F4Color = [UIColor colorWithRed:81.0/256.0 green:149.0/256.0 blue:72.0/256.0 alpha:1];
    _Fsharp4Color = [UIColor colorWithRed:27.0/256.0 green:103.0/256.0 blue:107.0/256.0 alpha:1];
    _G4Color = [UIColor colorWithRed:10.0/256.0 green:89.0/256.0 blue:178.0/256.0 alpha:1];
    _Gsharp4Color = [UIColor colorWithRed:11.0/256.0 green:72.0/256.0 blue:107.0/256.0 alpha:1];
    _A4Color = [UIColor colorWithRed:73.0/256.0 green:10.0/256.0 blue:61.0/256.0 alpha:1];
    _Asharp4Color = [UIColor colorWithRed:93.0/256.0 green:22.0/256.0 blue:168.0/256.0 alpha:1];
    _B4Color = [UIColor colorWithRed:144.0/256.0 green:97.0/256.0 blue:194.0/256.0 alpha:1];
    
}

- (void)randomPitch
{
    int r = arc4random() % 12;
    _currentRandomNote = r;
    [self playRandomPitch:_currentRandomNote];
}

- (void)playAndShowPitch: (int) pitch
{
    [self playPitch:pitch];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat labelYPos = 20 + ((screenHeight-20)/8.0)*2.5; //FIXME magic numbers
    
    _noteName = [[UILabel alloc] initWithFrame:CGRectMake(0, labelYPos, 320, 57)];
    [_noteName setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5] ];
    [_noteName setTextColor:[UIColor whiteColor]];
    [_noteName setFont: [UIFont fontWithName:@"Futura-Medium" size:40.0f]];
    _noteName.textAlignment = NSTextAlignmentCenter;
    
    
    // string to display
    NSString *noteString = [[NSString alloc] init];
    
    // Use Helper Function to get data for a given pitch
    NSMutableDictionary *data = [self pitchData:pitch];
    noteString = [data objectForKey:@"string"];
    
    [_noteName setText:noteString];
    
    [UIView transitionWithView:self duration:0.05
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self addSubview:_noteName]; }
                    completion:nil];
}

- (void)hidePitch
{
    [_noteName removeFromSuperview];
}

- (void)playPitch: (int) pitch
{
    
    //will be adjusted
    UIColor *currentColor = [[UIColor alloc] init];
    double currentFrequency = 0;
    
    // Use Helper Function to get data for a given pitch
    NSMutableDictionary *data = [self pitchData:pitch];
    
    currentFrequency = [[data objectForKey:@"frequency"] doubleValue];
    currentColor = [data objectForKey:@"color"];
    
    
    _tonePlayer.frequency = currentFrequency*_currentOctave;
    
    
    for (int i = 0; i<12; i++)
    {
        if ( i < 7 )
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            key.backgroundColor = [currentColor colorWithAlphaComponent:0.6];
        }
        else
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            key.backgroundColor = currentColor;
            
        }
    }
    
    [_tonePlayer play];
    
}

- (void)playRandomPitchAgain
{
    
    Notes currentNote = _currentRandomNote;
    
    //will be adjusted
    UIColor *currentColor = [[UIColor alloc] init];
    double currentFrequency = 0;
    
    // Use Helper Function to get data for a given pitch
    NSMutableDictionary *data = [self pitchData:currentNote];
    
    currentFrequency = [[data objectForKey:@"frequency"] doubleValue];
    currentColor = [data objectForKey:@"color"];
    
    
    _tonePlayer.frequency = currentFrequency*_currentOctave;
    
    
    for (int i = 0; i<12; i++)
    {
        if ( i < 7 )
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            key.backgroundColor = [currentColor colorWithAlphaComponent:0.6];
        }
        else
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            key.backgroundColor = currentColor;
            
        }
    }
    
    [_tonePlayer play];
    
}


/* playRandomPitch:
 *
 *    Exactly like playPitch:, except it handles the animation itself.
 * This helper method is only called in randomPitch:
 *
 */
- (void)playRandomPitch: (int) pitch
{
    //will be adjusted
    UIColor *currentColor = [[UIColor alloc] init];
    double currentFrequency = 0;
    
    // Use Helper Function to get data for a given pitch
    NSMutableDictionary *data = [self pitchData:pitch];
    
    currentFrequency = [[data objectForKey:@"frequency"] doubleValue];
    currentColor = [data objectForKey:@"color"];
    
    
    _tonePlayer.frequency = currentFrequency*_currentOctave;
    
    
    for (int i = 0; i<12; i++)
    {
        if ( i < 7 )
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.05 animations:^{
                key.backgroundColor = [currentColor colorWithAlphaComponent:0.6];
            }];
        } else
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.05 animations:^{
                key.backgroundColor = currentColor;
            }];
            
        }
    }
    
    [_tonePlayer play];
    
}

-(void)fadeColor
{
    for (int i =0; i<12; i++)
    {
        if ( i < 7 )
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.05 animations:^{
                key.backgroundColor = [_defaultColor colorWithAlphaComponent:0.7];
            }];
        }
        else
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.05 animations:^{
                key.backgroundColor = [_defaultColor colorWithAlphaComponent:1];
            }];
        }
    }
    
    if ( _noteName != Nil)
    {
        [_noteName removeFromSuperview];
    }

}

- (void)stopPitch
{
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_sync(queue, ^{
        [self fadeColor];
    });
    
    dispatch_sync(queue, ^{
        [_tonePlayer fadeVolumeDown];
    });
    
    dispatch_sync(queue, ^{
        [_tonePlayer stop];
    });
    
    
}


-(void) changePitch: (int) pitch
{
    //will be adjusted
    UIColor *currentColor = [[UIColor alloc] init];
    double currentFrequency = 0;
    NSString *noteString = [[NSString alloc] init];

    // Use Helper Function to get data for a given pitch
    NSMutableDictionary *data = [self pitchData:pitch];
    
    currentFrequency = [[data objectForKey:@"frequency"] doubleValue];
    currentColor = [data objectForKey:@"color"];
    noteString = [data objectForKey:@"string"];
    
    
    [_noteName setText:noteString];
    _tonePlayer.frequency = currentFrequency*_currentOctave;
    
    for (int i = 0; i<12; i++)
    {
        if ( i < 7 )
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.1 animations:^{
                key.backgroundColor = [currentColor colorWithAlphaComponent:0.6];
            }];
        }
        else
        {
            UIButton * key = ((UIButton*)[[self subviews] objectAtIndex:i]);
            [UIButton animateWithDuration:0.1 animations:^{
                key.backgroundColor = currentColor;
            }];
            
        }
    }

}


- (NSMutableDictionary*) pitchData: (int) pitch
{
    // Need frequency, color, string
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    
    int currentNote = pitch;
    UIColor *currentColor = [[UIColor alloc] init];
    //this measures the half steps away from A4
    int halfStepsAway = 0;
    double A4Frequency = 440;
    //will be adjusted
    double currentFrequency = 0;
    NSString *noteString = [[NSString alloc] init];
    
    if( currentNote == 0) {
        // currentNote is a C
        halfStepsAway = - 9;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _C4Color;
        noteString = @"C";
        
    } else if (currentNote == 1) {
        // currentNote is a D
        halfStepsAway =  - 7;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _D4Color;
        noteString = @"D";
        
    } else if (currentNote == 2) {
        // currentNote is a E
        halfStepsAway =  - 5;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _E4Color;
        noteString = @"E";
        
    } else if (currentNote == 3) {
        // currentNote is a F
        halfStepsAway =  - 4;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _F4Color;
        noteString = @"F";
        
    } else if (currentNote == 4) {
        // currentNote is a G
        halfStepsAway = - 2;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _G4Color;
        noteString = @"G";
        
    } else if (currentNote == 5) {
        // currentNote is a A
        halfStepsAway = 0;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _A4Color;
        noteString = @"A";
        
    } else if (currentNote == 6) {
        // currentNote is a B
        halfStepsAway = 2;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _B4Color;
        noteString = @"B";
        
    } else if (currentNote == 7) {
        // currentNote is a C#
        halfStepsAway =  - 8;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _Csharp4Color;
        noteString = @"C#";
        
    } else if (currentNote == 8) {
        // currentNote is a D#
        halfStepsAway =  - 6;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _Dsharp4Color;
        noteString = @"D#";
        
    } else if (currentNote == 9) {
        // currentNote is a F#
        halfStepsAway =  - 3;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _Fsharp4Color;
        noteString = @"F#";
        
    } else if (currentNote == 10) {
        // currentNote is a G#
        halfStepsAway =  - 1;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _Gsharp4Color;
        noteString = @"G#";
        
    } else if (currentNote == 11) {
        // currentNote is a A#
        halfStepsAway =  1;
        currentFrequency = A4Frequency* pow(2, halfStepsAway/12.0);
        currentColor = _Asharp4Color;
        noteString = @"A#";
    }
    
    [data setObject:[NSNumber numberWithDouble:currentFrequency] forKey:@"frequency"];
    [data setObject:currentColor forKey:@"color"];
    [data setObject:noteString forKey:@"string"];

    return data;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    //if ([allTouches count] == 1)
    //{
        for (UITouch *touch in allTouches)
        {
            CGPoint location = [touch locationInView:self];
            
            int i = 11;
            while (!_tonePlayer.isPlaying && i >= 0)
            {
                UIView *key = [[self subviews] objectAtIndex:i];
                if (CGRectContainsPoint(key.frame, location))
                {
                    [self playAndShowPitch:i];
                }
                i--;

            }

        }

    //}
}

- (void) changeCurrentOctave: (int) offset
{
    if(offset == -1 && _currentOctave==1.0){
        // push
        _currentOctave = 0.5;
        _tonePlayer.frequency = _tonePlayer.frequency*_currentOctave;
    } else if (offset == -1 && _currentOctave==0.5) {
        // do nothing
    } else if (offset == 0 && _currentOctave == 0.5) {
        // pop
        _tonePlayer.frequency = _tonePlayer.frequency*2.0;
        _currentOctave = 1.0;
    }else if (offset == 0 && _currentOctave == 1.0) {
        //do nothing
    }else if (offset == 0 && _currentOctave == 2.0) {
        // pop
        _tonePlayer.frequency = _tonePlayer.frequency*0.5;
        _currentOctave = 1.0;
    }else if (offset == 1 && _currentOctave == 1.0) {
        // push
        _currentOctave = 2.0;
        _tonePlayer.frequency = _tonePlayer.frequency*_currentOctave;
    }else if (offset == 1 && _currentOctave == 2.0) {
        // do nothing
    }else{
        //do nothing
    }
    
    //_tonePlayer.frequency = _tonePlayer.frequency*_currentOctave;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    //if ([allTouches count] == 1 ) {
        for (UITouch *touch in allTouches)
        {
            CGPoint location = [touch locationInView:self];
            for (int i=7; i<12; i++) {
                UIView *key = [[self subviews] objectAtIndex:i];
                if (CGRectContainsPoint(key.frame, location)) {
                        [self changePitch: i];
                        return;
                    }
                }
            for (int i=0; i<7; i++) {
                UIView *key = [[self subviews] objectAtIndex:i];
                if (CGRectContainsPoint(key.frame, location)) {
                    [self changePitch: i];
                }
            }
            
        }
        
    //}
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopPitch];
    /*
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in allTouches)
    {
        CGPoint location = [touch locationInView:touch.view];
        
        for (int i=0; i<12; i++) {
            UIButton *key = [[self subviews] objectAtIndex:i];
            if (CGRectContainsPoint(key.frame, location)) {
                [self stopPitch];
            }
        }
    }
     */
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
