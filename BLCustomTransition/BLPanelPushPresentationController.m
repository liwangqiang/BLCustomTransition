//
//  BLPresentationController.m
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import "BLPanelPushPresentationController.h"

static CGFloat finalWidthForPresentedView = 245;

@implementation BLPanelPushPresentationController{
    UIView *_dimmingView;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _dimmingView = [UIView new];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.alpha = 0.0f;
        UIGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToDismiss:)];
        [_dimmingView addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)containerViewWillLayoutSubviews
{
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

- (void)presentationTransitionWillBegin
{
    _dimmingView.frame = self.containerView.bounds;
    [self.containerView addSubview:_dimmingView];

    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.alpha = 0.5;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.alpha = 0.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [_dimmingView removeFromSuperview];
    }];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView
{
    return CGRectMake(0, 0, finalWidthForPresentedView, [UIScreen mainScreen].bounds.size.height);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //旋转时也可以正确显示
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _dimmingView.frame = [coordinator containerView].bounds;
    } completion:nil];
}

#pragma mark - Event Response

- (void)tapToDismiss:(UIGestureRecognizer *)gestureRecognizer
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
