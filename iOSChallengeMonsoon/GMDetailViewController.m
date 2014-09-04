//
//  GMDetailViewController.m
//  iOSChallengeMonsoon
//
//  Created by Rockstar. on 9/3/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#define labelW 240.0f
#define labelH 31.0f
#define leftx self.view.center.x - 25.0f
#define leftmenux self.view.center.x / 2.0f - 20.0f

#import "GMDetailViewController.h"

@interface GMDetailViewController ()
@property (nonatomic) UILabel *batchLabel;
@property (nonatomic) UILabel *typeLabel;
@property (nonatomic) UILabel *spicyLabel;
@property (nonatomic) UILabel *textureLabel;
@property (nonatomic) UILabel *degreeLabel;
@property (nonatomic) UILabel *mealTypeLabel;
@end

@implementation GMDetailViewController
@synthesize batchSize, flavorType, flavorSpicy, flavorTexture, flavorDegree, mealType;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MON_Rectangle-5"]];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    
    //-------------
    //Set Menu view and selected options labels
    //-------------
    [self setMenuView];
    [self setLabels];
}

- (void)setLabels {
    //---------------
    //Set global settings rather than having to recode same text color, font and alignment
    //Text color obtained from PSD to match icons
    //Font listed in PSD as SourceSansPro
    //---------------
    UIColor *textColor = [UIColor colorWithRed:0.18 green:0.20 blue:0.25 alpha:1.00];
    UIFont *textFont = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0f];
    NSTextAlignment textAlignment = NSTextAlignmentLeft;
    
    //---------------
    //Detail view labels set text to approrpiate string
    //---------------
    
    //Batch label
    self.batchLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 125.0f, labelW, labelH)];
    self.batchLabel.textColor = textColor;
    self.batchLabel.font = textFont;
    self.batchLabel.textAlignment = textAlignment;
    self.batchLabel.text = self.batchSize;
    [self.view addSubview:self.batchLabel];
    
    //Flavor Type label
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 145.0f, labelW, labelH)];
    self.typeLabel.textColor = textColor;
    self.typeLabel.font = textFont;
    self.typeLabel.textAlignment = textAlignment;
    self.typeLabel.text = self.flavorType;
    [self.view addSubview:self.typeLabel];
    
    //Flavor Spicy label
    self.spicyLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 165.0f, labelW, labelH)];
    self.spicyLabel.textColor = textColor;
    self.spicyLabel.font = textFont;
    self.spicyLabel.textAlignment = textAlignment;
    self.spicyLabel.text = self.flavorSpicy;
    [self.view addSubview:self.spicyLabel];
    
    //Texture label
    self.textureLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 185.0f, labelW, labelH)];
    self.textureLabel.textColor = textColor;
    self.textureLabel.font = textFont;
    self.textureLabel.textAlignment = textAlignment;
    self.textureLabel.text = self.flavorTexture;
    [self.view addSubview:self.textureLabel];
    
    //Degree label
    self.degreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 205.0f, labelW, labelH)];
    self.degreeLabel.textColor = textColor;
    self.degreeLabel.font = textFont;
    self.degreeLabel.textAlignment = textAlignment;
    self.degreeLabel.text = self.flavorDegree;
    [self.view addSubview:self.degreeLabel];
    
    //Meal label
    self.mealTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx, 225.0f, labelW, labelH)];
    self.mealTypeLabel.textColor = textColor;
    self.mealTypeLabel.font = textFont;
    self.mealTypeLabel.textAlignment = textAlignment;
    self.mealTypeLabel.text = self.mealType;
    [self.view addSubview:self.mealTypeLabel];
    
}

- (void)setMenuView {
    //---------------
    //Init menu view - used dummy xib for positioning
    //---------------
    UIImageView *menuView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 280.0f, 250.0f)];
    menuView.backgroundColor = [UIColor lightGrayColor];
    menuView.alpha = 0.5f;
    menuView.layer.cornerRadius = 3.0f;
    menuView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0f, 0.0f, 280.0f, 250.0f)].CGPath;
    menuView.layer.masksToBounds = NO;
    menuView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    menuView.layer.shadowOpacity = 1.0f;
    menuView.layer.shadowRadius = 3.0f;
    menuView.layer.shouldRasterize = YES;
    [self.view addSubview:menuView];
    
    //---------------
    //Menu Display title
    //---------------
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmenux, 85.0f, labelW, labelH)];
    menuLabel.textColor = [UIColor colorWithRed:1.00 green:0.40 blue:0.40 alpha:1.00];
    menuLabel.font = [UIFont fontWithName:@"SourceSansPro-Bold" size:20.0f];
    menuLabel.textAlignment = NSTextAlignmentLeft;
    menuLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    menuLabel.shadowColor = [UIColor blackColor];
    [menuLabel setText:@"TODAY'S SELECTION:"];
    [self.view addSubview:menuLabel];
    
    
    
    
    
}



@end
