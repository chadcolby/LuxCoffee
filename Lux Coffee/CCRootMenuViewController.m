//
//  CCRootMenuViewController.m
//  Lux Coffee
//
//  Created by Chad D Colby on 3/14/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRootMenuViewController.h"
#import "CCMainViewController.h"
#import "CCAboutViewController.h"
#import "CCLuxCoffeeViewController.h"

@interface CCRootMenuViewController ()

@property (strong, nonatomic) NSArray *menuOptionsArray;
@property (strong, nonatomic) CCMenuViewController *slideViewController;
@property (strong, nonatomic) CCAboutViewController *luxCommunitiesViewController;
@property (strong, nonatomic) NSMutableArray *navigationArray;
@property (strong, nonatomic) CCLuxCoffeeViewController *coffeeController;

@end

@implementation CCRootMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuOptionsArray = [NSArray arrayWithObjects:@"MENU", @"Lux Coffee Co.", @"Lux Communities", @"Email Us", nil];
    
    [self createInitialView];
    self.slideViewController.delegate = self;

    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Slide VC Methods

- (void)createInitialView
{
    self.slideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"initialViewController"];    
    [self addChildViewController:self.slideViewController];

    self.slideViewController.view.frame = self.tableView.frame;
    [self.view addSubview:self.slideViewController.view];
    [self.slideViewController didMoveToParentViewController:self];
    
}

//- (void)creatPanGesture
//{
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideToMenu:)];
//    panGesture.minimumNumberOfTouches = 1;
//    panGesture.maximumNumberOfTouches = 1;
//    
//    panGesture.delegate = self;
//    [self.slideViewController.view addGestureRecognizer:panGesture];
//}

//- (void)slideToMenu:(id)sender
//{
//    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
//    CGPoint trans = [panGesture translationInView:self.view];
//    
//    if (panGesture.state == UIGestureRecognizerStateChanged) {
//        
//        if (self.slideViewController.view.frame.origin.x + trans.x > 0) {
//            self.slideViewController.view.center = CGPointMake(self.slideViewController.view.center.x + trans.x
//                                                               , self.slideViewController.view.center.y);
//            
//            [(UIPanGestureRecognizer *)sender setTranslation:CGPointMake(0, 0) inView:self.view];
//            
//        }
//    }
//    
//    if (panGesture.state == UIGestureRecognizerStateEnded) {
//        if (self.slideViewController.view.frame.origin.x > self.tableView.frame.size.width / 3) {
//            [self showMenu];
//        }
//        
//        if (self.slideViewController.view.frame.origin.x < self.tableView.frame.size.width / 3) {
//            
//            [UIView animateWithDuration:.4 animations:^{
//                self.slideViewController.view.frame = self.view.frame;
//            } completion:^(BOOL finished) {
//                [self hideMenu];
//            }];
//        }
//    }
//}

//- (void)coverMenu:(id)sender
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        self.slideViewController.view.frame = self.view.frame;
//    } completion:^(BOOL finished) {
//        [self.slideViewController.view removeGestureRecognizer:(UITapGestureRecognizer *)sender];
//        
//        [self hideMenu];
//    }];
//}

#pragma mark - Table view data source/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.menuOptionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.menuOptionsArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-MediumItalic" size:20.f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            if (self.coffeeController == nil) {
                self.coffeeController = [self.storyboard instantiateViewControllerWithIdentifier:@"coffeeViewController"];
                self.coffeeController.delegate = self;
                
                [self addChildViewController:self.coffeeController];
                [self.view addSubview:self.coffeeController.view];
                [self.slideViewController.view removeFromSuperview];
                [self.coffeeController didMoveToParentViewController:self];
            }   else {
                [self transitionFromViewController:self.luxCommunitiesViewController toViewController:self.coffeeController duration:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    [self hideMenu:self.coffeeController];
                }];
            }
            
            break;
        case 2:
            if (self.luxCommunitiesViewController == nil) {
                self.luxCommunitiesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"luxCommunitiesAbout"];
                self.luxCommunitiesViewController.delegate = self;
                
                [self addChildViewController:self.luxCommunitiesViewController];
                [UIView transitionWithView:self.view duration:0.4 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                    [self.view addSubview:self.luxCommunitiesViewController.view];
                } completion:^(BOOL finished) {
                    [self.slideViewController.view removeFromSuperview];

                }];
                [self.luxCommunitiesViewController didMoveToParentViewController:self];
            }   else {
                [self transitionFromViewController:self.coffeeController toViewController:self.luxCommunitiesViewController duration:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    [self hideMenu:self.luxCommunitiesViewController];
                }];
            }
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
}

#pragma mark - Slide Menu Delegate Methods

- (void)showMenu:(UIViewController *)viewController
{
    
    [UIView animateWithDuration:0.4 animations:^{
        viewController.view.frame = CGRectMake(self.tableView.frame.size.width * 0.6,
                                                         viewController.view.frame.origin.y,
                                                         viewController.view.frame.size.width,
                                                         viewController.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        //[self.slideViewController creatTapGesture];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coversMenu:)];
        //        [self.slideViewController.view addGestureRecognizer:tap];
    }];
    
}

- (void)hideMenu:(UIViewController *)viewController
{
    [UIView animateWithDuration:.20 animations:^{
        viewController.view.frame = CGRectMake(self.tableView.frame.origin.x + 8.f,
                                                         self.tableView.frame.origin.y,
                                                         self.tableView.frame.size.width,
                                                         self.tableView.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            viewController.view.frame = self.view.frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 animations:^{
                viewController.view.frame = CGRectMake(self.tableView.frame.origin.x + 5.f,
                                                                 self.tableView.frame.origin.y,
                                                                 self.tableView.frame.size.width,
                                                                 self.tableView.frame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.005 animations:^{
                    viewController.view.frame = self.tableView.frame;
                }];
            }];
        }];
    }];
    
}

- (void)menuButtonPressed:(id)sender
{
    if (self.slideViewController.shouldShowMenu) {
        [self showMenu:self.slideViewController];
    }
    
}

@end
