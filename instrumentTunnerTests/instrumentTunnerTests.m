//
//  instrumentTunnerTests.m
//  instrumentTunnerTests
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <XCTest/XCTest.h>
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
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
