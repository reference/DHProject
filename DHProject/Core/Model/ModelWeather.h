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

#import "ModelBase.h"
/*
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
}
*/
@interface ModelWeather : ModelBase

@property (nonatomic, strong) NSString *weaid;
@property (nonatomic, strong) NSString *days;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *cityno;
@property (nonatomic, strong) NSString *citynm;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *weather_icon;
@property (nonatomic, strong) NSString *weather_icon1;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *winp;
@property (nonatomic, strong) NSString *temp_high;
@property (nonatomic, strong) NSString *temp_low;
@property (nonatomic, strong) NSString *humi_high;
@property (nonatomic, strong) NSString *humi_low;
@property (nonatomic, strong) NSString *weatid;
@property (nonatomic, strong) NSString *weatid1;
@property (nonatomic, strong) NSString *windid;
@property (nonatomic, strong) NSString *winpid;

/*!
 *  五日天气
 *
 *  @return 数组
 */
+ (NSArray *)fiveDaysWeather;
@end
