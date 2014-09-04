//
//  GMDMenuViewController.h
//  iOSChallengeMonsoon
//
//  Created by Rockstar. on 9/3/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMDMenuControl.h"

@interface GMDMenuViewController : UIViewController
@property (nonatomic) GMDMenuControl *batchControl;
@property (nonatomic) GMDMenuControl *flavorTypeControl;
@property (nonatomic) GMDMenuControl *spiceControl;
@property (nonatomic) GMDMenuControl *textureControl;
@property (nonatomic) GMDMenuControl *degreeControl;
@property (nonatomic) GMDMenuControl *mealControl;

@end
