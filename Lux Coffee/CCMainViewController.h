//
//  CCMainViewController.h
//  Lux Coffee
//
//  Created by Chad D Colby on 3/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMainViewController : UIViewController

@property (nonatomic) BOOL shouldRefresh;

- (void)refreshEventsList:(id)sender;


@end
