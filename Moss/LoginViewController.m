//
//  LoginViewController.m
//  Moss
//
//  Created by Summer. on 16/1/22.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "LoginViewController.h"
#import "MKNetworkKit.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    //设置输入框缩进
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIView *leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _username.leftViewMode = UITextFieldViewModeAlways;
    [_username setLeftView:leftView1];
    _password.leftViewMode = UITextFieldViewModeAlways;
    [_password setLeftView:leftView2];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)usernameInput:(id)sender {
    UITextField *textField = sender;
    NSLog(@"username:%@",textField.text);
}

- (IBAction)passwordInput:(id)sender {
    UITextField *textField = sender;
    NSLog(@"password:%@",textField.text);
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == _username) {
        [_username resignFirstResponder];
        [_password becomeFirstResponder];
        return NO;
    }else{
        [_password resignFirstResponder];
        return YES;
    }
    
}




- (IBAction)login:(id)sender {
    NSString *username = [_username text];
    NSString *password = [_password text];
    [self loginWithUsername:username andPassword:password];
    
}


-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    
    NSString *path = [NSString stringWithFormat:@"member/login?username=%@&password=%@",username,password];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:@"localhost:8888/moss" customHeaderFields:nil];
    
    
    MKNetworkOperation *op = [engine operationWithPath:path];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        

        
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableContainers error:nil];
        if (dict == nil) {//login failure
            _username.text = @"Incorrect Username Or Password!";
            _password.text = nil;
            [_username becomeFirstResponder];
        }else{//login success
            
            
            //forward to main screan
            
//            // 初始化控制器
//            SecondViewController *second = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
//            
//            // 设置效果
//            [second setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            
            // 底部向上  UIModalTransitionStyleCoverVertical
            // 淡入     UIModalTransitionStyleCrossDissolve 
            // 翻转     UIModalTransitionStyleFlipHorizontal
            // 翻半页   UIModalTransitionStylePartialCurl
            
            // 跳转
            //[self presentViewController:@selector(@"MainIdentifier") animated:YES completion:nil];
            
            
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            
            for (NSString *key in [dict allKeys]) {
                if ([dict objectForKey:key] != [NSNull null]) {
                    [ud setObject:[dict objectForKey:key] forKey:key];
                    NSLog(@"%@--%@",key,[dict objectForKey:key]);
                }
            }
            
            [ud synchronize];
            
            
        }


        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [engine enqueueOperation:op];
    
    
    NSLog(@"%@--%@logining...",username,password);
}


@end
