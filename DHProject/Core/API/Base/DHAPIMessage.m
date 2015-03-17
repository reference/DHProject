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

#import "DHAPIMessage.h"

@implementation DHAPIMessage

+ (BeeMessage *)message
{
    return [[DHAPIMessage alloc] init];
}

+ (BeeMessage *)message:(NSString *)msg
{
    DHAPIMessage * bmsg = [[DHAPIMessage alloc] init];
    bmsg.message = msg;
    return bmsg;
}

+ (BeeMessage *)message:(NSString *)msg timeoutSeconds:(NSUInteger)seconds
{
    DHAPIMessage * bmsg = [[DHAPIMessage alloc] init];
    bmsg.message = msg;
    bmsg.seconds = seconds ? seconds : 60.f;
    return bmsg;
}

+ (BeeMessage *)message:(NSString *)msg responder:(id)responder
{
    DHAPIMessage * bmsg = [[DHAPIMessage alloc] init];
    bmsg.message = msg;
    bmsg.responder = responder;
    return bmsg;
}

+ (BeeMessage *)message:(NSString *)msg responder:(id)responder timeoutSeconds:(NSUInteger)seconds
{
    DHAPIMessage * bmsg = [[DHAPIMessage alloc] init];
    bmsg.message = msg;
    bmsg.responder = responder;
    bmsg.seconds = seconds ? seconds : 60.f;
    return bmsg;
}

- (BeeHTTPRequest *)GET:(NSString *)url
{
    return [self HTTP_GET:url];
}

- (BeeHTTPRequest *)POST:(NSString *)url
{
    return [self HTTP_POST:url];
}

- (BeeHTTPRequestBlockSN)HTTP_GET {
    BeeHTTPRequestBlockSN block = ^ BeeHTTPRequest * ( NSString * url ,...)
    {
        BeeHTTPRequest * req = [BeeHTTPRequestQueue GET:url];
        [req addResponder:self];
        return [DHAPIHeader makeRequestHeaders:req];
    };
    return block;
}

- (BeeHTTPRequestBlockSN)HTTP_POST {
    BeeHTTPRequestBlockSN block = ^ BeeHTTPRequest * ( NSString * url ,...)
    {
        BeeHTTPRequest * req = [BeeHTTPRequestQueue POST:url];
        [req addResponder:self];
        return [DHAPIHeader makeRequestHeaders:req];
    };
    
    return block;
}

- (BeeHTTPRequest *)HTTP_GET:(NSString *)url {
    return [DHAPIHeader makeRequestHeaders:[super HTTP_GET:url]];
}

- (BeeHTTPRequest *)HTTP_POST:(NSString *)url {
    return [DHAPIHeader makeRequestHeaders:[super HTTP_POST:url]];
}


- (void)handleRequest:(BeeHTTPRequest *)request
{
    [super handleRequest:request];
    
    if ( request.sending && !request.sendProgressed && !request.recvProgressed)
    {
        if ( [request.requestMethod isEqualToString:@"GET"] )
        {
            NSString *fullUrl = [request.url asNSString];
            NSString *param = [fullUrl componentsSeparatedByString:@"?"][1];
            
            NSLog(@"\n\n-----------------------------【请求（GET）】-----------------------------------------\n地址 : %@\n参数 : %@ \n\n\n",[fullUrl componentsSeparatedByString:@"?"][0],[param stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        }
        else if ( [request.requestMethod isEqualToString:@"POST"] )
        {
            NSLog(@"\n\n-----------------------------【请求（POST）】-----------------------------------------\n地址 : %@\n参数 : %@ \n请求头 : %@\n\n\n",[request.url asNSString],[[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding],request.requestHeaders);
        }
    }
    else if ( request.failed )
    {
        NSLog(@"请求失败 %@, REQUEST > %@",request.responseStatusMessage, request);
    }
    else if ( request.succeed )
    {
        DHAPIHeader * header = [[DHAPIHeader alloc] init];
        [header parseResponseHeaders:request];
        
        id response = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *fullUrl = [request.url asNSString];
        NSLog(@"\n\n-----------------------------【响应】-------------------------------------------------\n地址 : %@ \n响应内容 : %@ \n\n\n",[fullUrl componentsSeparatedByString:@"?"][0],response);
    }
}

#pragma mark - Block
+ (DHAPIMessage *)sendAPIMessage:(NSString *)msg withBlock:(APIMessageBlock)block
{
    return [DHAPIMessage sendAPIMessage:msg withBlock:block timeoutSeconds:30];
}

+ (DHAPIMessage *)sendAPIMessage:(NSString *)msg withBlock:(APIMessageBlock)block timeoutSeconds:(NSTimeInterval)seconds {
    DHAPIMessage * bmsg = [[DHAPIMessage alloc] init];
    bmsg.message = msg;
    bmsg.responder = bmsg;
    bmsg.handleMessageBlock = block;
    bmsg.seconds = seconds ? seconds : 60.f;
    [bmsg send];
    return bmsg;
}

+ (void)sendAPIMessage:(NSString *)msg
                params:(NSDictionary *)pragma
               sending:(APIMessageBlock)sending
               succeed:(APIMessageBlock)succeed
                failed:(APIMessageBlock)failed
              canceled:(APIMessageBlock)canceled
{
    [[DHAPIMessage sendAPIMessage:msg withBlock:^(BeeMessage *msg) {
        if (msg.sending) {
            if (sending) {
                sending(msg);
            }
        }
        else if (msg.succeed){
            if (succeed) {
                succeed(msg);
            }
        }
        else if (msg.failed){
            if (failed) {
                failed(msg);
            }
        }
        else if (msg.cancelled){
            if (canceled) {
                canceled(msg);
            }
        }
    }] inputDictionary:pragma];
}

#pragma mark  - private

- (BeeMessage*)inputDictionary:(NSDictionary *)params
{
    [self.input setDictionary:params];
    return self;
}

- (void)handleMessage:(BeeMessage *)msg {
    if (self.handleMessageBlock)
    {
        self.handleMessageBlock(msg);
    }
}

@end
