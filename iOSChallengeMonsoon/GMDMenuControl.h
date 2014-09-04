//
//  GMDMenuControl.h
//  iOSChallengeMonsoon
//
//  Created by Rockstar. on 9/3/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDMenuControl : UIControl {
    NSArray *menuOptions;
    NSString *selection;
}

@property (nonatomic) NSArray *menuOptions;
@property (nonatomic) NSString *selection;

- (void)randomSelection;

@end
