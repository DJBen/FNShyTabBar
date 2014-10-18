//
//  FNShyTabBar.m
//  ShyTableViewController
//
//  Created by Sihao Lu on 10/10/14.
//  Copyright (c) 2014 DJ.Ben. All rights reserved.
//

#import "FNShyTabBar.h"

@interface FNShyTabBar () <UIGestureRecognizerDelegate> {
    CGFloat tabBarElementsYOffset;
    CGFloat currentOffset;
    CGFloat previousOffset;
}

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, weak) UIView *trackingView;

@end

@implementation FNShyTabBar

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup {
    // Set default config
    _enabled = YES;
    _state = FNShyTabBarShowing;
    
    // Create gesture recognizers
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    _panRecognizer.delegate = self;
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _tapRecognizer.delegate = self;
    _tapRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:_tapRecognizer];
}

- (void)setOffset:(CGFloat)offset {
	offset = -offset;
	previousOffset = currentOffset;
	currentOffset = offset;
	CGFloat difference = currentOffset - previousOffset;
	if (currentOffset >= -FNShyTabBarPanThreshold && currentOffset < FNShyTabBarPanThreshold) return;
	for (UIView *view in self.subviews) {
		view.frame = CGRectMake(view.frame.origin.x,
								MAX(0, MIN(view.frame.origin.y + difference, self.frame.size.height)),
								view.frame.size.width,
								view.frame.size.height);
		tabBarElementsYOffset = view.frame.origin.y;
	}
	if (tabBarElementsYOffset >= self.frame.size.height) {
		_state = FNShyTabBarHidden;
	} else if (tabBarElementsYOffset <= 0) {
		_state = FNShyTabBarShowing;
	} else {
		_state = FNShyTabBarTransitioning;
	}
}

- (void)recoilWithVerticalVelocity:(CGFloat)yVelocity {
    yVelocity = -yVelocity;
    if (yVelocity < 0) {
        // Going up, showing
        [UIView animateWithDuration:tabBarElementsYOffset / -yVelocity * 0.4 animations:^{
            for (UIView *view in self.subviews) {
                view.frame = CGRectMake(view.frame.origin.x,
                                        0,
                                        view.frame.size.width,
                                        view.frame.size.height);
                tabBarElementsYOffset = view.frame.origin.y;
            }
        } completion:^(BOOL finished) {
            _state = FNShyTabBarShowing;
        }];
    } else {
		NSTimeInterval duration = (self.frame.size.height - tabBarElementsYOffset) / yVelocity * 0.4;
        [UIView animateWithDuration:duration animations:^{
            for (UIView *view in self.subviews) {
                view.frame = CGRectMake(view.frame.origin.x,
                                        self.frame.size.height,
                                        view.frame.size.width,
                                        view.frame.size.height);
                tabBarElementsYOffset = view.frame.origin.y;
            }
        } completion:^(BOOL finished) {
            _state = FNShyTabBarHidden;
        }];
    }
    
}

#pragma mark - Getter/Setter
- (void)setTrackingView:(UIView *)trackingView {
    if (trackingView == _trackingView) {
        return;
    }
    
    _trackingView = trackingView;
    [self.panRecognizer.view removeGestureRecognizer:self.panRecognizer];
    [_trackingView addGestureRecognizer:self.panRecognizer];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (!enabled) {
        [self recoilWithVerticalVelocity:300];
    }
}

#pragma mark - 
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
	
	if ((self.state == FNShyTabBarHidden) == hidden) {
		return;
	}
	
	if (animated) {
		CGFloat defaultVelocity = 200;
		CGFloat velocity = hidden ? -defaultVelocity : defaultVelocity;
		
		[self recoilWithVerticalVelocity:velocity];
	}
	else {
		CGFloat offset = hidden ? -300 : 300;	// tired to calculate offset diff
		[self setOffset:offset];
	}
}

#pragma mark - Gestures
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [gestureRecognizer translationInView:self.trackingView];
            [self setOffset:translation.y / FNShyTabBarSpeedRatio];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            CGPoint velocity = [gestureRecognizer velocityInView:self.trackingView];
            [self recoilWithVerticalVelocity:velocity.y];
            break;
        }
        default:
            break;
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self recoilWithVerticalVelocity:300];
}

@end

#pragma mark - Support

@implementation UITabBarController (FNShyTabbar)

- (FNShyTabBar *)shyTabBar {
    UITabBar *tabBar = self.tabBar;
    if ([self.tabBar isKindOfClass:[FNShyTabBar class]]) {
        return (FNShyTabBar *)tabBar;
    }
    return nil;
}

@end
