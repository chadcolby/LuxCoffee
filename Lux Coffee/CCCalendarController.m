//
//  CCCalendarController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCCalendarController.h"
#import "CCCalendarEvents.h"

#define kGOOGLE_CALS @"http://www.google.com/calendar/feeds/"
#define kGOOGLE_PARAMS @"/public/full?alt=json&max-results=25&singleevents=false&futureevents=true&sortorder=ascending&orderby=starttime"
#define kGOOGLE_CAL_ID @"luxcoffeeco@gmail.com"

@interface CCCalendarController () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSURLSession *urlSession;
@property (strong, nonatomic) NSURLSessionDataTask *eventsTasks;
@property (strong, nonatomic) NSOperationQueue *eventsDownloadQueue;
@property (strong, nonatomic) NSMutableArray *eventsArray;

@end

@implementation CCCalendarController

+ (CCCalendarController *)sharedCalendarManager
{
    static dispatch_once_t pred;
    static CCCalendarController *sharedCalendar = nil;
    
    dispatch_once(&pred, ^{
        sharedCalendar = [[CCCalendarController alloc] init];
        if (!sharedCalendar.eventsDownloadQueue) {
            [sharedCalendar setUpCalendar];
        }
    });
    
    return sharedCalendar;
}

#pragma mark - Initial Setup

- (void)setUpCalendar
{
    self.eventsDownloadQueue = [[NSOperationQueue alloc] init];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setRequestCachePolicy:NSURLCacheStorageAllowed];
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];
    sessionConfiguration.timeoutIntervalForRequest = 10.0;
    sessionConfiguration.timeoutIntervalForResource = 30.0;
    
    self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self
                                               delegateQueue:self.eventsDownloadQueue];
}

#pragma mark - Instance Methods

- (NSURL *)getEventsFromCalendarWithCalendarID:(NSString *)googleCalID
{
    NSString *googleCalendarURLString = [NSString stringWithFormat:@"%@%@%@", kGOOGLE_CALS, googleCalID, kGOOGLE_PARAMS];
    
    return [NSURL URLWithString:googleCalendarURLString];
}

- (void)updateEventsFromGoogleCalendar
{
    NSURL *googleCalendarURL = [self getEventsFromCalendarWithCalendarID:kGOOGLE_CAL_ID];
    self.eventsArray = [[NSMutableArray alloc] init];
    self.eventsTasks = [self.urlSession dataTaskWithURL:googleCalendarURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        

            NSError *anotherError;
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&anotherError];


                NSDictionary *googleCalendarData = (NSDictionary *)jsonData;
                
                NSArray *allEvents = [(NSDictionary *)[googleCalendarData objectForKey:@"feed"] objectForKey:@"entry"];
      
            NSDateFormatter *eventFormat = [[NSDateFormatter alloc] init];
            [eventFormat setLocale:[NSLocale currentLocale]];
            [eventFormat setDateStyle:NSDateFormatterMediumStyle];
            [eventFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSzzz"];
            [eventFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
        
        for (NSDictionary *entry in allEvents) {

            CCCalendarEvents *event = [[CCCalendarEvents alloc] init];
            event.titleString = [[entry objectForKey:@"title"] objectForKey:@"$t"];
            event.contentString = [[entry objectForKey:@"content"] objectForKey:@"$t"];
            //NSArray *eventStartDate = [entry objectForKey:@"gd$when"];
            //NSString *tempString = [[eventStartDate firstObject] objectForKey:@"startTime"];



            [self.eventsArray addObject:event];

        }
        NSLog(@"%@", self.eventsArray);
        [self.delegate updateReturnedArray];
    }];
    
    [self.eventsTasks resume];

}

# pragma mark - GoogleCalendarDelegate methods

- (NSArray *)updatedEventsList
{
    NSArray *updatedArrayOfEvents = [NSArray arrayWithArray:self.eventsArray];
    
    return updatedArrayOfEvents;
}


@end
