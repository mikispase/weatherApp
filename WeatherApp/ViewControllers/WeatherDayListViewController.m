//
//  WeatherDayListViewController.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/16/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "WeatherDayListViewController.h"
#import "ForecastDetailsViewController.h"
#import "ForeCastDays.h"
#import "ConsolidatedWeather.h"
#import "Parent.h"
#import "Sources.h"
#import "ForecastAllDaysTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface WeatherDayListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,TSMessageViewProtocol>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) ForeCastDays *forecastDays;
@end

@implementation WeatherDayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNibs];
    
    self.tableview.tableFooterView = [UIView new];

    [self setupDatasource];
}
#pragma mark - RegisterNibs

-(void)registerNibs {
    [self.tableview registerNib:[UINib nibWithNibName:@"ForecastAllDaysTableViewCell" bundle:nil] forCellReuseIdentifier:@"ForecastAllDaysTableViewCell"];
}
#pragma mark - ServerInvoker

-(void)setupDatasource{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    // Check if connected to internet
    if ([ServerInvoker connectedToInternet]) {
        // Api Call
        
        [SVProgressHUD show];
        [ServerInvoker getAllForecast:@{@"woeid" : self.woeid}
                         blockSuccess:^(id  _Nonnull forecast)
         {
             
             
             self.forecastDays = forecast;
             
             NSData *keyArhiver = [NSKeyedArchiver archivedDataWithRootObject:self.forecastDays requiringSecureCoding:NO error:nil];
             
             [currentDefaults setObject:keyArhiver forKey:self.woeid];
             [self.tableview  reloadData];
             
             [SVProgressHUD dismiss];
             
             
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
        
        NSData *data = [currentDefaults objectForKey:self.woeid];
        self.forecastDays = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (self.forecastDays == nil) {
            self.tableview.emptyDataSetSource = self;
            self.tableview.emptyDataSetDelegate = self;
        }
        [self.tableview  reloadData];
    }
}

#pragma mark - UITableviewDelegates and datasorce

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 173;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.forecastDays.consolidatedWeather.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastAllDaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastAllDaysTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ConsolidatedWeather *daysShortInfo = self.forecastDays.consolidatedWeather[indexPath.row];
    [cell setupCell:daysShortInfo];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsolidatedWeather *daysShortInfo = self.forecastDays.consolidatedWeather[indexPath.row];
    [self performSegueWithIdentifier:@"WeatherDayListViewController" sender:daysShortInfo.applicableDate];
}

#pragma mark PrepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ForecastDetailsViewController *vc = segue.destinationViewController;
    vc.strDate = sender;
    vc.woeid = self.woeid;
}

#pragma mark - EmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    // The attributed string for the title of the empty state:
    return   [[NSAttributedString alloc] initWithString:@"No preview available"];;
}




@end
