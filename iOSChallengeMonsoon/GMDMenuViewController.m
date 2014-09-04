//
//  GMDMenuViewController.m
//  iOSChallengeMonsoon
//
//  Created by Rockstar. on 9/3/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "GMDMenuViewController.h"
#import "GMDMenuControl.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GMDetailViewController.h"

@interface GMDMenuViewController ()
@property (nonatomic) UIToolbar *bottomMenu;

- (void)didPressGo:(id)sender;
- (void)didPressShuffle:(id)sender;

@end

@implementation GMDMenuViewController {
    //Navbar Buttons
    UIBarButtonItem *menuBarButton;
    UIBarButtonItem *calendarBarButton;
    UIBarButtonItem *compassBarButton;
    UIBarButtonItem *searchBarButton;
    
    //Toolbar Buttons
    UIButton *goButton;
    UIButton *shuffleButton;
    
    SystemSoundID soundEffect;
}

#pragma mark - viwDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MON_Rectangle-5"]];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    
    
    //--------------
    //Set Navigation bar, Toolbar, Controls and Audio
    //--------------
    [self setNavbar];
    [self setToolBar];
    [self setMenu];
    [self setAudio];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Nav Bar & Nav Bar Items
- (void)setNavbar {
    //---------------
    //Nav bar implementation.
    //Changed tint color to color provided in PSD to match icon color.
    //---------------
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.18 green:0.20 blue:0.25 alpha:1.00];
    
    //---------------
    //Init nav bar buttons.
    //"These buttons do not need to go anywhere but should have a consistent tap state"
    //---------------
    menuBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_menuIcon"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    calendarBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_calendarIcon"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:nil];
    
    compassBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_compassIcon"]
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:nil];
    
    searchBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_searchIcon"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:nil];
    //--------------
    // Set up mutable array to hold left side buttons
    // could have used toolbar instead navigationBar
    //--------------
    NSMutableArray *leftMenuButtons = [[NSMutableArray alloc] initWithObjects:searchBarButton, calendarBarButton, compassBarButton, nil];
    self.navigationItem.leftBarButtonItems = leftMenuButtons;
    
    //----------------
    //Right bar button
    //----------------
    self.navigationItem.rightBarButtonItem = menuBarButton;
    
}

#pragma mark - ToolBar
- (void)setToolBar {
    //----------------
    //Init ToolBar. Removed black top border by setting blank shadow image
    //----------------
    self.bottomMenu = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height - 80.0f, 320.0f, 80.0f)];
    [self.bottomMenu setTranslucent:YES];
    [self.bottomMenu setBarStyle:UIBarStyleDefault];
    [self.bottomMenu setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.bottomMenu setShadowImage:[UIImage new] forToolbarPosition:UIToolbarPositionAny]; //removed black top border
    self.bottomMenu.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bottomMenu];
    
    //----------------
    //GO Button - added button to ToolBar view
    //Image is 100 x 100 @2x, set size to 50% of image size
    // x and y positions optained by creating dummy xib and positioning accordingly
    //----------------
    goButton = [[UIButton alloc] initWithFrame:CGRectMake(108.0f, 13.0f, 50.0f, 50.0f)];
    [goButton setBackgroundImage:[UIImage imageNamed:@"MON_Ellipse-13-copy"] forState:UIControlStateNormal];
    [goButton setImage:[UIImage imageNamed:@"MON_GO"] forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(didPressGo:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomMenu addSubview:goButton];
    
    //----------------
    //Shuffle Button - added button to ToolBar view
    //----------------
    shuffleButton = [[UIButton alloc] initWithFrame:CGRectMake(166.0f, 13.0f, 50.0f, 50.0f)];
    [shuffleButton setBackgroundImage:[UIImage imageNamed:@"MON_Ellipse-13-copy"] forState:UIControlStateNormal];
    [shuffleButton setImage:[UIImage imageNamed:@"MON_shuffleIcon"] forState:UIControlStateNormal];
    [shuffleButton addTarget:self action:@selector(didPressShuffle:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomMenu addSubview:shuffleButton];
}

#pragma mark - Menu
- (void)setMenu {
    //-----------------
    //Data from plist
    //-----------------
    NSDictionary *menuOptionsDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"menu" ofType:@"plist"]];
    
    //-------------
    //Control positions obtained by creating dummy xib and positioning accordingly 6 squares 139 x 139
    //-------------
    float leftx = 13.0f;
    float rightx = 168.0f;
    
    float topy = 68.0f;
    float middley = 215.0f;
    float bottomy = 362.0f;
    
    float contolW = 139.0f;
    float controlH = 139.0f;
    
    //----------------
    // Set menu label with plist. Faster solution than creating arrays with list. Also easier to maintain.
    //----------------
    self.batchControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(leftx, topy, contolW, controlH)];
    self.batchControl.menuOptions = menuOptionsDictionary[@"BatchSize"];
    [self.view addSubview:self.batchControl];
    
    self.flavorTypeControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(rightx, topy, contolW, controlH)];
    self.flavorTypeControl.menuOptions = menuOptionsDictionary[@"FlavorType"];
    [self.view addSubview:self.flavorTypeControl];
    
    self.spiceControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(leftx, middley, contolW, controlH)];
    self.spiceControl.menuOptions = menuOptionsDictionary[@"SpiceLevel"];
    [self.view addSubview:self.spiceControl];
    
    self.textureControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(rightx, middley, contolW, controlH)];
    self.textureControl.menuOptions = menuOptionsDictionary[@"Texture"];
    [self.view addSubview:self.textureControl];
    
    self.degreeControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(leftx, bottomy, contolW, controlH)];
    self.degreeControl.menuOptions = menuOptionsDictionary[@"Degree"];
    [self.view addSubview:self.degreeControl];
    
    self.mealControl = [[GMDMenuControl alloc] initWithFrame:CGRectMake(rightx, bottomy, contolW, controlH)];
    self.mealControl.menuOptions = menuOptionsDictionary[@"Meal"];
    [self.view addSubview:self.mealControl];
}

#pragma mark - Audio
- (void)setAudio {
    //---------------
    //Set audio, mp3 obtained from another non commercial app.
    //Requiers #import <AudioToolbox/AudioToolbox.h>
    //---------------
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"motion" ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID(CFBridgingRetain(soundURL), &soundEffect);
}

#pragma mark - Button Actions

- (void)didPressGo:(id)sender {
    //-------------
    //Pass data to detailed view controller
    //-------------
    GMDetailViewController *detailViewController = [[GMDetailViewController alloc] init];
    detailViewController.batchSize = self.batchControl.selection;
    detailViewController.flavorType = self.flavorTypeControl.selection;
    detailViewController.flavorSpicy = self.spiceControl.selection;
    detailViewController.flavorTexture = self.textureControl.selection;
    detailViewController.flavorDegree = self.degreeControl.selection;
    detailViewController.mealType = self.mealControl.selection;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didPressShuffle:(id)sender {
    //--------------
    //Random selection for all menu controls
    //Plays audio when button pressed
    //--------------
    [self.batchControl randomSelection];
    [self.flavorTypeControl randomSelection];
    [self.spiceControl randomSelection];
    [self.textureControl randomSelection];
    [self.degreeControl randomSelection];
    [self.mealControl randomSelection];
    
    AudioServicesPlaySystemSound(soundEffect);
}


@end
