//
//  instrumentTunnerTests.m
//  instrumentTunnerTests
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <XCTest/XCTest.h>
#import <AudioKit/AudioKit.h>
#import "../instrumentTunner/Models/audioAnalyzer.h"

@interface instrumentTunnerTests : XCTestCase

@property AudioAnalyzer *audio;

@end

@implementation instrumentTunnerTests


- (void) setUp {
    self.audio = [[AudioAnalyzer alloc] init];
}


- (void)tearDown {
    self.audio = [[AudioAnalyzer alloc] deinit];
}

- (void)testTones {
    // D#0
    XCTAssertEqualObjects(@"D#0", [self.audio frequencyToNote:19.45], @"Program returned the wrong note");
    // G#2 (A little bit out of tune)
    XCTAssertEqualObjects(@"G#2", [self.audio frequencyToNote:105], @"Program returned the wrong note");
    // G3 (Right in the edge between F#3 and G3)
    XCTAssertEqualObjects(@"G3", [self.audio frequencyToNote:190.5], @"Program returned the wrong note");
}

- (void)testNoteOutOfRange {
    // Below C0 (Should return "Note out of range")
    XCTAssertEqualObjects(@"Note out of range", [self.audio frequencyToNote:15], @"Program returned the wrong note");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
