//
//  CCLuxCoffeeViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/15/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCLuxCoffeeViewController.h"

@interface CCLuxCoffeeViewController ()

@end

@implementation CCLuxCoffeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LuxCoffeeBG2"]];
    self.view.alpha = 1.0f;
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
