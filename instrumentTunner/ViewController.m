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
    [[self navigationController]setNavigationBarHidden:true];
    [self askPermissionToUseTheMic];
    self.gauge = [[LMGaugeView alloc]initWithFrame:self.gaugeConstrains.frame];
    self.gauge.valueLabel.text = @"";
    self.gauge.valueFont = [UIFont fontWithName:@"Avenir" size:40];
    self.gauge.valueTextColor = [UIColor whiteColor];
    self.gauge.ringBackgroundColor = [UIColor grayColor];
    self.gauge.minValue = -50;
    self.gauge.maxValue = 50;
    self.gauge.showMinMaxValue = false;
    self.gauge.showUnitOfMeasurement = false;
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
    if(fabs(self.audio.percentage) < 5){
        self.gauge.progressLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    else{
        self.gauge.progressLayer.strokeColor  = [UIColor redColor].CGColor;
    }
    self.gauge.value = self.audio.percentage;
    self.gauge.valueLabel.text = self.audio.note;
}

-(void)allocAKIfNeededAndStart{
    if(self.audio == nil){
        self.audio = [[audioAnalyzer alloc]init];
    }
    [self.audio start];
    [self.audio listenToMic];
}
@end

