//
//  WeatherViewController.h
//  WeatherAppWithBackgroundAppRefresh
//
//  Created by Mahboob on 9/8/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController
{
    
    float temperature;
}
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (strong, nonatomic) IBOutlet UITextField *txtCountryName;
- (IBAction)showWeather:(id)sender;

@end
