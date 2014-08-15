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
    
    _piano = [[Piano alloc] initWithFrame:screenRect];
    self.view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.view.backgroundColor = [UIColor colorWithRed:85.0/256.0 green:98.0/256.0 blue:112.0/256.0 alpha:1.0];
    [self.view addSubview:_piano];
    

    
    
    //save this color [UIColor colorWithRed:244.0/256.0 green:234.0/256.0 blue:205.0/256.0 alpha:0.6]
    //create the randomize button
    float buttonHeight = (1.0/9.0)*(screenHeight-20);
    //_SOAPButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonHeight +2 , 20, screenWidth - 2*buttonHeight-4, buttonHeight-2)];
    _SOAPButton = [[UIButton alloc] initWithFrame:CGRectMake(0 , 20, screenWidth, buttonHeight-2)];
    _SOAPButton.backgroundColor = [UIColor colorWithRed:10.0/256.0 green:89.0/256.0 blue:178.0/256.0 alpha:0.7];
    [_SOAPButton addTarget:_piano action:@selector(randomPitch) forControlEvents:UIControlEventTouchDown];
    [_SOAPButton addTarget:_piano action:@selector(stopRandom) forControlEvents:UIControlEventTouchUpInside];
    [_SOAPButton setTitle:@"Soap!" forState:UIControlStateNormal];
    _SOAPButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _SOAPButton.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:25.0f];
    [self.view addSubview:_SOAPButton];
    
    
    _octaveSlider = [[OctaveSlider alloc] initWithFrame:CGRectMake((screenWidth- 2*buttonHeight)/2 +2 , (8.0/9.0)*(screenHeight-20)+20, 2*buttonHeight-4, buttonHeight-2)];
    _octaveSlider.backgroundColor = [UIColor colorWithRed:10.0/256.0 green:89.0/256.0 blue:178.0/256.0 alpha:0.7];
    _octaveSlider.delegate = self;
    [self.view addSubview:_octaveSlider];
    
    CGRect labelFrame = CGRectMake(0, (8.0/9.0)*(screenHeight-20)+20+10, (screenWidth - 2*buttonHeight)/2-2, buttonHeight-2);
    UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = @"down";
    [label setFont:[UIFont fontWithName:@"Futura-Medium" size:15.0f]];
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor: [UIColor whiteColor]];
    [self.view addSubview:label];
    
    CGRect labelUpFrame = CGRectMake((screenWidth - 2*buttonHeight)/2 + 2*buttonHeight, (8.0/9.0)*(screenHeight-20)+20, (screenWidth - 2*buttonHeight)/2-2, buttonHeight-2-20);
    UILabel* labelUp = [[UILabel alloc] initWithFrame:labelUpFrame];
    labelUp.text = @"up";
    [labelUp setFont:[UIFont fontWithName:@"Futura-Medium" size:15.0f]];
    labelUp.textAlignment = NSTextAlignmentCenter;
    [labelUp setTextColor: [UIColor whiteColor]];
    [self.view addSubview:labelUp];

    
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
