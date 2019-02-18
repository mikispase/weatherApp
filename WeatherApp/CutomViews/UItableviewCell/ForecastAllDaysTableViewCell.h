//
//  ForecastAllDaysTableViewCell.h
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsolidatedWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForecastAllDaysTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *forecastImageView;
@property (strong, nonatomic) IBOutlet UILabel *weatherStateName;
@property (strong, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxLabel;
@property (strong, nonatomic) IBOutlet UIImageView *windImageView;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLabel;

-(void)setupCell:(ConsolidatedWeather *)model;
@end

NS_ASSUME_NONNULL_END
