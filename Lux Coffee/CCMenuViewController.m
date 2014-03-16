//
//  CCMenuViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/14/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMenuViewController.h"

@interface CCMenuViewController ()

@end

@implementation CCMenuViewController

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
    
    self.shouldShowMenu = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"luxBG2"]];
    self.view.alpha = 0.9;
    
    [super viewDidLoad];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [menuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    menuButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon-Small-50"]];
    [self.view addSubview:menuButton];
    
    [self creatPanGesture];
    [self creatTapGesture];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)creatPanGesture
{
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideToMenu:)];
        self.panGesture.minimumNumberOfTouches = 1;
        self.panGesture.maximumNumberOfTouches = 1;
        
        self.panGesture.delegate = self;
        [self.view addGestureRecognizer:self.panGesture];
    
}

- (void)creatTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverMenu:)];
    [self.view addGestureRecognizer:tap];
}

- (void)slideToMenu:(id)sender
{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    CGPoint trans = [panGesture translationInView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        if (self.view.frame.origin.x + trans.x > 0) {
            self.view.center = CGPointMake(self.view.center.x + trans.x
                                                               , self.view.center.y);
            
            [(UIPanGestureRecognizer *)sender setTranslation:CGPointMake(0, 0) inView:self.view];
            
        }
    }
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {

        if (self.view.frame.origin.x > self.view.frame.size.width / 3) {
            [self.delegate showMenu:(UIViewController *)sender];
        }
        
        if (self.view.frame.origin.x < self.view.frame.size.width / 3) {
            
            [UIView animateWithDuration:.4 animations:^{
                self.view.frame = self.view.frame;
            } completion:^(BOOL finished) {
                [self.delegate hideMenu:(UIViewController *)sender];
            }];
        }
    }
}

- (void)coverMenu:(id)sender
{

    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = self.view.frame;
    } completion:^(BOOL finished) {
        //[self.view removeGestureRecognizer:(UITapGestureRecognizer *)sender];
        
        [self.delegate hideMenu:self];
        
    
    }];
}



//- (void)showMenu
//{
//    [UIView animateWithDuration:0.4 animations:^{
//        self.view.frame = CGRectMake(self.view.frame.size.width * 0.7,
//                                                         self.view.frame.origin.y,
//                                                         self.view.frame.size.width,
//                                                         self.view.frame.size.height);
//        
//    } completion:^(BOOL finished) {
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverMenu:)];
//        [self.view addGestureRecognizer:tap];
//    }];
//    
//}
//
//- (void)hideMenu
//{
//    [UIView animateWithDuration:.15 animations:^{
//        self.view.frame = CGRectMake(self.view.frame.origin.x + 6.f,
//                                                         self.view.frame.origin.y,
//                                                         self.view.frame.size.width,
//                                                         self.view.frame.size.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:.1 animations:^{
//            self.view.frame = self.view.frame;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:.075 animations:^{
//                self.view.frame = CGRectMake(self.view.frame.origin.x + 3.f,
//                                                                 self.view.frame.origin.y,
//                                                                 self.view.frame.size.width,
//                                                                 self.view.frame.size.height);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:.033 animations:^{
//                    self.view.frame = self.view.frame;
//                }];
//            }];
//        }];
//    }];
//    
//}

- (void)revealMenu:(id)sender
{
    self.shouldShowMenu = YES;
    [self.delegate menuButtonPressed:self];
}


@end
