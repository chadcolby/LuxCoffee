//
//  CCMenuViewController.h
//  Lux Coffee
//
//  Created by Chad D Colby on 3/14/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideMenuDelegate <NSObject>

- (void)showMenu:(UIViewController *)viewController;
- (void)hideMenu:(UIViewController *)viewController;
- (void)menuButtonPressed:(id)sender;

@end

@interface CCMenuViewController : UIViewController <UIGestureRecognizerDelegate>

@property(unsafe_unretained) id <SlideMenuDelegate> delegate;
@property (nonatomic) BOOL shouldShowMenu;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

- (void)revealMenu:(id)sender;
- (void)creatPanGesture;
- (void)creatTapGesture;
- (void)slideToMenu:(id)sender;
- (void)coverMenu:(id)sender;


@end
