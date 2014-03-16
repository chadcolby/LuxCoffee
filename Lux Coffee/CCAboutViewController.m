//
//  CCAboutViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/15/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCAboutViewController.h"
#import "CCMainViewController.h"
#import "CCCalendarController.h"

@interface CCAboutViewController ()

@property (strong, nonatomic) UISegmentedControl *segmentSelect;
@property (strong, nonatomic) CCMainViewController *eventsController;
@property (strong, nonatomic) UIBarButtonItem *backButton;

@end

@implementation CCAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.eventsController = [[CCMainViewController alloc] init];
    [[CCCalendarController sharedCalendarManager] updateEventsFromGoogleCalendar];
    self.view.alpha = 1.0;
    UIButton *showCalendar = [[UIButton alloc] initWithFrame:CGRectMake(260 , self.view.frame.origin.y + 10, 50 , 50)];
    [showCalendar addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    showCalendar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar50"]];
    [self.view addSubview:showCalendar];
    

    
    self.shouldShowMenu = NO;
}

- (void)buttonAction:(id)sender
{
    NSLog(@"Events");
    self.eventsController = [self.storyboard instantiateViewControllerWithIdentifier:@"luxCommEvents"];
    [self addChildViewController:self.eventsController];
    self.eventsController.view.frame = self.view.frame;
    [self.view addSubview:self.eventsController.view];
    [self.eventsController didMoveToParentViewController:self];
    [self.eventsController performSelector:@selector(refreshEventsList:)];
    [self.view removeGestureRecognizer:self.panGesture];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)createSegementControl
{
    NSArray *segmentArray = [NSArray arrayWithObjects:@"About Us", @"Events", @"Extra", nil];
    self.segmentSelect = [[UISegmentedControl alloc] initWithItems:segmentArray];
    self.segmentSelect.frame = CGRectMake(60, 12, 200, 25);
    self.segmentSelect.tintColor = [UIColor blackColor];
    [self.segmentSelect setSelectedSegmentIndex:0];
    [self.segmentSelect addTarget:self action:@selector(selectViews:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentSelect];
}

- (void)revealMenu:(id)sender
{

    [self.delegate showMenu:self];
}

- (void)selectViews:(id)sender
{
    NSInteger selectedIndex = self.segmentSelect.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:
            NSLog(@"About");
            break;
        case 1:
//            NSLog(@"Events");
//            self.eventsController = [self.storyboard instantiateViewControllerWithIdentifier:@"luxCommEvents"];
//            [self addChildViewController:self.eventsController];
//            self.eventsController.view.frame = self.view.frame;
//            [self.view addSubview:self.eventsController.view];
//            [self.eventsController didMoveToParentViewController:self];
//            [self.eventsController performSelector:@selector(refreshEventsList:)];
//            [self.view removeGestureRecognizer:self.panGesture];

            break;
        case 2:
            NSLog(@"extra");
            break;
        default:
            break;
    }
}


@end
