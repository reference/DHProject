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

#import "DHAPIHeader.h"

@implementation DHAPIHeader
{
    NSString * _urAgent;
    NSString * _requestUUID;
}

DEF_SINGLETON(DHAPIHeader)

- (NSString *)userAgent
{
    if ( _urAgent == nil)
    {
        _urAgent = @"userAgent";
    }
    return _urAgent;
}

- (NSString *)requestUUID
{
    return _requestUUID;
}

+ (BeeHTTPRequest *)makeRequestHeaders:(BeeHTTPRequest *)request
{
    //请求参数配置
    
    request.userAgent = [[DHAPIHeader sharedInstance] userAgent];
    
    request.shouldAttemptPersistentConnection = NO; //Fix ASI BUG
    
    request.allowCompressedResponse = YES; //允许服务器压缩
    
    //指定默认的POST的方式
    request.postFormat = ASIURLEncodedPostFormat;
    
    return request;
}

- (BeeHTTPRequest *)parseResponseHeaders:(BeeHTTPRequest *)request
{
    _requestUUID = [request.responseHeaders stringAtPath:@"/REQUEST_UUID"];
    return request;
}

@end
