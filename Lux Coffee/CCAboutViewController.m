//
//  CCAboutViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/15/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCAboutViewController.h"

@interface CCAboutViewController ()

@end

@implementation CCAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.shouldShowMenu = NO;
    [self creatTapGesture];
    [self creatPanGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)revealMenu:(id)sender
{

    [self.delegate showMenu:self];
}

@end
