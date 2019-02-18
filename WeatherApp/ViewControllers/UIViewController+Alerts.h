//
//  UIViewController+Alerts.h
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Alerts)

-(void)showErrorMessage:(NSString *_Nullable)message withTitle:(NSString *_Nullable)title buttonTitle:(NSString *_Nullable)buttonTitle buttonPressed:(void (^)(void))buttonPressed;

-(void)notificationViewAlert;

@end

NS_ASSUME_NONNULL_END
