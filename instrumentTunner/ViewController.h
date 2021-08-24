//
//  ViewController.h
//  instrumentTunner
//
//  Created by Julian Allisio on 05/03/2021.
//

#import <UIKit/UIKit.h>
#import "audioAnalyzer.h"
#import <GaugeSlider/GaugeSlider-Swift.h>
#import <AVFoundation/AVFAudio.h>

@interface ViewController : UIViewController
// Properties
@property audioAnalyzer *audio;
@property GaugeSliderView *gauge;
@property (weak, nonatomic) IBOutlet UIView *gaugeConstrains;

// Methods
-(void)askPermissionToUseTheMic;
-(void)updateGauge;

@end

