//
//  LoginViewController.h
//  Moss
//
//  Created by Summer. on 16/1/22.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)usernameInput:(id)sender;
- (IBAction)passwordInput:(id)sender;
- (IBAction)login:(id)sender;

@end
