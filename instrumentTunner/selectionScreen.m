//
//  selectionScreen.m
//  instrumentTunner
//
//  Created by Julian Allisio on 18/03/2021.
//

#import <Foundation/Foundation.h>
#import "selectionScreen.h"


@interface selectionScreen ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIPickerView *instrumentPicker;
@property NSMutableArray *instruments;
@end

@implementation selectionScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.instrumentPicker.dataSource = self;
    self.instrumentPicker.delegate = self;
    self.instruments = [[NSMutableArray alloc]initWithObjects:@"Guitar", nil];
    [self.instrumentPicker selectRow:1 inComponent:0 animated:YES];

}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)instrumentPicker {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)instrumentPicker numberOfRowsInComponent:(NSInteger)component {
    return [self.instruments count];
}

- (NSString *)pickerView:(UIPickerView *)instrumentPicker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   return [self.instruments objectAtIndex:row];
}
- (IBAction)startButtonPressed:(id)sender {
    [self.navigationController performSegueWithIdentifier:@"toTuningScreen" sender:nil];
}

/*
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}
*/
@end

