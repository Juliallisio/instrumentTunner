//
//  ViewController.m
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import "ViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [self askPermissionToUseTheMic];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.audio stop];
}

-(void) askPermissionToUseTheMic{
    switch ([[AVAudioSession sharedInstance] recordPermission]) {
        case AVAudioSessionRecordPermissionGranted:
            [self allocAKIfNeededAndStart];
            break;
        case AVAudioSessionRecordPermissionDenied:

            break;
        case AVAudioSessionRecordPermissionUndetermined:
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    NSLog(@"granted");
                    [self allocAKIfNeededAndStart];
                } else {
                    NSLog(@"denied");
                }
            }];
            break;
    }
}

-(void)allocAKIfNeededAndStart{
    if(self.audio == nil){
        self.audio = [[audioAnalyzer alloc]init];
    }
    [self.audio start];
    [self.audio listenToMic];
}
@end

