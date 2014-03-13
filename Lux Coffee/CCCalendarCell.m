//
//  CCCalendarCell.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCCalendarCell.h"
#import "CCEventDetailsViewController.h"

@interface CCCalendarCell ()

@property (strong, nonatomic) CCEventDetailsViewController *eventDetailsVC;

@end

@implementation CCCalendarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];


}

@end
