//
//  PianoViewController.m
//  Son of a Pitch
//
//  Created by Philip Liao on 11/27/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import "PianoViewController.h"

@interface PianoViewController ()

@end

@implementation PianoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
        // Custom initialization
    }
    return self;
}

- (void)setup
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _piano = [[Piano alloc] initWithFrame:screenRect];
    self.view = _mainView;
    [_mainView addSubview:_piano];
    
    /*
    
    //make the keys
    CGFloat whiteSpace = 2;
    CGFloat keyHeight = 69 - whiteSpace;
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
        UIButton * pianoKey = [[UIButton alloc] initWithFrame:CGRectMake(0, i*(keyHeight + whiteSpace)+20, 320, keyHeight)];
        pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:0.7];
        pianoKey.tag = i;
        [pianoKey addTarget:self action:@selector(playAndShowPitch:) forControlEvents:UIControlEventTouchDown];
        [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchUpInside];
        [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchUpInside];
        [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchDragOutside];
        [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchDragOutside];


        [_piano addSubview: pianoKey ];
        
    }
    
    //small keys
    for( int j = 0; j < 5; j++)
    {
        if( j < 2)
        {
            UIButton * pianoKey = [[UIButton alloc] initWithFrame:CGRectMake(smallKeyShift, j*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight)];
            pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:1];
            pianoKey.tag = j+7;
            [pianoKey addTarget:self action:@selector(playAndShowPitch:) forControlEvents:UIControlEventTouchDown];
            [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchUpInside];
            [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchUpInside];
            [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchDragOutside];
            [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchDragOutside];
            
            [_piano addSubview: pianoKey ];
            
        }
        //make a gap
        else if (j >= 2)
        {
            UIButton * pianoKey = [[UIButton alloc] initWithFrame:CGRectMake(smallKeyShift, (j+1)*(keyHeight + whiteSpace) + keyHeight/2 + 20 + 5, smallKeyWidth, smallKeyHeight)];
            pianoKey.backgroundColor = [_defaultColor colorWithAlphaComponent:1];
            pianoKey.tag = j+7;
            [pianoKey addTarget:self action:@selector(playAndShowPitch:) forControlEvents:UIControlEventTouchDown];
            [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchUpInside];
            [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchUpInside];
            [pianoKey addTarget:self action:@selector(stopPitch) forControlEvents:UIControlEventTouchDragOutside];
            [pianoKey addTarget:self action:@selector(hidePitch) forControlEvents:UIControlEventTouchDragOutside];

            
            [_piano addSubview: pianoKey ];
        }
    }
    
    */
    
    
    //save this color [UIColor colorWithRed:244.0/256.0 green:234.0/256.0 blue:205.0/256.0 alpha:0.6]
    //create the randomize button
    float buttonHeight = (1.0/8.0)*(screenHeight-20);
    _randomizeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (7.0/8.0)*(screenHeight-20)+20, (screenWidth- 2*buttonHeight)/2, (screenHeight-20)/8.0-2)];
    //UIImage *btnImage = [UIImage imageNamed:@"shuffle-icon.png"];
    //[_randomizeButton setImage:btnImage forState:UIControlStateNormal];
    //_randomizeButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[_randomizeButton setTitle:@"Random" forState:UIControlStateNormal];
    //_randomizeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //_randomizeButton.titleLabel.textColor = [UIColor blackColor];
    _randomizeButton.backgroundColor = [UIColor colorWithRed:244.0/256.0 green:234.0/256.0 blue:205.0/256.0 alpha:1];
    [_randomizeButton addTarget:_piano action:@selector(randomPitch) forControlEvents:UIControlEventTouchDown];
    [_randomizeButton addTarget:_piano action:@selector(stopPitch) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_randomizeButton];
    
    _randomPlayAgainButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth- 2*buttonHeight)/2+2*buttonHeight, (7.0/8.0)*(screenHeight-20)+20, (screenWidth- 2*buttonHeight)/2, (screenHeight-20)/8.0-2)];
    //UIImage *btn2Image = [UIImage imageNamed:@"replay-icon.png"];
    //[_randomPlayAgainButton setImage:btn2Image forState:UIControlStateNormal];
    //_randomPlayAgainButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //[_randomPlayAgainButton setTitle:@"Again" forState:UIControlStateNormal];
    //_randomPlayAgainButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //_randomPlayAgainButton.titleLabel.textColor = [UIColor blackColor];
    _randomPlayAgainButton.backgroundColor = [UIColor colorWithRed:244.0/256.0 green:234.0/256.0 blue:205.0/256.0 alpha:1];
    [_randomPlayAgainButton addTarget:_piano action:@selector(playRandomPitchAgain) forControlEvents:UIControlEventTouchDown];
    [_randomPlayAgainButton addTarget:_piano action:@selector(stopPitch) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_randomPlayAgainButton];
    
    
    _octaveSlider = [[OctaveSlider alloc] initWithFrame:CGRectMake((screenWidth- 2*buttonHeight)/2 +2 , (7.0/8.0)*(screenHeight-20)+20, 2*buttonHeight-4, buttonHeight-2)];
    _octaveSlider.backgroundColor = [UIColor colorWithRed:244.0/256.0 green:234.0/256.0 blue:205.0/256.0 alpha:0.6];
    _octaveSlider.delegate = self;
    [_mainView addSubview:_octaveSlider];

    
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

- (void)octaveSliderChangedOctave:(int) value
{
    [_piano changeCurrentOctave: value];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
