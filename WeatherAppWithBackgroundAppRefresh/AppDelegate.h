//
//  AppDelegate.h
//  WeatherAppWithBackgroundAppRefresh
//
//  Created by Mahboob on 9/8/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    WeatherViewController *weatherViewController;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *temperature;
@end
