//
//  audioAnalizer.m
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import "audioAnalyzer.h"
#import <AudioKit/AudioKit.h>
#import <AVFoundation/AVFoundation.h>
#import <math.h>


@interface audioAnalyzer ()
@end

@implementation audioAnalyzer

-(id)init{
    self.listen = TRUE;
    // Figure out how to detect sample rate
    AVAudioFormat *newFormat = [[AVAudioFormat alloc]initStandardFormatWithSampleRate:32000 channels:1];
    self.mic = [[AKMicrophone alloc]initWith:newFormat];
    self.tracker = [[AKFrequencyTracker alloc]init:self.mic hopSize:4096.0 peakCount:200];
    self.silence = [[AKBooster alloc]init:self.tracker gain:0];
    AKSettings.audioInputEnabled = true;
    [AKManager setInputDevice:(AKDevice *)[AKManager.inputDevices objectAtIndex:0] error:NULL];
    [AKManager setOutputDevice:(AKDevice *)[AKManager.outputDevices objectAtIndex:0] error:NULL];
    AKManager.output = self.silence;
    
    return self;
}

-(id)deinit{
    return self;
}

-(void)stop{
    [AKManager stopAndReturnError:NULL];
    [self.mic stop];
    [self.tracker stop];
}

-(void)start{
    [AKManager startAndReturnError:NULL];
    [self.mic start];
    [self.tracker start];
}

- (void)listenToMic {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        while(self.listen){
            if(self.tracker.amplitude > 0.005){
                NSLog(@"self.audio.tracker.frequency:%@",[self frequencyToNote:self.tracker.frequency]);
            }
        }
    });
}

- (NSString *)frequencyToNote: (double)freq{
    NSArray * notes_array = @[@"C",@"C#",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",@"A",@"A#",@"B"];
    // 32.701 = frequency of C1
    int n = round(12*log2(freq/32.703));
    NSString *note_number = [NSString stringWithFormat:@"%f", (round(n/12)+1)];
    int arr_position = n%12;
    NSString *note = [[notes_array objectAtIndex:arr_position] stringByAppendingString:note_number];
    return note;
}

@end

