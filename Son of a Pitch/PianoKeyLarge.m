//
//  PianoKeyLarge.m
//  Son of a Pitch
//
//  Created by Philip Liao on 11/27/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

#import "PianoKeyLarge.h"

@implementation PianoKeyLarge

- (id)initWithFrame:(CGRect)frame andColor: (UIColor *) color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = color;
    }
    return self;
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
