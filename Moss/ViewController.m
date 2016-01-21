//
//  ViewController.m
//  Moss
//
//  Created by Summer. on 16/1/21.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self login];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)userLoginOrNot {
    return YES;
}

- (BOOL)login {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"summer" forKey:@"username"];
    [ud setObject:@"gmcfuer" forKey:@"password"];
    [ud synchronize];
    
    
    return YES;
}

@end
