//
//  UIViewController+Alerts.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "UIViewController+Alerts.h"
#import "TSMessage.h"
#import "TSMessageView.h"

@implementation UIViewController (Alerts)


#pragma mark - Show Error Message

-(void)showErrorMessage:(NSString *_Nullable)message withTitle:(NSString *_Nullable)title buttonTitle:(NSString *_Nullable)buttonTitle buttonPressed:(void (^)(void))buttonPressed
{
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:title ?:@""
                                message:message ?:@""
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    if (message) {
        NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:message];
        
    }
    
    
    if (buttonTitle)
    {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            buttonPressed();
        }];
        [alert addAction:okAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)notificationViewAlert{
    [TSMessage showNotificationWithTitle:@"No Interner Connection"
                                subtitle:@"You Are in Offline Mode"
                                    type:TSMessageNotificationTypeError];
}


@end
