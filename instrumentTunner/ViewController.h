//
//  ViewController.h
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <UIKit/UIKit.h>
#import "audioAnalyzer.h"
#import <AVFoundation/AVFAudio.h>

@interface ViewController : UIViewController
// Properties
@property AudioAnalyzer *audio;
@property (weak, nonatomic) IBOutlet UIImageView *red_dot_low_note;
@property (weak, nonatomic) IBOutlet UIImageView *red_dot_high_note;
@property (weak, nonatomic) IBOutlet UILabel *note_label;

// Methods
-(void)askPermissionToUseTheMic;
-(void)updateGauge;

@end

