//
//  CCMainViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMainViewController.h"
#import "CCCalendarController.h"
#import "CCCalendarEvents.h"
#import "UIViewController+CWPopup.h"
#import "CCEventDetailsViewController.h"

@interface CCMainViewController () <GoogleCalendarDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSArray *eventsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CCEventDetailsViewController *eventDetailsVC;
@property (strong, nonatomic) UIButton *closeButton;


@end

@implementation CCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[CCCalendarController sharedCalendarManager] setDelegate:self];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTheRefreshThang:) name:@"shouldReloadTableView" object:nil];
    
    self.useBlurForPopup = YES;
    
    [self setUpGestureRecognizerForEventDetails];
    self.navigationController.navigationBarHidden = YES;
    
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 25, self.view.frame.size.height - 60, 50 , 50)];
    [self.closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smallClose"]];
    self.closeButton.alpha = 0.8f;
    [self.view addSubview:self.closeButton];
    
}

- (void)doTheRefreshThang:(NSNotification *)sender
{
    self.eventsArray = [[CCCalendarController sharedCalendarManager] updatedEventsList];
    
    [self.tableView reloadData];
}

- (void)buttonAction:(id)sender
{
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)setUpGestureRecognizerForEventDetails
{
    UITapGestureRecognizer *tapToShowEventDetails = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDetails)];
    tapToShowEventDetails.numberOfTapsRequired = 1;
    tapToShowEventDetails.delegate = self;
    [self.view addGestureRecognizer:tapToShowEventDetails];
}

- (void)dismissDetails
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:nil];
        self.closeButton.enabled = YES;
    }
}

#pragma mark - table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"calendarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    CCCalendarEvents *event = self.eventsArray[indexPath.row];
    
    cell.textLabel.text = event.titleString;
    //cell.detailTextLabel.text = event.startDate;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.eventDetailsVC = [[CCEventDetailsViewController alloc] initWithNibName:@"CCEventDetailsViewController" bundle:nil];
    self.eventDetailsVC.view.frame = CGRectMake(20, 20, self.view.frame.size.width - 100, self.view.frame.size.height - 300);
    
    UILabel *detailsLabel = [[UILabel alloc] init];
    detailsLabel.frame = CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.size.height - 528, self.eventDetailsVC.view.frame.size.width - 20, self.eventDetailsVC.view.frame.size.height);

    CCCalendarEvents *event = self.eventsArray[indexPath.row];
    
    detailsLabel.numberOfLines = 0;
    detailsLabel.text = event.contentString;
    [detailsLabel sizeToFit];
    [self.eventDetailsVC.view addSubview:detailsLabel];
    
    self.closeButton.enabled = NO;
    
    [self presentPopupViewController:self.eventDetailsVC animated:YES completion:nil];
}

@end
