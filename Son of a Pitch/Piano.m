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
        
        //init the tone generator
        _tonePlayer = [[ToneGenerator alloc] init];
        
        //set current octave to 1 (all other octaves are relative to 1)
        _currentOctave = 1;
        
        //create the label
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        
        CGFloat keyHeight = (screenHeight-20)/9.0;
        CGFloat labelYPos = 18 + keyHeight*3.5;
        _noteName = [[UILabel alloc] initWithFrame:CGRectMake((screenRect.size.width-keyHeight)/2, labelYPos, keyHeight, keyHeight)];
        
        //no keys are initially pressed
        _blackKeyPressed = false;

        _whiteKeyColor = [UIColor colorWithRed:204.0/256.0 green:204.0/256.0 blue:204.0/256.0 alpha:0.3];
        _blackKeyColor = [UIColor colorWithRed:85.0/256.0 green:98.0/256.0 blue:112.0/256.0 alpha:1.0];

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
        
        
        
        [self setupWhiteKeys];
        [self setupBlackKeys];
    }
    return self;
}

- (void)setupWhiteKeys
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    //make the keys
    CGFloat whiteSpace = 2;
    CGFloat keyHeight = (screenHeight- 20)/9.0 - whiteSpace;
    
    int i = 1;
    CGRect keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _C = [[PianoKey alloc] initWithFrame:keyRect andPitch:kC];
    _C.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_C];
    
    i = 2;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _D = [[PianoKey alloc] initWithFrame:keyRect andPitch:kD];
    _D.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_D];
    
    i = 3;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _E = [[PianoKey alloc] initWithFrame:keyRect andPitch:kE];
    _E.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_E];
    
    i = 4;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _F = [[PianoKey alloc] initWithFrame:keyRect andPitch:kF];
    _F.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_F];
    
    i = 5;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _G = [[PianoKey alloc] initWithFrame:keyRect andPitch:kG];
    _G.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_G];
    
    i = 6;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _A = [[PianoKey alloc] initWithFrame:keyRect andPitch:kA];
    _A.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_A];
    
    i = 7;
    keyRect = CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight);
    _B = [[PianoKey alloc] initWithFrame:keyRect andPitch:kB];
    _B.backgroundColor = [_whiteKeyColor colorWithAlphaComponent:0.7];
    [self addSubview:_B];
}

- (void)setupBlackKeys
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    //make the keys
    CGFloat whiteSpace = 2;
    CGFloat keyHeight = (screenHeight- 20)/9.0 - whiteSpace;
    CGFloat smallKeyHeight = keyHeight - 10;
    CGFloat smallKeyWidth = 320 - 140;
    CGFloat smallKeyShift = (320 - smallKeyWidth)/2;
    
    int i = 1;
    CGRect keyRect = CGRectMake(smallKeyShift, i*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight);
    _Cs = [[PianoKey alloc] initWithFrame:keyRect andPitch:kCs];
    _Cs.backgroundColor = _blackKeyColor;
    _Cs.isBlack = true;
    [self addSubview:_Cs];
    
    i = 2;
    keyRect = CGRectMake(smallKeyShift, i*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight);
    _Ds = [[PianoKey alloc] initWithFrame:keyRect andPitch:kDs];
    _Ds.backgroundColor = _blackKeyColor;
    _Ds.isBlack = true;
    [self addSubview:_Ds];
    
    //skip 3
    
    i = 4;
    keyRect = CGRectMake(smallKeyShift, i*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight);
    _Fs = [[PianoKey alloc] initWithFrame:keyRect andPitch:kFs];
    _Fs.backgroundColor = _blackKeyColor;
    _Fs.isBlack = true;
    [self addSubview:_Fs];
    
    i = 5;
    keyRect = CGRectMake(smallKeyShift, i*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight);
    _Gs = [[PianoKey alloc] initWithFrame:keyRect andPitch:kGs];
    _Gs.backgroundColor = _blackKeyColor;
    _Gs.isBlack = true;
    [self addSubview:_Gs];
    
    i = 6;
    keyRect = CGRectMake(smallKeyShift, i*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight);
    _As = [[PianoKey alloc] initWithFrame:keyRect andPitch:kAs];
    _As.backgroundColor = _blackKeyColor;
    _As.isBlack = true;
    [self addSubview:_As];
}



+(NSString*)getStringOf:(Pitch)pitch
{
    NSString *noteString = [[NSString alloc] init];
    
    if (pitch == kC) noteString = @"C";
    else if (pitch == kCs) noteString = @"C#";
    else if (pitch == kD)  noteString = @"D";
    else if (pitch == kDs) noteString = @"D#";
    else if (pitch == kE)  noteString = @"E";
    else if (pitch == kF)  noteString = @"F";
    else if (pitch == kFs) noteString = @"F#";
    else if (pitch == kG)  noteString = @"G";
    else if (pitch == kGs) noteString = @"G#";
    else if (pitch == kA)  noteString = @"A";
    else if (pitch == kAs) noteString = @"A#";
    else if (pitch == kB)  noteString = @"B";

    return noteString;
    
}


-(UIColor*)getColorOf:(Pitch)pitch
{
    UIColor *noteColor = [[UIColor alloc] init];
    
    if (pitch == kC) noteColor = _C4Color;
    else if (pitch == kCs) noteColor = _Csharp4Color;
    else if (pitch == kD)  noteColor = _D4Color;
    else if (pitch == kDs) noteColor = _Dsharp4Color;
    else if (pitch == kE)  noteColor = _E4Color;
    else if (pitch == kF)  noteColor = _F4Color;
    else if (pitch == kFs) noteColor = _Fsharp4Color;
    else if (pitch == kG)  noteColor = _G4Color;
    else if (pitch == kGs) noteColor = _Gsharp4Color;
    else if (pitch == kA)  noteColor = _A4Color;
    else if (pitch == kAs) noteColor = _Asharp4Color;
    else if (pitch == kB)  noteColor = _B4Color;
    
    return noteColor;
    
}

-(BOOL)allBlackKeysUnpressed
{
    return (!_Cs.isPressed && !_Ds.isPressed && !_Fs.isPressed
            && !_Gs.isPressed && !_As.isPressed);
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

#pragma mark - Play/Stop, Show/Hide

- (void)playPitch: (Pitch) pitch
{

    if (!_tonePlayer.isPlaying)
    {
        double currentFrequency = 440.0* pow(2, pitch/12.0);
        _tonePlayer.frequency = currentFrequency*_currentOctave;
        [_tonePlayer play];   
    }
}

-(void) changePitch: (Pitch) pitch
{
    double currentFrequency = 440.0* pow(2, pitch/12.0);
    
    [_noteName setText:[Piano getStringOf:pitch]];
    [_noteName setBackgroundColor:[[self getColorOf:pitch] colorWithAlphaComponent:0.7] ];

    _tonePlayer.frequency = currentFrequency*_currentOctave;
    
}

- (void)stopPitch
{
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_sync(queue, ^{
        [_tonePlayer fadeVolumeDown];
    });
    
    dispatch_sync(queue, ^{
        [_tonePlayer stop];
    });
    
    
}

-(void) showPitch:(Pitch)pitch
{

    [_noteName setBackgroundColor:[[self getColorOf:pitch] colorWithAlphaComponent:0.7] ];
    [_noteName setTextColor:[UIColor whiteColor]];
    [_noteName setFont: [UIFont fontWithName:@"Futura-Medium" size:35.0f]];
    _noteName.textAlignment = NSTextAlignmentCenter;
    
    
    // string to display
    _noteName.text = [Piano getStringOf:pitch];
    
    [UIView transitionWithView:self duration:0.05
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self addSubview:_noteName]; }
                    completion:nil];
}

- (void)hidePitch
{
    [_noteName removeFromSuperview];
}


#pragma mark - Random Pitch Functions

- (void)randomPitch
{
    Pitch r = arc4random() % 12 - 9;
    _currentRandomNote = r;
    [self playPitch:_currentRandomNote];
    [self showRandom:_currentRandomNote];
}

-(void) showRandom:(Pitch)pitch
{
    
    [_noteName setBackgroundColor:[[self getColorOf:pitch] colorWithAlphaComponent:0.7] ];
    [_noteName setTextColor:[UIColor whiteColor]];
    [_noteName setFont: [UIFont fontWithName:@"Avenir-Black" size:35.0f]];
    _noteName.textAlignment = NSTextAlignmentCenter;
    
    
    // string to display
    _noteName.text = @"?";
    
    [UIView transitionWithView:self duration:0.05
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self addSubview:_noteName]; }
                    completion:nil];
}

- (void)stopRandom
{
    [self stopPitch];
    [self hidePitch];
}

- (void)randomPitchAgain
{
    [self playPitch:_currentRandomNote];
}


 
#pragma mark - Touch Events

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in allTouches)
    {
        CGPoint location = [touch locationInView:self];
        
        //Go through black keys first
        for ( PianoKey* key in [self subviews]) {
            if ([key isKindOfClass:[PianoKey class]])
            {
                if (CGRectContainsPoint(key.originalFrame, location))
                {
                    if (key.isBlack)
                    {
                        [key pressAnimation];
                        [self playPitch:key.pitch];
                        [self showPitch:key.pitch];
                    }
                    
                }
                
            }
            
        }
        //Then the rest
        for ( PianoKey* key in [self subviews]) {
            if ([key isKindOfClass:[PianoKey class]])
            {
                if (CGRectContainsPoint(key.originalFrame, location))
                {
                    if ([self allBlackKeysUnpressed])
                    {
                        [key pressAnimation];
                        [self playPitch:key.pitch];
                        [self showPitch:key.pitch];
                    }
                }
            }
        }

    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in allTouches)
    {
        CGPoint location = [touch locationInView:self];
        for ( PianoKey* key in [self subviews]) {
            if ([key isKindOfClass:[PianoKey class]]){
                if (key.isBlack)
                {
                    if (CGRectContainsPoint(key.originalFrame, location))
                    {
                        [key pressAnimation];
                        [self changePitch:key.pitch];
                    }
                    else
                    {
                        [key releaseAnimation];
                    }
                }
                
            }
        }
        
        for ( PianoKey* key in [self subviews]) {
            if ([key isKindOfClass:[PianoKey class]]){
                if (!key.isBlack)
                {
                    if (CGRectContainsPoint(key.originalFrame, location))
                    {
                        if ([self allBlackKeysUnpressed])
                        {
                            [key pressAnimation];
                            [self changePitch:key.pitch];
                        }
                        else
                        {
                            [key releaseAnimation];
                        }
                    }
                    else
                    {
                        [key releaseAnimation];
                    }
                }
            }
        }

    }
}



- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopPitch];
    [self hidePitch];
    _blackKeyPressed = false;
    for ( PianoKey* key in [self subviews]) {
        if ([key respondsToSelector:@selector(releaseAnimation)]) [key releaseAnimation];
    }
    
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
