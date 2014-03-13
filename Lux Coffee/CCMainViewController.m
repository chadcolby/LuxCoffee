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

@interface CCMainViewController () <GoogleCalendarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *eventsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)updateCalendar:(id)sender;

@end

@implementation CCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[CCCalendarController sharedCalendarManager] setDelegate:self];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[CCCalendarController sharedCalendarManager]updateEventsFromGoogleCalendar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)updateCalendar:(id)sender {
    
    NSLog(@"pressed");
    self.eventsArray = [[CCCalendarController sharedCalendarManager] updatedEventsList];
    [self.tableView reloadData];
}

- (void)updateReturnedArray
{

    NSLog(@"final: %d", self.eventsArray.count );
    [self.tableView reloadData];
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
    
    return cell;
}

@end
