//
//  UIImageView+Tint.m
//  Jobs
//
//  Created by Javier Manzo on 5/6/15.
//  Copyright (c) 2015 Demian Tejo. All rights reserved.
//

#import "UIImageView+Tint.h"

@implementation UIImageView (Tint)

-(void)setTintWithColor:(UIColor*)color{
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setTintColor:color];
}

@end


