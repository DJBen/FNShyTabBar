# FNShyTabBar

[![CI Status](http://img.shields.io/travis/DJBen/FNShyTabBar.svg?style=flat)](https://travis-ci.org/DJBen/FNShyTabBar)
[![Version](https://img.shields.io/cocoapods/v/FNShyTabBar.svg?style=flat)](http://cocoadocs.org/docsets/FNShyTabBar)
[![License](https://img.shields.io/cocoapods/l/FNShyTabBar.svg?style=flat)](http://cocoadocs.org/docsets/FNShyTabBar)
[![Platform](https://img.shields.io/cocoapods/p/FNShyTabBar.svg?style=flat)](http://cocoadocs.org/docsets/FNShyTabBar)

![Example GIF](https://raw.githubusercontent.com/DJBen/FNShyTabBar/master/Example/FNShyTabBarDemo.gif)

## Usage

Simple and sound.

1. In storyboard, go to your `UITabBarController` and change the Tab Bar's class into `FNShyTabBar`.
2. In your view controller's `-viewDidLoad:`, insert the line as followed and you are ready to go!
        `[self.tabBarController.shyTabBar setTrackingView:<#Your view used to track fingers, can be tableView, scrollView, etc#>];`

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 7.0

## Installation

FNShyTabBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "FNShyTabBar"

## Author

DJBen, lsh32768@gmail.com

## License

[DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE](http://www.wtfpl.net)

