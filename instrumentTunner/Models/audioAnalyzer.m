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


@interface AudioAnalyzer ()
@end

@implementation AudioAnalyzer

-(id)init{
    if (self != nil) {
        [self deinit];
    }
    
    self.listen = TRUE;
    AVAudioFormat *newFormat = [[AVAudioFormat alloc]initStandardFormatWithSampleRate:[[AVAudioSession sharedInstance]sampleRate] channels:1];
    self.mic = [[AKMicrophone alloc]initWith:newFormat];
    self.tracker = [[AKFrequencyTracker alloc]init:self.mic hopSize:4096.0 peakCount:200];
    self.silence = [[AKBooster alloc]init:self.tracker gain:0];
    AKSettings.audioInputEnabled = true;
    [AKManager setInputDevice:(AKDevice *)[AKManager.inputDevices objectAtIndex:0] error:NULL];
    [AKManager setOutputDevice:(AKDevice *)[AKManager.outputDevices objectAtIndex:0] error:NULL];
    AKManager.output = self.silence;
    [self start];
    return self;
}

-(id)deinit{
    [self stop];
    return self;
}

-(void)stop{
    [AKManager stopAndReturnError:NULL];
    [self.mic stop];
    [self.tracker stop];
}

-(void)start{
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(listenToMic)
                                   userInfo:nil
                                    repeats:YES];
    [AKManager startAndReturnError:NULL];
    [self.mic start];
    [self.tracker start];
    [self listenToMic];
}

-(void)listenToMic{
    if(self.tracker.amplitude > 0.1){
        float n = 12*log2(self.tracker.frequency/16.35);
        self.percentage = 100*(n - round(n));
        self.note = [self frequencyToNote:self.tracker.frequency];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"UpdateGauge"
         object:self];
    }
    
}

- (NSString *)frequencyToNote: (double)freq{
    if (freq >= 16.35){
        NSArray * notes_array = @[@"C",@"C#",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",@"A",@"A#",@"B"];
        // 16.35 = frequency of C0
        int n = round(12*log2(freq/16.35));
        NSString *note_number = [NSString stringWithFormat:@"%i", (int)(lroundf(n/12))];
        int arr_position = n%12;
        NSString *note = [[notes_array objectAtIndex:arr_position] stringByAppendingString:note_number];
        return note;
    }
    else{
        return @"Note out of range";
    }
}

@end

