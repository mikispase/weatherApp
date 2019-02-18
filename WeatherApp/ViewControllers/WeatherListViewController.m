//
//  WeatherListViewController.m
//  WeatherApp
//
//  Created by Dimitar Spasovski on 2/15/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

#import "WeatherListViewController.h"
#import "WeatherDayListViewController.h"
#import "CityID.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface WeatherListViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,TSMessageViewProtocol>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *weatherPlaces;
@end

@implementation WeatherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.title = @"World Weather List";
    
    [self setupDatasorce];
    
    [self addRightBarButton];
    
    [self initNotificationView];
}

-(void)initNotificationView{
    // Notification View
    [TSMessage setDefaultViewController:self];
    [TSMessage setDelegate:self];
    [self.navigationController.navigationBar setTranslucent:YES];
    if ( ! [ServerInvoker connectedToInternet]) {
        [self notificationViewAlert];
    }
}

#pragma mark - Datasorce
-(void)setupDatasorce
{
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsforecastkey];
    // Check if exist datasorce
    if (dic.allKeys.count == 0 && dic == nil) {
        
        // Default Places
        self.weatherPlaces = [NSMutableDictionary dictionary];
        [self.weatherPlaces setObject:@"Sofia" forKey:@"839722"];
        [self.weatherPlaces setObject:@"New York" forKey:@"2459115"];
        [self.weatherPlaces setObject:@"Tokyo" forKey:@"1118370"];
        
        [self saveDatasource];
    }
    else{
        self.weatherPlaces = [dic mutableCopy];
        
        if (self.weatherPlaces.allKeys.count == 0) {
            // Empty Datasorce
            self.tableView.emptyDataSetSource = self;
            self.tableView.emptyDataSetDelegate = self;
            self.tableView.tableFooterView = [UIView new];
            [self.tableView reloadData];
        }
    }
}
#pragma mark - RightBarButton init

-(void)addRightBarButton{
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                     target:self
                                     action:@selector(addNewLocation)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = searchButton;
}

#pragma mark - UITableViewDelegates & Datasorce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weatherPlaces.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherList"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeatherList"];
    cell.textLabel.text = [self.weatherPlaces objectForKey:[[self.weatherPlaces allKeys] objectAtIndex:indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"WeatherListViewController" sender:[self.weatherPlaces allKeys][indexPath.row]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray* allKeys = [self.weatherPlaces allKeys];
        [self.weatherPlaces removeObjectForKey:allKeys[indexPath.row]];
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        
        // Delete storage data information (format like woeid/date )
        for (NSString *key in [userDef dictionaryRepresentation].allKeys) {
            if ([key hasPrefix:allKeys[indexPath.row]]) {
                [userDef removeObjectForKey:key];
            }
        }
        
        [self saveDatasource];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
        
    }
}

#pragma mark - RightButton Action - search new location
-(void)addNewLocation
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please add new location for weather forecast" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"";
        
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // Add new location
        // Call Api
        
        UITextField *textField = [alertController.textFields firstObject];
        
        if ( textField.text.length) {
            [self getNewForecastLocation:textField.text];
        }
        
    }];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        // Cancel Button pressed
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#pragma mark - API Calls

-(void)getNewForecastLocation:(NSString *)location
{    
    [SVProgressHUD show];
    
    [ServerInvoker getNewForecast: @{@"location" : location}
                     blockSuccess:^(id  _Nonnull forecast)
     {
         
         DLog(@"JSON %@",[ServerInvoker preetyJsonFormater:forecast]);
         
         CityID *city = [CityID modelObjectWithDictionary:[forecast  firstObject]];
         
         if (city.title.length) {
             [self.weatherPlaces setObject:city.title forKey:[[NSNumber numberWithDouble:city.woeid] stringValue]];
             [self saveDatasource];
         }
         else
         {
             [self showErrorMessage:@"No data for the selected location" withTitle:@"" buttonTitle:@"ОК" buttonPressed:^{}];
         }
         [self.tableView reloadData];
         
         [SVProgressHUD dismiss];
         
     } errorCallback:^(NSError * _Nonnull errorMessage, NSInteger statusCode, NSString * _Nonnull errorMsg) {
         NSLog(@"errorMessage %@",errorMessage.description );
         [SVProgressHUD dismiss];
         
         [self showErrorMessage:[errorMessage.userInfo valueForKey:NSLocalizedDescriptionKey] withTitle:@"" buttonTitle:@"" buttonPressed:^{}];
     }];
    
}

#pragma mark - SaveDatasorce

-(void)saveDatasource{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:self.weatherPlaces forKey:kDefaultsforecastkey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
}
#pragma mark - PrepareForSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [(WeatherDayListViewController *)segue.destinationViewController setWoeid:sender];
}

#pragma mark - EmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    // The attributed string for the title of the empty state:
    return   [[NSAttributedString alloc] initWithString:@"No preview available"];;
}


@end
