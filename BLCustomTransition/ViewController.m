//
//  ViewController.m
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import "ViewController.h"
#import "BLPanelPushTransitioningDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) BLPanelPushTransitioningDelegate *PanelTransitionDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        segue.destinationViewController.transitioningDelegate = self.PanelTransitionDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

#pragma mark - for unwind

- (IBAction)unwindFromMenuViewController:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Properties

- (BLPanelPushTransitioningDelegate *)PanelTransitionDelegate
{
    if (!_PanelTransitionDelegate) {
        _PanelTransitionDelegate = [BLPanelPushTransitioningDelegate new];
    }
    return _PanelTransitionDelegate;
}

@end
