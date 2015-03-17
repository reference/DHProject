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

#import "DHAPIBase.h"
#import "JSONKit.h"

@implementation DHAPIBase

DEF_NOTIFICATION(NOTIFY_NETWORKING_ERROR)

#pragma mark - 

- (void)index:(BeeMessage *)msg
{
    [super index:msg];
    if ( msg.created )
    {
        //消息创建时
    }
    else if ( msg.sending )
    {
        //消息发送时
    }
    else if ( msg.succeed )
    {
        //消息成功
        if ( msg.useCache == NO )
        {
            id result = [msg.response objectFromJSONData];
            
            if ( result == nil )
            {
                result = [NSDictionary dictionaryWithDictionary:msg.output];
            }
            
            if ([result isKindOfClass:[NSDictionary class]] )
            {
                [msg.output setDictionary:result];
            }
            else if ([result isKindOfClass:[NSArray class]] )
            {
                [msg.output setValue:result forKey:@"array"];
            }
            else
            {
                [msg.output setDictionary:result];
            }
        }
    }
    else if ( msg.failed ) {
        //失败
        //判断是不是断网问题
        if ([msg.errorDomain isEqualToString:BeeMessage.ERROR_DOMAIN_NETWORK]) {
            //发出通知
            [self postNotification:DHAPIBase.NOTIFY_NETWORKING_ERROR];
        }
    }
    else if ( msg.cancelled )
    {
        //被取消
    }
}

- (void)getWithMessage:(BeeMessage *)msg host:(NSString *)host path:(NSString *)path
{
    if ( msg.sending )
    {
        NSString * baseURL = [host stringByAppendingString:path];
        
        NSString * callURL = baseURL;
        if (msg.input && msg.input.count) {
            callURL = [baseURL urlByAppendingDict:msg.input];
        }
        msg.HTTP_GET( callURL );
    }
}

- (void)postWithMessage:(BeeMessage *)msg host:(NSString *)host path:(NSString *)path
{
    if ( msg.sending )
    {
        NSString * baseURL = [host stringByAppendingString:path];

        BeeHTTPRequest * request = msg.HTTP_POST( baseURL );
        for (NSString * key in msg.input)
        {
            request.PARAM( key, [msg.input objectForKey:key]);
        }
    }
}

@end

