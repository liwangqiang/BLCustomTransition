//
//  BLMenuAnimatedTransition.h
//  BLCustomTransition
//
//  Created by wangqiang li on 11/23/15.
//  Copyright © 2015 wangqiang li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLPanelPushAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;
- (instancetype)initWithPresenting:(BOOL)isPresenting;

@end
