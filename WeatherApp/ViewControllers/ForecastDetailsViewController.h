//
//  ForecastDetailsViewController.h
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForecastDetailsViewController : UIViewController
@property (nonatomic,strong) NSString *strDate;
@property (nonnull,strong) NSString *woeid;

@end

NS_ASSUME_NONNULL_END
