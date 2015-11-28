//
//  BLMenuViewController.m
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import "BLPanelViewController.h"
#import "BLProfileViewController.h"

static NSString * const presentationIdentifier = @"pop";
static NSString * const unwindFromPopoverIdentifier = @"UnwindFromPopover";

static NSString * const presentationModellyCurrentContextIdentifier = @"PresentModellyCurrentContext";
static NSString * const presentationModellyFullScreenIdentifier = @"PresentModellyFullScreen";
static NSString * const unwindFromPresentedModellyIdentifier = @"UnwindFromPresentedModelly";


#define IS_IPHONE ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define IS_IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

@interface BLPanelViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) BLProfileViewController *profileVC;

@end

@implementation BLPanelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
#warning iPad下旋转后去掉Popover
    if (self.profileVC || IS_IPAD) {
        [self.profileVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:presentationIdentifier]) {
        self.profileVC = segue.destinationViewController;
        UIPopoverPresentationController *presentationController = [self.profileVC popoverPresentationController];
        presentationController.delegate = self;
        //设定一些appearance
        presentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        presentationController.sourceView = self.button;
        presentationController.sourceRect = CGRectZero;
#warning 请替换 modalPresentationStyle 属性 观察model的表现
    } else if ([segue.identifier isEqualToString:presentationModellyFullScreenIdentifier]){
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    } else if ([segue.identifier isEqualToString:presentationModellyCurrentContextIdentifier]) {
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate
//iPhone下必须实现此委托才能实现Popover
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

#warning 支持iPhone的旋转，但iPad下旋转后会显示位置不正确，在上面的 -viewWillLayoutSubViews 中修复
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if (self.profileVC || IS_IPHONE) {
        [self.profileVC dismissViewControllerAnimated:NO completion:nil];
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self performSegueWithIdentifier:presentationIdentifier sender:self];
        }];
    }
}

#pragma mark - unwind
#warning iPhone下需要添加dismiss， iPad不用
-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue
{
    if (IS_IPHONE) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
