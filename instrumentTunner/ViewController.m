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
    self.red_dot_low_note.hidden = true;
    self.red_dot_high_note.hidden = true;
    self.note_label.text = @"n/a";
    
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
            self.audio = [[AudioAnalyzer alloc] init];
            break;
        case AVAudioSessionRecordPermissionDenied:

            break;
        case AVAudioSessionRecordPermissionUndetermined:
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    NSLog(@"granted");
                    self.audio = [[AudioAnalyzer alloc] init];
                } else {
                    NSLog(@"denied");
                }
            }];
            break;
    }
}


-(void)updateGauge{
    if(fabs(self.audio.percentage) < 10){
        self.red_dot_low_note.hidden = true;
        self.red_dot_high_note.hidden = true;
        self.note_label.textColor = [UIColor greenColor];
    }
    else{
        self.note_label.textColor = [UIColor grayColor];
        if(self.audio.percentage < 5){
            self.red_dot_low_note.hidden = false;
            self.red_dot_high_note.hidden = true;
        }
        else{
            self.red_dot_low_note.hidden = true;
            self.red_dot_high_note.hidden = false;
        }
    }
    self.note_label.text = self.audio.note;
}

@end

