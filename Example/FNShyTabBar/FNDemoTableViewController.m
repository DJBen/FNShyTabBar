//
//  FNDemoTableViewController.m
//  FNShyTabBar
//
//  Created by Sihao Lu on 10/11/14.
//  Copyright (c) 2014 DJBen. All rights reserved.
//

#import "FNDemoTableViewController.h"

@interface UIColor (DemoTableViewController)

- (UIColor *)colorByAddingAngleToHue:(CGFloat)angle;

@end

@implementation UIColor (DemoTableViewController)

- (UIColor *)colorByAddingAngleToHue:(CGFloat)angle {
    CGFloat hue, saturation, brightness, alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    hue += angle / 180 * M_PI;
    while (hue > 1) { hue -= 1; }
    while (hue < 0) { hue += 1; }
    return [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

@end

@interface FNDemoTableViewController () {
    UIColor *baseColor;
}

- (void)toggleHidden:(id)sender;

@end

@implementation FNDemoTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    baseColor = [UIColor colorWithRed:170 / 255.0 green:57 / 255.0 blue:57 / 255.0 alpha:1];

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hide" style:UIBarButtonItemStylePlain target:self action:@selector(toggleHidden:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.shyTabBar setTrackingView:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)toggleHidden:(id)sender {
	
	BOOL isHidden = self.tabBarController.shyTabBar.state == FNShyTabBarHidden;
	[self.tabBarController.shyTabBar setHidden:!isHidden animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell" forIndexPath:indexPath];
    cell.backgroundColor = [baseColor colorByAddingAngleToHue:3 * indexPath.row];
    return cell;
}

@end