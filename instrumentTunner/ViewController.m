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
    //self.gauge = [[LMGaugeView alloc]initWithFrame:self.gaugeConstrains.frame];
    self.gauge = [[GaugeSliderView alloc]init];
    self.gauge.fillPathColor = [UIColor clearColor];
    self.gauge.placeholder = @"";
    self.gauge.minValue = -50;
    self.gauge.maxValue = 50;
    [self.gauge setFrame: self.gaugeConstrains.frame];
    [self.view addSubview:self.gauge];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(updateGauge)
            name:@"UpdateGauge"
            object:nil];
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
    self.gauge.value = self.audio.percentage;
}

-(void)allocAKIfNeededAndStart{
    if(self.audio == nil){
        self.audio = [[audioAnalyzer alloc]init];
    }
    [self.audio start];
    [self.audio listenToMic];
}
@end

