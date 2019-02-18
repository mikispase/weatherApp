//
//  ForecastAllDaysTableViewCell.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "ForecastAllDaysTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kDEGREESIGN @"\u00B0"

@implementation ForecastAllDaysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(ConsolidatedWeather *)model
{
 
    self.dateLabel.text = [self convertDateString:model.applicableDate];
    self.weatherStateName.text = model.weatherStateName;
    self.minLabel.text =   [NSString stringWithFormat:@"Min %.0f%@",model.minTemp,kDEGREESIGN] ;
    self.maxLabel.text =   [NSString stringWithFormat:@"Max %.0f%@",model.maxTemp,kDEGREESIGN] ;
    
    //  https://www.metaweather.com/static/img/weather/png/64/c.png
    NSString *strUrl = [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/64/%@.png",model.weatherStateAbbr];
    [self.forecastImageView sd_setImageWithURL:[NSURL URLWithString:strUrl]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.windImageView.image = [self rotate:self.windImageView.image radians:model.windDirection];
    
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%.0fmph",model.windSpeed] ;
}


-(NSString *)convertDateString:(NSString*)strDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    [dateFormatter setDateFormat:@"E, d MMM"];
    return [dateFormatter stringFromDate:date];
    
}


- (UIImage *)rotate:(UIImage *)image radians:(float)rads
{
    float newSide = MAX([image size].width, [image size].height);
    CGSize size =  CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
//    CGContextTranslateCTM(ctx, [image size].width/2, [image size].height/2);
    
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}

@end
