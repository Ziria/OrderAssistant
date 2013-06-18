//
//  MainViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "IntroViewController.h"

@interface MainViewController : ViewController<UIApplicationDelegate,PopoverViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate, UITabBarControllerDelegate, IntroViewDelegate> {
    UIButton *topButton;
    
    UIButton *bottomButton;
    UIButton *arrowButton;
    BOOL expanding;
    UILabel *menuChoiceLbl;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;
    
    int shopCode;
    UIButton *recommendButton;
    UIButton *friendsButton;
    UIButton *familyButton;
    UIButton *lovaButton;
    UIButton *busniessButton;
    UIButton *companyButton;
    
    UIButton *couponButton;
    UIButton *exitButton;
    UIButton *searchButton;
    UIButton *eatWhatButton;
    UIButton *changePoints;
    NSString *deviceTokenNum;
    
}
@property (nonatomic) int shopCode;
@property (nonatomic, retain) IBOutlet UIButton *friendsButton;
@property (nonatomic, retain) IBOutlet UIButton *recommendButton;
@property (nonatomic, retain) IBOutlet UIButton *familyButton;
@property (nonatomic, retain) IBOutlet UIButton *lovaButton;
@property (nonatomic, retain) IBOutlet UIButton *busniessButton;
@property (nonatomic, retain) IBOutlet UIButton *companyButton;
@property (nonatomic, retain) IBOutlet UILabel *menuChoiceLbl;
@property (nonatomic, retain) IBOutlet UIButton *topButton;
@property (nonatomic, retain) IBOutlet UIButton *bottomButton;
@property (nonatomic, retain) IBOutlet UIButton *arrowButton;
@property (nonatomic) BOOL expanding;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D curLocation;
@property (nonatomic, retain) IntroViewController *introViewController;

@property (nonatomic, retain) IBOutlet UIButton *couponButton;
@property (nonatomic, retain) IBOutlet UIButton *exitButton;
@property (nonatomic, retain) IBOutlet UIButton *searchButton;
@property (nonatomic, retain) IBOutlet UIButton *eatWhatButton;
@property (nonatomic, retain) IBOutlet UIButton *changePoints;
@property (nonatomic, retain) NSString *deviceTokenNum;

- (IBAction)menuButton:(id)sender;
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender;
- (IBAction)exitBtnPress:(id)sender;

- (IBAction)shopCouponPress:(id)sender;


//- (IBAction)showRecommendShopList:(id)sender;

@end
