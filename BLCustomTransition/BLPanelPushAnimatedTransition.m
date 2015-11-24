//
//  BLMenuAnimatedTransition.m
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import "BLPanelPushAnimatedTransition.h"

@interface BLPanelPushAnimatedTransition ()

@end

@implementation BLPanelPushAnimatedTransition{
    CGFloat _duration;
}

- (instancetype)initWithPresenting:(BOOL)isPresenting
{
    self = [super init];
    if (self) {
        self.isPresenting = isPresenting;
        _duration = 0.3f;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithPresenting:YES];
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    if (_isPresenting) {
        
        CGRect PresentedViewFrame = [transitionContext finalFrameForViewController:toVC];
        CGRect startFrame = CGRectOffset(PresentedViewFrame, -1 * PresentedViewFrame.size.width, 0);
        
        toView.frame = startFrame;
        [containerView addSubview:toView];
        [UIView animateWithDuration:_duration animations:^{
            toView.frame = PresentedViewFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    
    } else {
        
        CGRect PresentedViewFrame = [transitionContext finalFrameForViewController:fromVC];
        CGRect endFrame = CGRectOffset(PresentedViewFrame, -1 * PresentedViewFrame.size.width, 0);
        
        [UIView animateWithDuration:_duration animations:^{
            fromView.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromView removeFromSuperview];
        }];
    }
}

@end
