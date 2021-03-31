//
//  ViewController.h
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <UIKit/UIKit.h>
#import "audioAnalyzer.h"
#import <LMGaugeView.h>
#import <AVFoundation/AVFAudio.h>

@interface ViewController : UIViewController
// Properties
@property audioAnalyzer *audio;
@property LMGaugeView *gaugeView;

// Methods
-(void)askPermissionToUseTheMic;

@end

