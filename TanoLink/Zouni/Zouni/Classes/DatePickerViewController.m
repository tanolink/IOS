//
//  DatePickerViewController.m
//  JuranClient
//
//  Created by huchu on 14-10-15.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

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
    // Do any additional setup after loading the view.
    
    CGRect frame = self.pickerView.frame;
    [self.pickerView removeFromSuperview];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:frame];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.containerView addSubview:self.datePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
