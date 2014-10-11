//
//  FNShyTabBar.h
//  ShyTableViewController
//
//  Created by Sihao Lu on 10/10/14.
//  Copyright (c) 2014 DJ.Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

// The pan gesture recognizer vertical movement threshold
// Only if the vertical movement of pan gesture is larger than this value the tab bar moves
#define FNShyTabBarPanThreshold 20

// The speed ratio between finger movement and tab bar movement,
// the larger this number, the "slower" the tab bar moves
#define FNShyTabBarSpeedRatio 1.5

typedef enum {
    FNShyTabBarHidden,
    FNShyTabBarTransitioning,
    FNShyTabBarShowing
} FNShyTabBarState;

@interface FNShyTabBar : UITabBar

// If the "shy" function is enabled. It behaves like a normal tab bar if set "NO"
@property (nonatomic) BOOL enabled;

// The state of this tab bar: hidden, transitioning or showing
@property (nonatomic, readonly) FNShyTabBarState state;

/**
 * This method sets the view used to track finger movement.
 * @param The view used to track finger movement.
 * @discussion A gesture recognizer will be created on the view.
 */
- (void)setTrackingView:(UIView *)trackingView;

@end

@interface UITabBarController (FNShyTabBar)

// A convenient accessor of shy tab bar.
@property (nonatomic, readonly) FNShyTabBar *shyTabBar;

@end