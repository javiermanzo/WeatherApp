//
//  AppHelper.m
//  WeatherApp
//
//  Created by Javier Manzo on 4/8/16.
//  Copyright © 2016 Javier Manzo. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper


+(void)changeRootViewController:(UIViewController*)viewController fromViewController:(UIViewController*)originViewController{
    UIView *snapShot = [originViewController.view.window snapshotViewAfterScreenUpdates:YES];
    [originViewController.view addSubview:snapShot];
    originViewController.view.window.rootViewController = viewController;
    [UIView animateWithDuration:1 animations:^{
        snapShot.layer.opacity = 0;
        snapShot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
    }];
}

@end
