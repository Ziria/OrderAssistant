//
//  MainViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "PopoverView.h"
#import "MenuView.h"
#import "WebServices.h"
#import "ArrResViewController.h"
#import "PersonalViewController.h"
#import "PersonalInformationViewController.h"
#import "SwitchTabBarViewController.h"
#import "JSNotifier.h"
#import "CouponMainViewController.h"
#import "ShopTabViewController.h"
#import "IntroViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize topButton;
@synthesize bottomButton;
@synthesize arrowButton;
@synthesize expanding;
@synthesize curLocation;
@synthesize locationManager;
@synthesize menuChoiceLbl;
@synthesize recommendButton;
@synthesize friendsButton;
@synthesize shopCode;
@synthesize familyButton;
@synthesize lovaButton;
@synthesize companyButton;
@synthesize busniessButton;
@synthesize couponButton;
@synthesize exitButton;
@synthesize searchButton;
@synthesize eatWhatButton;
@synthesize changePoints;
@synthesize deviceTokenNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[WebServices getAreaInfo];
    
    deviceTokenNum=((AppDelegate *)[[UIApplication sharedApplication] delegate]).deviceTokenNum;
    
    
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.topItem.title = @"唔要吃 － 常州站";
    UIImage *buttonImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [topButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [topButton setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    CGRect buttonFrame = [topButton frame];
    buttonFrame.size.width = buttonImage.size.width + 210;
    buttonFrame.size.height = buttonImage.size.height;
    [topButton setFrame:buttonFrame];
    [bottomButton setHidden:YES];
    [arrowButton setHidden:YES];
    [menuChoiceLbl setHidden:YES];
    //[self getCurPosition];
    //[self locationManager];
    
    [changePoints addTarget:self action:@selector(noAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)noAction{
    JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"开发中，敬请期待！"];
    [notify showFor:2.0];
}


//获得自己的当前的位置信息
- (void) getCurPosition
{
	//开始探测自己的位置
	if (locationManager == nil)
	{
		locationManager =[[CLLocationManager alloc] init];
	}
	
	if ([CLLocationManager locationServicesEnabled])
	{
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
		[locationManager startUpdatingLocation];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	// Get all regions being monitored for this application.
	
}

//响应当前位置的更新，在这里记录最新的当前位置
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
			fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval interval = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    NSLog(@"%lf", interval);
    //保存新位置
    curLocation = newLocation.coordinate;
    if (oldLocation == nil) {
        NSString *lad=[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        NSString *lgd=[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
        NSLog(@"latitude === %@", lad);
        NSLog(@"longitude === %@", lgd);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (IBAction)showRecommendShopList:(id)sender{
//    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    ArrResViewController *arrResViewController = [storyborad instantiateViewControllerWithIdentifier:@"ArrResViewController"];
//    //arrResViewController.resEntity=resEntity;
//    [self.navigationController pushViewController:arrResViewController animated:YES];
//}
//弹出视图
- (IBAction)menuButton:(id)sender
{
    float angle = self.isExpanding ? -M_PI : 0.0f;
    [UIView animateWithDuration:0.1f animations:^{
        arrowButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    CGPoint point = CGPointMake(160.0, 360.0);
    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 280, 120)];
    [PopoverView showPopoverAtPoint:point inView:self.view withContentView:menuView delegate:self];
    
}

- (BOOL)isExpanding
{
    if (expanding) {
        expanding = NO;
    } else {
        expanding = YES;
    }
    return expanding;
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    float angle = self.isExpanding ? -M_PI : 0.0f;
    [UIView animateWithDuration:0.1f animations:^{
        arrowButton.transform = CGAffineTransformMakeRotation(angle);
    }];
}

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
}

- (IBAction)exitBtnPress:(id)sender{
    [UserKeychain delete:KEY_USERID_CCODE];
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
    UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];
    [self presentModalViewController:navPersonalViewController animated:NO];
}




-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    UITabBarController *tabBarController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"Coupon"]) {
        tabBarController.title=@"优惠券";
    }
    else{
        tabBarController.title=@"餐厅";
    }
    tabBarController.selectedIndex = 0;
    //    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(showActionDistance)];
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=nil;
    if ([segue.identifier isEqualToString:@"Friends"]) {
        //deviceTokenNum = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).deviceTokenNum;
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"c3b304a3495041d8b7b4181c49112df9";
    }else if ([segue.identifier isEqualToString:@"Family"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"51d83d3bd1434ff79fb617b11305bd34";
    }else if ([segue.identifier isEqualToString:@"Love"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"0b35820399564df5ae2146e044c77707";
    }else if ([segue.identifier isEqualToString:@"Busniess"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"ca0eb9416282412fbf0dbfa76d3be175";
    }else if ([segue.identifier isEqualToString:@"Company"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"e0e31cb0dcbb4d51916c8c877e3bd572";
    }else if ([segue.identifier isEqualToString:@"SearchDistance"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"1";
    }else if ([segue.identifier isEqualToString:@"EatWhat"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"1";
    }
}

- (IBAction)shopCouponPress:(id)sender {
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *agree = [usernamepasswordKVPairs objectForKey:KEY_AGREEMENT];
    if ([@"0" isEqualToString:agree]) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ShopTabViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"ShopTabViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromBottom;
        UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        darkView.alpha = 0.7;
        darkView.tag = 9;
        darkView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:darkView];
    
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        IntroViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"IntroViewController"];
        controller.view.frame = CGRectMake(0.0f, 60.0f, 320.0f, 300.0f);
        controller.view.tag = 10;
        controller.delegate = self;
        self.introViewController = controller;
        [self.view addSubview:self.introViewController.view];
        [[controller.view layer] addAnimation:animation forKey:@"animation"];
    }
}

- (void) agreeMentPress:(int) type {
    if (type == 0) {
        [[self.view viewWithTag:9] removeFromSuperview];
        [[self.view viewWithTag:10] removeFromSuperview];
        NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
        if (!usernamepasswordKVPairs) {
            usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        }
        [usernamepasswordKVPairs setObject:@"0" forKey:KEY_AGREEMENT];
        [UserKeychain save:KEY_USERID_CCODE data:usernamepasswordKVPairs];
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ShopTabViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"ShopTabViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [[self.view viewWithTag:9] removeFromSuperview];
        [[self.view viewWithTag:10] removeFromSuperview];
    }
}

@end
