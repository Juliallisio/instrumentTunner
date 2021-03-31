//
//  ViewController.m
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import "ViewController.h"
#import <LMGaugeView.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [self askPermissionToUseTheMic];
    CGRect frame = CGRectMake(100, 100, 400, 400);
    self.gaugeView = [[LMGaugeView alloc] initWithFrame:frame];
    self.gaugeView.value = 40;
    [self.view addSubview:self.gaugeView];
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

