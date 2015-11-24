//
//  BLTransitionDelegate.m
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import "BLPanelPushTransitioningDelegate.h"
#import "BLPanelPushAnimatedTransition.h"
#import "BLPanelPushPresentationController.h"

@interface BLPanelPushTransitioningDelegate ()

@property (nonatomic, strong) BLPanelPushAnimatedTransition *leftMenuAnimatedTransiton;

@end

@implementation BLPanelPushTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.leftMenuAnimatedTransiton.isPresenting = YES;
    return self.leftMenuAnimatedTransiton;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.leftMenuAnimatedTransiton.isPresenting = NO;
    return self.leftMenuAnimatedTransiton;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    BLPanelPushPresentationController *presentationController = [[BLPanelPushPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return presentationController;
}

#pragma mark - Properties

- (BLPanelPushAnimatedTransition *)leftMenuAnimatedTransiton
{
    if (!_leftMenuAnimatedTransiton) {
        _leftMenuAnimatedTransiton = [[BLPanelPushAnimatedTransition alloc]init];
    }
    return _leftMenuAnimatedTransiton;
}



@end
