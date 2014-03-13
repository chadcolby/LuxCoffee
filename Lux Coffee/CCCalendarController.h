//
//  CCCalendarController.h
//  Lux Coffee
//
//  Created by Chad D Colby on 3/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GoogleCalendarDelegate <NSObject>

@optional

- (void)updateReturnedArray;

@end

@interface CCCalendarController : NSObject

@property (unsafe_unretained) id<GoogleCalendarDelegate> delegate;

+ (CCCalendarController *)sharedCalendarManager;

- (NSURL *)getEventsFromCalendarWithCalendarID:(NSString *)googleCalID;
- (void)updateEventsFromGoogleCalendar;
- (NSArray *)updatedEventsList;

@end
