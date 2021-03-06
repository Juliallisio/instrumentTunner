//
//  audioAnalizer.h
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <UIKit/UIKit.h>
#import <AudioKit/AudioKit.h>

@interface AudioAnalyzer: NSObject

// Properties
@property AKMicrophone *mic;
@property AKFrequencyTracker *tracker;
@property AKBooster *silence;
@property bool listen;
@property double percentage;
@property NSString *note;

// Methods
-(id)init;
-(id)deinit;
-(void)stop;
-(void)start;
-(void)listenToMic;
-(NSString *)frequencyToNote:(double)freq;
@end


