//
//  instrumentTunnerTests.m
//  instrumentTunnerTests
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <XCTest/XCTest.h>
#import <AudioKit/AudioKit.h>
#import "../instrumentTunner/audioAnalyzer.h"

@interface instrumentTunnerTests : XCTestCase

@property audioAnalyzer *audio;

@end

@implementation instrumentTunnerTests

- (void)setUp {
    self.audio = [[audioAnalyzer alloc] init];
}


- (void)tearDown {
}

- (void)testTones {
    AKOscillator * oscilator = [[AKOscillator alloc]init];
    oscilator.amplitude = 0.1;
    // D#0
    oscilator.frequency = 19.45;
    [oscilator start];
    [self.audio start];
    XCTAssertEqualObjects(@"D#0", [self.audio frequencyToNote:oscilator.frequency], @"Program returned the wrong note");
    NSLog(@"self.audio.tracker.frequency:%@",[self.audio frequencyToNote:oscilator.frequency]);
    [oscilator stop];
    [self.audio stop];
    // G#2 (A little bit out of tune)
    oscilator.frequency = 105;
    [oscilator start];
    [self.audio start];
    XCTAssertEqualObjects(@"G#2", [self.audio frequencyToNote:oscilator.frequency], @"Program returned the wrong note");
    NSLog(@"self.audio.tracker.frequency:%@",[self.audio frequencyToNote:oscilator.frequency]);
    [oscilator stop];
    [self.audio stop];
    // G3 (Right in the edge between F#3 and G3)
    oscilator.frequency = 190.5;
    [oscilator start];
    [self.audio start];
    XCTAssertEqualObjects(@"G3", [self.audio frequencyToNote:oscilator.frequency], @"Program returned the wrong note");
    NSLog(@"self.audio.tracker.frequency:%@",[self.audio frequencyToNote:oscilator.frequency]);
    [oscilator stop];
    [self.audio stop];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
