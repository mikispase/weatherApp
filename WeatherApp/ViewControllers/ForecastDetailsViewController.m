//
//  ForecastDetailsViewController.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "ForecastDetailsViewController.h"
#import "ConsolidatedWeather.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ForecastDetailsViewController () <DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,TSMessageViewProtocol>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *weaherStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxTemLabel;
@property (strong, nonatomic) IBOutlet UILabel *minTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityPercentLabel;
@property (strong, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (strong, nonatomic) IBOutlet UILabel *visibilityValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *pleasureLabel;
@property (strong, nonatomic) IBOutlet UILabel *pleasureValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UIImageView *forecastImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *weatherPerHoursArray;

@end

@implementation ForecastDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDatasource];
}

-(void)setupDatasource
{
    self.weatherPerHoursArray = [NSMutableArray array];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    // Check if connected to internet
    if ([ServerInvoker connectedToInternet])
    {
        [SVProgressHUD show];
        [ServerInvoker getDateForecast:@{@"date" : self.strDate,@"woeid" : self.woeid}
                          blockSuccess:^(NSArray *forecast)
         {
             
             NSLog(@"%@",[ServerInvoker preetyJsonFormater:forecast]);
             
             for (NSDictionary *dic in forecast) {
                 ConsolidatedWeather *obj = [ConsolidatedWeather modelObjectWithDictionary:dic];
                 [self.weatherPerHoursArray addObject:obj];
             }
             
             [self setupForecastDay];
             
             NSData *keyArhiver = [NSKeyedArchiver archivedDataWithRootObject:self.weatherPerHoursArray requiringSecureCoding:NO error:nil];
             
             [currentDefaults setObject:keyArhiver forKey:[self.woeid stringByAppendingString:self.strDate]];
             
             [SVProgressHUD dismiss];
             
             [self.collectionView reloadData];
             
         } errorCallback:^(NSError * _Nonnull errorMessage,
                           NSInteger statusCode,
                           NSString * _Nonnull errorMsg)
         {
             [SVProgressHUD dismiss];
             [self showErrorMessage:[errorMessage.userInfo valueForKey:NSLocalizedDescriptionKey] withTitle:@"" buttonTitle:@"" buttonPressed:^{}];
             
         }];
    }
    else // Offline state
    {
        [TSMessage setDefaultViewController:self];
        [TSMessage setDelegate:self];
        [self.navigationController.navigationBar setTranslucent:YES];
        [self notificationViewAlert];
        
        
        NSData *data = [currentDefaults objectForKey:[self.woeid stringByAppendingString:self.strDate]];
        self.weatherPerHoursArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.collectionView reloadData];
        [self setupForecastDay];
        
        if (self.weatherPerHoursArray.count == 0) {
            self.tableView.emptyDataSetSource = self;
            self.tableView.emptyDataSetDelegate = self;
            //  [self.collectionView reloadData];
            self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
            self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        }
    }
}


#pragma mark - CollectionView Delagtes & Datasorce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.weatherPerHoursArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self setupCell:collectionView forIndex:indexPath];
}

-(UICollectionViewCell *)setupCell:(UICollectionView *)view forIndex:(NSIndexPath *)path
{
    static NSString *identifier = @"Cell";
    ConsolidatedWeather *model = self.weatherPerHoursArray[path.row];
    
    UICollectionViewCell *cell = [view dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:path];
    
    UIImageView *forecastImageView = (UIImageView *)[cell viewWithTag:100];
    forecastImageView.layer.cornerRadius = 15;
    forecastImageView.layer.masksToBounds = true;
    forecastImageView.layer.borderWidth = 0;
    
    NSString *strUrl = [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/64/%@.png",model.weatherStateAbbr];
    
    [forecastImageView sd_setImageWithURL:[NSURL URLWithString:strUrl]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UILabel *min = (UILabel *)[cell viewWithTag:101];
    min.text = [NSString stringWithFormat:@"Min %.0f",model.minTemp] ;
    UILabel *max = (UILabel *)[cell viewWithTag:102];
    max.text = [NSString stringWithFormat:@"Max %.0f",model.maxTemp] ;
    
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = true;
    cell.layer.borderWidth = 0.3;
    cell.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:103];
    dateLabel.text = [self convertDateString:model.created];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130,130);
}

#pragma mark - Setup Tempmerature info

-(void)setupForecastDay{
    ConsolidatedWeather *model = [self.weatherPerHoursArray firstObject];
    
    NSString *strUrl = [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/64/%@.png",model.weatherStateAbbr];
    
    [self.forecastImageView sd_setImageWithURL:[NSURL URLWithString:strUrl]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.tempLabel.text = [NSString stringWithFormat:@"%.0f%@",model.theTemp,@"\u00B0"];
    self.weaherStateLabel.text = model.weatherStateName;
    self.maxTemLabel.text = [NSString stringWithFormat:@"Max %.0f%@",model.maxTemp ,@"\u00B0"];
    self.minTempLabel.text = [NSString stringWithFormat:@"Min %.0f%@",model.minTemp,@"\u00B0"];
    self.humidityLabel.text = @"Humidity";
    self.humidityPercentLabel.text = [NSString stringWithFormat:@"%.0f%%",model.humidity];
    self.visibilityLabel.text = @"Visibility";
    self.visibilityValueLabel.text = [NSString stringWithFormat:@"%.0f miles",model.visibility];
    self.pleasureLabel.text = @"Pressure";
    self.pleasureValueLabel.text = [NSString stringWithFormat:@"%.0fmb",model.airPressure];
    self.title = model.applicableDate;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    // The attributed string for the title of the empty state:
    return   [[NSAttributedString alloc] initWithString:@"No preview available"];;
}

// Helper formating funcion
-(NSString *)convertDateString:(NSString*)strDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
    
}



@end
