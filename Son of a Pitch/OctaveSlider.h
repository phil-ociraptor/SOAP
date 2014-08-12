//
//  OctaveSlider.h
//  Son of a Pitch
//
//  Created by Philip Liao on 12/19/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OctaveSliderDelegate;


@interface OctaveSlider : UIView

@property (nonatomic, weak) id<OctaveSliderDelegate> delegate;

@property UIViewController* parentController;


- (void) octaveUp;
- (void) octaveDown;

@end


@protocol OctaveSliderDelegate <NSObject>

- (void)octaveSliderChangedOctave:(int) value;

@end