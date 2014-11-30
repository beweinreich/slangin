//
//  ViewController.m
//  SlanginKeyboard
//
//  Created by bw on 11/23/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-20, 44)];
    [self.view addSubview:field];
    [field becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
