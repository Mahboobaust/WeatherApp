//
//  WeatherViewController.m
//  WeatherAppWithBackgroundAppRefresh
//
//  Created by Mahboob on 9/8/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_txtCountryName becomeFirstResponder];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jsonOperation
{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.openweathermap.org/data/2.5/weather?q=%@",
                           _txtCountryName.text];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (!error && httpResp.statusCode == 200) {
                    //---print out the result obtained---
                    NSString *result =
                    [[NSString alloc] initWithBytes:[data bytes]
                                             length:[data length]
                                           encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", result);
                    
                    //---parse the JSON result---
                  NSString* jSonString=[self parseJSONData:data];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        _lblStatus.text=jSonString;
                        if (temperature>=25) {
                            _weatherImageView.image=[UIImage imageNamed:@"sunny.jpeg"];
                        }
                        else if (temperature>20&& temperature<25)
                        {
                            _weatherImageView.image=[UIImage imageNamed:@"winter.jpeg"];
                            
                        }
                        else
                        {
                            _weatherImageView.image=[UIImage imageNamed:@"winter.jpeg"];
                        }

                        
                    });
                    
                    
                } else {
                    NSLog(@"%@", error.description);
                    
                }
            }
      ] resume
     ];
    
}


- (NSString*)parseJSONData:(NSData *)data {
    NSError *error;
    NSDictionary *parsedJSONData =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:kNilOptions
                                      error:&error];
    NSDictionary *main = [parsedJSONData objectForKey:@"main"];
    
    //---temperature in Kelvin---
    NSString *temp = [main valueForKey:@"temp"];
    
    //---convert temperature to Celcius---
    temperature = [temp floatValue] - 273;
      //---get current time---
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *timeString = [formatter stringFromDate:date];
    
  
    
    return  [NSString stringWithFormat:
                           @"%f degrees Celsius, fetched at %@",
                           temperature, timeString];
}


- (IBAction)showWeather:(id)sender {
    [_txtCountryName resignFirstResponder];
    if (_txtCountryName.text==nil||[_txtCountryName.text isEqualToString:@""]) {
        _lblStatus.text=@"County Field cannot be empty";
    }
    else
     [self jsonOperation];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return NO;
}
@end
