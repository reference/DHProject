//
//	Copyright (c) Scott Ban
//	https://github.com/reference/DHProject
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#import "ViewController.h"
#import "API_Weather.h"
#import "ModelWeather.h"
#import "DCKeyValueObjectMapping.h"

@interface ViewController (){
    NSMutableArray *_dataSource;
}
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    
    //初始化数据库
    [DB setupDB];
    
    [self api_five_days_weather];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self data_load];
}

#pragma mark - load data

- (void)data_load
{
    NSArray *arr = [ModelWeather fiveDaysWeather];
    if (arr && arr.count) {
        [_dataSource setArray:arr];
        [self.tableView reloadData];
    }
}
#pragma mark - api

- (void)api_five_days_weather
{
//    http://api.k780.com:88/?app=weather.future&weaid=1&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    [DHAPIMessage sendAPIMessage:API_Weather.API_FIVE_DAYS_WEATHER
                          params:@{@"app": @"weather.future",
                                   @"weaid":@"1",
                                   @"appkey":@"10003",
                                   @"sign":@"b59bc3ef6191eb9f747dd4e83c99f2a4",
                                   @"format":@"json"
                                   }
                         sending:^(BeeMessage *msg) {
                         }
                         succeed:^(BeeMessage *msg) {
                             /*
                              {
                              "success": "1",
                              "result": [
                              {
                              "weaid": "1",
                              "days": "2015-02-17",
                              "week": "星期二",
                              "cityno": "beijing",
                              "citynm": "北京",
                              "cityid": "101010100",
                              "temperature": "12℃/-2℃",
                              "humidity": "0℉/0℉",
                              "weather": "晴",
                              "weather_icon": "http://api.k780.com:88/upload/weather/d/0.gif",
                              "weather_icon1": "http://api.k780.com:88/upload/weather/n/0.gif",
                              "wind": "北风转无持续风向",
                              "winp": "3-4级转微风",
                              "temp_high": "12",
                              "temp_low": "-2",
                              "humi_high": "0",
                              "humi_low": "0",
                              "weatid": "1",
                              "weatid1": "1",
                              "windid": "126",
                              "winpid": "129"
                              },...
                              ]
                              }
                              */
                             NSNumber *success = msg.output[@"success"];
                             if ([success integerValue] == 1) {
                                 
                                 [self data_load];
                             }
                             else{
                                 NSLog(@"%@",msg.errorDesc);
                             }
                         }
                          failed:^(BeeMessage *msg) {
                              NSLog(@"%@",msg.errorDesc);
                          }
                        canceled:^(BeeMessage *msg) {
                            NSLog(@"%@",msg.errorDesc);
                        }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    ModelWeather *weather = _dataSource[indexPath.row];
    cell.textLabel.text = weather.citynm;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@,%@",weather.days,weather.weather,weather.temperature];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:weather.weather_icon]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        cell.imageView.image = [UIImage imageWithData:data];
        [tableView reloadData];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
