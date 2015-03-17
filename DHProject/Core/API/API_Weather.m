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

#import "API_Weather.h"
#import "DCKeyValueObjectMapping.h"
#import "ModelWeather.h"

@implementation API_Weather

#pragma mark 获得5日天气状况
DEF_MESSAGE( API_FIVE_DAYS_WEATHER )
- (void)API_FIVE_DAYS_WEATHER:(BeeMessage *)msg
{
    [self index:msg];
    [self getWithMessage:msg host:API_WEATHER_BASE_HOST path:API_WEATHER_BASE_PATH];
    
    //后台数据处理
    if (msg.succeed) {
        //数据存储在此写
        NSNumber *success = msg.output[@"success"];
        if ([success integerValue] == 1) {
            
            DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: [ModelWeather class]];
            
            NSArray *result = msg.output[@"result"];
            for (NSDictionary *dic in result) {
                ModelWeather *weather = [parser parseDictionary:dic];
                
                [weather insert];
            }
        }
    }
}

@end
