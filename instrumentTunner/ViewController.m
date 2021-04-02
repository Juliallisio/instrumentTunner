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
    [self askPermissionToUseTheMic];
    self.gauge = [[LMGaugeView alloc]initWithFrame:self.gaugeConstrains.frame];
    self.gauge.maxValue = 5000;
    self.gauge.decimalFormat = TRUE;
    [self.view addSubview:self.gauge];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:TRUE];
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


-(void)updateGauge{
    dispatch_async(dispatch_get_main_queue(), ^{
        while(self.audio.listen){
            if(self.audio.tracker.amplitude > 0.01){
                self.gauge.value = self.audio.tracker.frequency;
                NSLog(@"self.audio.tracker.frequency:%f",self.gauge.value);
                [self.gaugeConstrains setNeedsDisplay];
                [self.gaugeConstrains layoutIfNeeded];
            }
        }
    });
}

-(void)allocAKIfNeededAndStart{
    if(self.audio == nil){
        self.audio = [[audioAnalyzer alloc]init];
    }
    [self.audio start];
    [self.audio listenToMic];
    [self updateGauge];
}
@end

