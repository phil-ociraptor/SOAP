//
//  ToneGenerator.m
//  Son of a Pitch
//
//  Created by Philip Liao on 12/4/13.
//  Copyright (c) 2013 Philip Liao. All rights reserved.
//

//  Adapted from Matt Gallagher's tutorial on Tone Generation in iOS
//

#import "ToneGenerator.h"
#import <AudioToolbox/AudioToolbox.h>




@implementation ToneGenerator

OSStatus RenderTone(
                    void *inRefCon,
                    AudioUnitRenderActionFlags   *ioActionFlags,
                    const AudioTimeStamp                 *inTimeStamp,
                    UInt32                                                 inBusNumber,
                    UInt32                                                 inNumberFrames,
                    AudioBufferList                         *ioData)

{
    // Get the tone parameters out of the object
    ToneGenerator *toneGenerator =
    (__bridge ToneGenerator *)inRefCon;
    double theta = toneGenerator.theta;
    double amplitude = toneGenerator.amplitude;
    double theta_increment = 2.0 * M_PI * toneGenerator.frequency / toneGenerator.sampleRate;
    
    // This is a mono tone generator so we only need the first buffer
    const int channel = 0;
    Float32 *buffer = (Float32 *)ioData->mBuffers[channel].mData;
    
    // Generate the samples
    for (UInt32 frame = 0; frame < inNumberFrames; frame++)
    {
        buffer[frame] = sin(theta) * amplitude;
        
        theta += theta_increment;
        if (theta > 2.0 * M_PI)
        {
            theta -= 2.0 * M_PI;
        }
    }
    
    // Store the theta back in the view controller
    toneGenerator.theta = theta;
    
    return noErr;
}

void ToneInterruptionListener(void *inClientData, UInt32 inInterruptionState)
{
    ToneGenerator *toneGenerator =
    (__bridge ToneGenerator *)inClientData;
    
    [toneGenerator stop];
}


- (id)init
{
    return [self initWithFrequency:FREQUENCY_DEFAULT amplitude:0];
}

- (id)initWithFrequency:(double)hertz amplitude:(double)volume
{
    if (self = [super init]) {
        _frequency = hertz;
        _amplitude = volume;
        _sampleRate = SAMPLE_RATE_DEFAULT;
        _isPlaying = FALSE;
        
        OSStatus result = AudioSessionInitialize(NULL, NULL, ToneInterruptionListener, (__bridge void *)(self));
        if (result == kAudioSessionNoError)
        {
            UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
            AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        }
        AudioSessionSetActive(true);
    }
    
    return self;
}

- (void)playForDuration:(float)time
{
    [self play];
    [self performSelector:@selector(stop) withObject:nil afterDelay:time];
}


- (void)play
{
    _isPlaying = TRUE;
    
    if (!_toneUnit)
    {
        [self createToneUnit];
        
        // Stop changing parameters on the unit
        OSErr err = AudioUnitInitialize(_toneUnit);
        NSAssert1(err == noErr, @"Error initializing unit: %hd", err);
        
        // Start playback
        err = AudioOutputUnitStart(_toneUnit);
        NSAssert1(err == noErr, @"Error starting unit: %hd", err);
        
    }
    
    [self fadeVolumeUp];
}

- (void)fadeVolumeUp
{
    _amplitude = _amplitude + 0.005;
    if (_amplitude < AMPLITUDE_HIGH*4) {
        [self performSelector:@selector(fadeVolumeUp) withObject:nil afterDelay:1.0/SAMPLE_RATE_DEFAULT];
    } else {
        return;
    }
}

- (void)stop
{
    _isPlaying = FALSE;
    [self fadeVolumeDown];
        
    if (_toneUnit)
    {
        AudioOutputUnitStop(_toneUnit);
        AudioUnitUninitialize(_toneUnit);
        AudioComponentInstanceDispose(_toneUnit);
        _toneUnit = nil;
    }
}

- (void)fadeVolumeDown
{
    _amplitude = _amplitude - 0.005;
    if (_amplitude > 0) {
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:1.0/SAMPLE_RATE_DEFAULT];
    } else {
        return;
    }
    
}

- (void)createToneUnit
{
    // Configure the search parameters to find the default playback output unit
    // (called the kAudioUnitSubType_RemoteIO on iOS but
    // kAudioUnitSubType_DefaultOutput on Mac OS X)
    AudioComponentDescription defaultOutputDescription;
    defaultOutputDescription.componentType = kAudioUnitType_Output;
    defaultOutputDescription.componentSubType = kAudioUnitSubType_RemoteIO;
    defaultOutputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
    defaultOutputDescription.componentFlags = 0;
    defaultOutputDescription.componentFlagsMask = 0;
    
    // Get the default playback output unit
    AudioComponent defaultOutput = AudioComponentFindNext(NULL, &defaultOutputDescription);
    NSAssert(defaultOutput, @"Can't find default output");
    
    // Create a new unit based on this that we'll use for output
    OSErr err = AudioComponentInstanceNew(defaultOutput, &_toneUnit);
    NSAssert1(_toneUnit, @"Error creating unit: %hd", err);
    
    // Set our tone rendering function on the unit
    AURenderCallbackStruct input;
    input.inputProc = RenderTone;
    input.inputProcRefCon = (__bridge void *)(self);
    err = AudioUnitSetProperty(_toneUnit,
                               kAudioUnitProperty_SetRenderCallback,
                               kAudioUnitScope_Input,
                               0,
                               &input,
                               sizeof(input));
    NSAssert1(err == noErr, @"Error setting callback: %hd", err);
    
    // Set the format to 32 bit, single channel, floating point, linear PCM
    const int four_bytes_per_float = 4;
    const int eight_bits_per_byte = 8;
    AudioStreamBasicDescription streamFormat;
    streamFormat.mSampleRate = _sampleRate;
    streamFormat.mFormatID = kAudioFormatLinearPCM;
    streamFormat.mFormatFlags =
    kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    streamFormat.mBytesPerPacket = four_bytes_per_float;
    streamFormat.mFramesPerPacket = 1;
    streamFormat.mBytesPerFrame = four_bytes_per_float;
    streamFormat.mChannelsPerFrame = 1;
    streamFormat.mBitsPerChannel = four_bytes_per_float * eight_bits_per_byte;
    err = AudioUnitSetProperty (_toneUnit,
                                kAudioUnitProperty_StreamFormat,
                                kAudioUnitScope_Input,
                                0,
                                &streamFormat,
                                sizeof(AudioStreamBasicDescription));
    NSAssert1(err == noErr, @"Error setting stream format: %hd", err);
}

@end
