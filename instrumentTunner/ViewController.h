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
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property audioAnalyzer *audio;
@property bool listen;

// Methods
-(void)askPermissionToUseTheMic;

@end

