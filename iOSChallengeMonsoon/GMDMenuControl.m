//
//  GMDMenuControl.m
//  iOSChallengeMonsoon
//
//  Created by Rockstar. on 9/3/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

//http://stackoverflow.com/a/5725185/1397904
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0) //


#import "GMDMenuControl.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

/*
 A set of six custom UIControls (or one Custom UIControl subclass instantiated six times) that when pressed cycle between a limited number of choices.
 
 For each control the number of choices is demonstrated by the number of arcs around the circle. They function the same way as segmented controls.

 */

@interface GMDMenuControl ()
@property (nonatomic) UILabel *menuLabel;
@property (nonatomic, readwrite) int press;
@property (nonatomic) UIImageView *arcView;
@end

@implementation GMDMenuControl

@synthesize menuOptions, selection, menuLabel, arcView, press;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Frame background color, set to clear to hide background color
        [self setBackgroundColor:[UIColor clearColor]];
        [self addTarget:self action:@selector(pressedMenuOption) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

#pragma mark - Menu Circle
- (void)drawRect:(CGRect)rect
{
    
    //--------------
    //Menu Circle
    //--------------
    float circleH = 139.0f;
    float reducedCircle = 125.1f; //Reduce view
    
    UIImageView *circleView = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 7.0f, reducedCircle, reducedCircle)];
    circleView.layer.cornerRadius = reducedCircle / 2;
    circleView.alpha = 0.2f;
    circleView.backgroundColor = [UIColor blackColor];
    [self addSubview:circleView];
    
    //--------------
    //Menu Label
    //Frame y = (circleH / 2) - (labelH / 2)
    //Label height obtained from PSD
    //--------------
    float labelH = 33.0f;
    float y = (circleH / 2) - (labelH / 2);
    
    //---------------
    //Set control label
    //PSD showd font as SourceSansPro
    //---------------
    self.menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.0f, y, reducedCircle, labelH)];
    self.menuLabel.textAlignment = NSTextAlignmentCenter;
    self.menuLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0f];
    self.menuLabel.textColor = [UIColor whiteColor];
    self.menuLabel.text = menuOptions[0];
    self.selection = menuOptions[0];
    [self addSubview:menuLabel];
    
    [self setArc];
    
}

#pragma mark - Arcs
- (void)setArc {
    //------------
    //Begin draw of arc
    //Line witdth should be half the distance between circle and path
    //Never used CG before. Used available resources to combine workable answer.
    //------------
    float bounds = self.bounds.size.width; //139.0f
    float lineW = 1.0f;
    float arcRadius = (bounds / 2) - 3; //66.5
    
    //http://stackoverflow.com/questions/3041776/iphone-cgcontext-drawing-two-lines-with-two-different-colors
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, lineW);
    CGPoint arcCenter = CGPointMake(bounds / 2, bounds / 2);//Set arc center by dividing frame w / 2 and frame h / 2
    CGFloat arcGap = 12.0f;
    CGFloat arcSegmet;
    
    //--------------
    //Find set segment position
    //--------------
//    NSLog(@"%i", menuOptions.count);
    if (menuOptions.count == 2) {
        arcSegmet = 168.0f;
    }
    else if (menuOptions.count == 3) {
        arcSegmet = 108.0f;
    }
    else if (menuOptions.count == 4) {
        arcSegmet = 78.0f;
    }
    else {
        arcSegmet = 60.0f;
    }
    
    //http://stackoverflow.com/a/18384709/1397904
    CGFloat beginAngle = 84.0f;
    
    for (int i = 0; i < menuOptions.count; i++) {
        if (i == 0) {
            CGContextSetStrokeColorWithColor(contextRef, [[self class] lightarc].CGColor);
        }
        else {
            CGContextSetStrokeColorWithColor(contextRef, [[self class] darkarc].CGColor);
        }
        //--------------
        //Create end angle, sigle angle changes depending on menuOptions.count, added the start angle, the arc segment and the arc gap
        //At first added just the start angle and the segment but the arcs were off, after adding several numbers, the closest approximation to design was adding the segment gap. Added float containing arc gap value.
        //--------------
        CGFloat endAngle = beginAngle + arcSegmet + arcGap;
        
        //------------------
        //First arc
        //------------------
        CGContextAddArc(contextRef, arcCenter.x, arcCenter.y, arcRadius, DEGREES_TO_RADIANS(beginAngle + arcGap), DEGREES_TO_RADIANS(endAngle), 0);
        CGContextStrokePath(contextRef);
        
        //------------------
        //Remaining arcs - reset angle to begin arcs at the end of end angle
        //------------------
        beginAngle = endAngle;
        CGContextAddArc(contextRef, arcCenter.x, arcCenter.y, arcRadius, DEGREES_TO_RADIANS(beginAngle), DEGREES_TO_RADIANS(endAngle), 0);
        CGContextStrokePath(contextRef);
    }
    
    //http://stackoverflow.com/questions/8517203/uigraphicsbeginimagecontext-how-to-set-position
    
    //------------
    //Create image view for rotation
    //imageWithCGImage requires a CGImageRef, CGImageRef requires CGImage
    //Quartz2D guide only has CGBitmapContextCreateImage to create image with context
    //------------
    self.arcView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
    CGImageRef CGImage = CGBitmapContextCreateImage(contextRef);
    UIImage *pathIamge = [UIImage imageWithCGImage:CGImage];
    [self.arcView setImage:pathIamge];
    [self addSubview:self.arcView];
}


#pragma mark - Actions
- (void)pressedMenuOption {
    //----------
    //Change text label when pressed
    //----------
    press++;
    if (press >= menuOptions.count) {
        press = 0;
    }
    self.menuLabel.text = menuOptions[press];
    self.selection = menuOptions[press];
    
    NSLog(@"%i", press);
    
    //---------------
    //Arc view animation
    //---------------
//    CABasicAnimation *fullRoation;
//    fullRoation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    fullRoation.fromValue = [NSNumber numberWithFloat:0.0f];
//    fullRoation.toValue = [NSNumber numberWithFloat:6];
//    fullRoation.duration = 1.0;
//    fullRoation.repeatCount = 1;
//    
//    [self.arcView.layer setValue:fullRoation forKey:fullRoation.keyPath];
//    [self.arcView.layer addAnimation:fullRoation forKey:@"360"];
    
    //-------------------
    //New Arc animation - Previous animation just rotates arcs 360 degrees.
    //-----------------
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationRepeatCount:1];
    self.arcView.transform = CGAffineTransformRotate(self.arcView.transform, DEGREES_TO_RADIANS(360/menuOptions.count) * press);
    [UIView commitAnimations];
}

- (void)randomSelection {
    //-----------
    //Set random selection
    //Set animation when shuffle button pressed
    //-----------
    int random = arc4random() % menuOptions.count;
    self.press = random;
    [self pressedMenuOption];
}

#pragma mark - Arc colors
//---------------
//Set arc colors
//Colors obtained from PSD and converted to UIColor
//--------------
+ (UIColor *)darkarc {
    return [UIColor colorWithRed:0.40f green:0.00f blue:0.20f alpha:1.0f];
}

+ (UIColor *)lightarc {
    return [UIColor colorWithRed:1.00 green:0.40 blue:0.40 alpha:1.00];
}


@end
